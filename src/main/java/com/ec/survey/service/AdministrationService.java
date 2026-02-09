package com.ec.survey.service;

import com.ec.survey.enumerator.GlobalPrivilege;
import com.ec.survey.enumerator.LocalPrivilege;
import com.ec.survey.exception.FrozenCredentialsException;
import com.ec.survey.exception.MessageException;
import com.ec.survey.model.*;
import com.ec.survey.model.administration.*;
import com.ec.survey.model.survey.Survey;
import com.ec.survey.tools.Constants;
import com.ec.survey.tools.ConversionTools;
import com.ec.survey.exception.LoginAlreadyExistsException;
import com.ec.survey.tools.Tools;

import org.apache.commons.io.IOUtils;
import org.hibernate.Hibernate;
import org.hibernate.query.Query;
import org.hibernate.query.NativeQuery;
import org.hibernate.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.util.StringUtils;

@Service("administrationService")
public class AdministrationService extends BasicService {

	@Autowired
	private SqlQueryService sqlQueryService;

	private @Value("${admin.user}") String adminuser;
	private @Value("${admin.password}") String adminpassword;
	private @Value("${stress.user}") String stressuser;
	private @Value("${stress.password}") String stresspassword;

	private @Value("${smtpserver}") String smtpServer;
	private @Value("${smtp.port}") String smtpPort;
	private @Value("${sender}") String sender;
	private @Value("${server.prefix}") String host;

	public String getAdminUser() {
		return adminuser;
	}

	public String getAdminPassword() {
		return adminpassword;
	}

	public String getStressUser() {
		return stressuser;
	}

	public String getStressPassword() {
		return stresspassword;
	}

	/**
	 * Consolidates authentication logic into one single database connection.
	 * Marks as read-only to optimize database interaction.
	 */
	@Transactional(readOnly = true)
	public User authenticateUser(String username, String password) throws MessageException {
		// 1. Get User
		User user = getUserForLogin(username, false);
		if (user == null) {
			return null; // Username not found
		}

		// Checking for legacy hashed code
		checkUserPassword(user, password);

		// 2. Check Password
		// Note: Replace with your actual password verification logic
		if (!Tools.isPasswordValid(user.getPassword(), password + user.getPasswordSalt())) {
			return null; // Password mismatch
		}

		// 3. Check Banned/Frozen Status
		if (!checkEmailsNotBanned(user.getAllEmailAddresses())) {
			throw new FrozenCredentialsException("User is banned!");
		}

		return user;
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Role> getAllRoles() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM Role");
		return query.list();
	}

	@Transactional(readOnly = true)
	public Map<Integer, Role> getAllRolesAsMap() {
		List<Role> roles = getAllRoles();
		Map<Integer, Role> result = new HashMap<>();
		for (Role role : roles) {
			result.put(role.getId(), role);
		}
		return result;
	}

	@Transactional(readOnly = true)
	public Role getRole(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(Role.class, id);
	}

	@Transactional(readOnly = true)
	public Role getRole(String name) {
		Session session = sessionFactory.getCurrentSession();
		Query<Role> query = session.createQuery("FROM Role r where r.name = :name", Role.class).setParameter("name", name);
		List<Role> list = query.list();

		if (!list.isEmpty())
		{
			return list.get(0);
		}

		return null;
	}

	@Transactional
	public void createRole(Role role) {
		Session session = sessionFactory.getCurrentSession();
		session.persist(role);
	}

	@Transactional
	public void updateRole(Role role) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(role);
	}

	@Transactional
	public void deleteRole(int id) {
		Role role = getRole(id);
		Session session = sessionFactory.getCurrentSession();
		session.remove(role);
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<User> getAllUsers() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM User");
		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	public List<Integer> getAllUserIDs() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("SELECT u.id FROM User u");
		return query.list();
	}

	@Transactional(readOnly = true)
	public List<User> getUsers(UserFilter filter, SqlPagination sqlPagination) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		HashMap<String, Object> parameters = new HashMap<>();
		// Creating the query with the specific return type is preferred in Hibernate 6
		Query<User> query = session.createQuery(getHql(filter, parameters, false), User.class);
		// Modern setParameters: You can iterate or use a helper, but manual casting is largely unnecessary
		parameters.forEach(query::setParameter);
		return query.setFirstResult(sqlPagination.getFirstResult())
				.setMaxResults(sqlPagination.getMaxResult())
				.getResultList(); // 'list()' is still available but 'getResultList()' is the JPA standard
	}

	@Transactional(readOnly = true)
	public User getUser(UserFilter filter) throws Exception {
		Session session = sessionFactory.getCurrentSession();

		HashMap<String, Object> parameters = new HashMap<>();
		Query query = session.createQuery(getHql(filter, parameters, false));
		sqlQueryService.setParameters(query, parameters);

		@SuppressWarnings("unchecked")
		List<User> list = query.setReadOnly(true).setMaxResults(1).list();

		if (!list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	@Transactional(readOnly = true)
	public User getUser(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		return session.get(User.class, id);
	}

	@Transactional
	public void createUser(User user) throws LoginAlreadyExistsException {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.createQuery("FROM User u where u.login = :login").setParameter("login", user.getLogin());
		@SuppressWarnings("unchecked")
		List<User> list = query.list();

		if (!list.isEmpty())
		{
			throw new LoginAlreadyExistsException();
		}
		
		session.persist(user);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void updateUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		user = session.merge(user);

		String disabled = settingsService.get(Setting.CreateSurveysForExternalsDisabled);
		if (disabled.equalsIgnoreCase("true") && user.getGlobalPrivileges().get(GlobalPrivilege.ECAccess) == 0) {
			user.setCanCreateSurveys(false);
		}

		session.setReadOnly(user, false);
		session.merge(user);
	}

	@Transactional
	public boolean checkUserPassword(User user, String rawPassword) {
		String md5hash = Tools.md5hash(rawPassword);

		if (user.getPassword().equals(md5hash)) {
			// replace md5 hash by salted SHA-512 hash
			Session session = sessionFactory.getCurrentSession();
			user.setPasswordSalt(Tools.newSalt());
			user.setPassword(Tools.hash(rawPassword + user.getPasswordSalt()));
			session.merge(user);
			return true;
		}

		return false;
	}
	
	@Transactional
	public String setUserDeleteRequested(int id) throws IOException, MessageException {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);
		String login = user.getLogin();
		String code = UUID.randomUUID().toString();
		
		String url = host + "deleteaccount/" + user.getId() + Constants.PATH_DELIMITER + code;

        String body = "Dear " + user.getName() + ",<br /><br />Please confirm the deletion of your account by clicking the following link:<br /><br/>" +
                "<a href='" + url + "'>" + url + "</a><br /><br />" +
                "This link will remain valid for three days. If the deletion is not finalised in this time, your account will remain active." +
                "<br /><br /><div style='text-align: center; border-top: 1px solid #999; border-bottom: 1px solid #999; padding: 10px; margin-top: 20px; margin-bottom: 10px; color: #999'>Please do not reply to this email</div>";
		
		InputStream inputStream = servletContext.getResourceAsStream("/WEB-INF/Content/mailtemplateeusurvey.html");
		String text = IOUtils.toString(inputStream, StandardCharsets.UTF_8).replace("[CONTENT]", body).replace("[HOST]",host);
		
		mailService.SendHtmlMail(user.getEmail(), sender, sender, "Please confirm the deletion of your EUSurvey account", text, null, null, null, false);

		user.setDeleteCode(code);
		user.setDeleteDate(new Date());
		user.setDeleteRequested(true);		
		session.merge(user);
		return login;
	}
	
	@Transactional
	public void confirmUserDeleteRequest(int id, String code) throws MessageException {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);
		
		if (user == null)
		{
			throw new MessageException("User unknown");
		}
		
		if (!user.getDeleteCode().equals(code))
		{
			throw new MessageException("Wrong code");
		}
		
		Calendar cal = Calendar.getInstance();  
		cal.setTime(new Date());  
		cal.add(Calendar.DAY_OF_YEAR, -3);  
		Date threedaysago = cal.getTime(); 
		
		if (user.getDeleteDate().before(threedaysago))
		{
			throw new MessageException("Request too old");
		}
		
		user.setDeleted(true);		
		session.merge(user);
	}
	
	@Transactional
	public List<Integer> getUserAccountsForDeletion() {
		Session session = sessionFactory.getCurrentSession();
		NativeQuery query = session.createNativeQuery("SELECT USER_ID FROM USERS WHERE USER_DELETED = 1 AND USER_DELDATE < NOW() - INTERVAL 7 DAY");
		
		@SuppressWarnings("rawtypes")
		List users = query.list();
		List<Integer> result = new ArrayList<>();
		
		for (Object o: users)
		{
			result.add(ConversionTools.getValue(o));
		}
		
		return result;
	}

	@Transactional
	public String deleteUser(int id, boolean onlySetFlag) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);
		String login = user.getLogin();
		
		if (onlySetFlag) {
			user.setDeleteDate(new Date());
			user.setDeleteRequested(true);	
			user.setDeleted(true);		
			session.merge(user);
		} else {
			session.remove(user);
		}
		
		return login;
	}

	@Transactional(readOnly = true)
	public String[] getLoginsForPrefix(String term, String emailterm, boolean forPrivileges, int maxResults) {
		Session session = sessionFactory.getCurrentSession();

		Query query;
		if (term.length() > 0 && (emailterm != null && emailterm.length() > 0)) {
			query = session.createQuery("FROM User u where u.login like :login and u.email like :email and u.type = :type order by u.login asc").setParameter("type", User.SYSTEM)
					.setParameter("login", "%" + term + "%").setParameter(Constants.EMAIL, "%" + emailterm + "%");
		} else if (emailterm != null && emailterm.length() > 0) {
			query = session.createQuery("FROM User u where u.email like :email and u.type = :type order by u.login asc").setParameter("type", User.SYSTEM).setParameter(Constants.EMAIL, "%" + emailterm + "%");
		} else {
			query = session.createQuery("FROM User u where u.login like :login and u.type = :type order by u.login asc").setParameter("type", User.SYSTEM).setParameter("login", "%" + term + "%");
		}

		@SuppressWarnings("unchecked")
		List<User> list = query.setMaxResults(maxResults).list();
		String[] result = new String[list.size()];
		int counter = 0;
		for (User user : list) {
			if (forPrivileges) {
				result[counter++] = "<tr data-id='" + user.getId() + "' id='" + user.getLogin() + "'><td>" + user.getEmail() + "</td><td>" + user.getLogin() + "</td><td>"
						+ (user.getGivenName() == null ? "&nbsp;" : user.getGivenName()) + "</td><td>" + (user.getSurName() == null ? "&nbsp;" : user.getSurName()) + "</td><td>&nbsp;</td></tr>";
			} else {
				result[counter++] = user.getLogin();
			}
		}

		return result;
	}

	@Transactional(readOnly = true)
	public String[] checkLoginsForEmails(List<String> emails) {

		Session session = sessionFactory.getCurrentSession();
		for(String e : emails) {
			e = "%" + e + "%";
		}

		Query query = null;
		if (emails != null && !emails.isEmpty()) {
			query = session.createQuery("FROM User u where u.email IN :email order by u.login asc").setParameter(Constants.EMAIL, emails);
		}

		@SuppressWarnings("unchecked")
		List<User> list = query.setMaxResults(5).list();
		String[] result = new String[list.size()];
		int counter = 0;
		for (User user : list) {
			result[counter++] = user.getEmail();
		}

		return result;
	}

	@Transactional(readOnly = true)
	public User getUserForLogin(String login) {
		Session session = sessionFactory.getCurrentSession();

		String hql = "FROM User u where u.login = :login";

		Query query = session.createQuery(hql).setParameter("login", login);

		@SuppressWarnings("unchecked")
		List<User> list = query.list();

		if (!list.isEmpty())
		{
			return list.get(0);
		}

		return null;
	}

	@Transactional(readOnly = true)
	public Map<String, String> getECASUserLoginsByEmail() {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.createNativeQuery("SELECT USER_EMAIL, USER_LOGIN FROM USERS WHERE USER_TYPE = 'ECAS'");

		@SuppressWarnings("rawtypes")
		List res = query.list();

		HashMap<String, String> result = new HashMap<>();

		for (Object o : res) {
			Object[] a = (Object[]) o;
			if (!result.containsKey((String) a[0])) {
				result.put((String) a[0], (String) a[1]);
			}
		}

		return result;
	}
	
	@Transactional(readOnly = true)
	public User getUserForLoginAndInitialize(String login, boolean ecas) throws MessageException {
		User user = getUserForLogin(login, ecas);
		if (user != null) {
			Hibernate.initialize(user.getRoles());
		}
		return user;
	}

	@Transactional(readOnly = true)
	public User getUserForLogin(String login, boolean ecas) throws MessageException {

		Session session = sessionFactory.getCurrentSession();

		String hql = "FROM User u where u.login = :login  AND u.type = :type";

		Query query = session.createQuery(hql).setParameter("login", login);

		if (ecas) {
			query.setParameter("type", User.ECAS);
		} else {
			query.setParameter("type", User.SYSTEM);
		}

		@SuppressWarnings("unchecked")
		List<User> list = query.list();

		if (list.isEmpty())
			throw new MessageException("No user found for login " + login);
		if (list.size() > 1)
			throw new MessageException("Multiple users found for login " + login);

		return list.get(0);
	}

	@Transactional(readOnly = true)
	public List<User> getUserLoginsByEmail(String email, int limit) {
			Session session = sessionFactory.getCurrentSession();
			email = "%" + email + "%";
			Query<User> query = session.createQuery("FROM User u where u.email like :email order by u.login asc", User.class).setParameter(Constants.EMAIL, email);
			return query.setMaxResults(limit).list();
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void save(UsersConfiguration userConfiguration) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(userConfiguration);
	}

	@Transactional(readOnly = true)
	public UsersConfiguration getUsersConfiguration(int userId) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM UsersConfiguration c where c.userId = :userId").setParameter("userId", userId);

		@SuppressWarnings("unchecked")
		List<UsersConfiguration> list = query.list();
		if (list.isEmpty())
		{
			return null;
		}
		return list.get(0);
	}

	@Transactional()
	public void sendValidationEmail(User user) throws Exception {
		Session session = sessionFactory.getCurrentSession();

		user.setValidationCode(UUID.randomUUID().toString());
		user.setValidationCodeGeneration(new Date());
		session.merge(user);

		String link = host + "validate/" + user.getId() + Constants.PATH_DELIMITER + user.getValidationCode();

		String body = "Dear " + user.getLogin() + ",<br /><br />Please validate your account by clicking the link below: <br /><br /> <a href=\"" + link + "\">" + link + "</a>";

		mailService.SendHtmlMail(user.getEmail(), sender, sender, "EUSurvey Registration", body, null);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public boolean sendNewEmailAdressValidationEmail(User user) {
		try {
			Session session = sessionFactory.getCurrentSession();
			user.setValidationCode(UUID.randomUUID().toString());
			user.setValidationCodeGeneration(new Date());
			session.merge(user);

			String link = host + "validateNewEmail/" + user.getId() + Constants.PATH_DELIMITER + user.getValidationCode();

			String body = "Dear " + user.getLogin() + ",<br /><br />Please confirm your email change by clicking the link below: <br /><br /> <a href=\"" + link + "\">" + link + "</a>";

			InputStream inputStream = servletContext.getResourceAsStream("/WEB-INF/Content/mailtemplateeusurvey.html");
			String text = IOUtils.toString(inputStream, StandardCharsets.UTF_8).replace("[CONTENT]", body).replace("[HOST]", host);

			mailService.SendHtmlMail(user.getEmailToValidate(), sender, sender, "EUSurvey Confirmation", text, null);
		} catch (Exception ex) {
			logger.error(ex.getLocalizedMessage(), ex);
			return false;
		}
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public boolean validateUser(int id, String code) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);

		if (user != null && user.getValidationCode() != null && user.getValidationCode().equalsIgnoreCase(code)) {
			user.setValidated(true);
			session.merge(user);

			return true;
		}

		return false;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public boolean validateNewEmail(HttpServletRequest request, int id, String code) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, id);

		if (user != null && user.getValidationCode() != null && user.getValidationCode().equalsIgnoreCase(code) && user.getEmailToValidate() != null) {
			String oldEmail = user.getEmail();
			if (user.getOtherEmail() == null) {
				user.setOtherEmail(oldEmail);
			} else {
				if (!user.getOtherEmail().endsWith(";")) {
					user.setOtherEmail(user.getOtherEmail() + ";" + oldEmail);
				} else {
					user.setOtherEmail(user.getOtherEmail() + oldEmail);
				}
			}

			user.setEmail(user.getEmailToValidate());
			user.setEmailToValidate(null);
			user.setValidationCode(null);
			session.merge(user);
			sessionService.setCurrentUser(request, user);
			return true;
		}

		return false;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public OneTimePasswordResetCode createOneTimePasswordResetCode(User user) {
		OneTimePasswordResetCode code = new OneTimePasswordResetCode(user);
		Session session = sessionFactory.getCurrentSession();
		session.persist(code);
		return code;
	}

	@Transactional(readOnly = true)
	public OneTimePasswordResetCode getOneTimePasswordResetCode(String code) throws MessageException {
		Session session = sessionFactory.getCurrentSession();

		Query query = session.createQuery("FROM OneTimePasswordResetCode c where c.code = :code").setParameter("code", code);
		@SuppressWarnings("unchecked")
		List<OneTimePasswordResetCode> list = query.list();
		if (list.isEmpty())
		{
			throw new MessageException("No item found for code " + code);
		}
		if (list.size() > 1)
		{
			throw new MessageException("Multiple items found for code " + code);
		}
		
		return list.get(0);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void add(EcasUser eu) {
		Session session = sessionFactory.getCurrentSession();
		session.merge(eu);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void removeUserGroups(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createNativeQuery("DELETE FROM  ECASGROUPS  where  eg_id = :id").setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void deactivateEcasUser(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("UPDATE EcasUser u SET u.deactivated = true WHERE u.id = :id").setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void deactivateEcasUsers(List<Integer> ids) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("UPDATE EcasUser u SET u.deactivated = true WHERE u.id = :id");
		int counter = 0;
		for (int id : ids) {
			query.setParameter("id", id);
			query.executeUpdate();
			counter += 1;
			if (counter % 10000 == 0) {
                logger.info("{} EcasUsers deactivated", counter);
			}
		}
	}

	@Transactional(readOnly = true)
	public int getNumberOfUsers(UserFilter filter) {
		Session session = sessionFactory.getCurrentSession();

		HashMap<String, Object> parameters = new HashMap<>();
		// Ensure getHql returns a count query (e.g., "select count(u) from User u...")
		Query<Long> query = session.createQuery(getHql(filter, parameters, true), Long.class);

		// Hibernate 6 handles parameter type inference automatically
		parameters.forEach(query::setParameter);

		Long count = query.uniqueResult();

		// Safely convert Long to int for your return type
		return count != null ? count.intValue() : 0;
	}

	private String getHql(UserFilter filter, HashMap<String, Object> parameters, boolean doCount) {
		
		StringBuilder hql = new StringBuilder("SELECT " + (doCount ? "COUNT(DISTINCT u)" : "DISTINCT u") + " FROM User u LEFT JOIN u.roles as r WHERE u.id > 0");

		if (filter.getLogin() != null && filter.getLogin().length() > 0) {
			hql.append(" AND u.login like :login");
			parameters.put("login", "%" + filter.getLogin() + "%");
		}

		if (filter.getEmail() != null && filter.getEmail().length() > 0) {
			hql.append(" AND u.email like :email");
			parameters.put(Constants.EMAIL, "%" + filter.getEmail() + "%");
		}

		if (filter.getComment() != null && filter.getComment().length() > 0) {
			hql.append(" AND u.comment like :comment");
			parameters.put("comment", "%" + filter.getComment() + "%");
		}

		if (filter.getLanguages() != null) {
			int i = 0;
			hql.append(" AND (");
			for (String lang : filter.getLanguages()) {
				if (lang.trim().length() > 0) {
					String l = "lang" + i++;

					if (i > 1) {
						hql.append(" OR");
					}

					hql.append(" ( u.language like :").append(l).append(")");
					parameters.put(l, lang.trim());
				}
			}
			hql.append(" )");
		}

		if (filter.getECAS() != null && filter.getSystem() != null) {
			if (filter.getECAS() && !filter.getSystem()) {
				hql.append(" AND u.type = 'ECAS'");
			} else if (!filter.getECAS() && filter.getSystem()) {
				hql.append(" AND u.type = 'SYSTEM'");
			}
		}
		
		if (filter.getBanned() != null && filter.getBanned() && filter.getUnbanned() != null && filter.getUnbanned()) {
			//show all
		} else if (filter.getBanned() != null && filter.getBanned()) {
			hql.append(" AND u.frozen = true");
		} else if (filter.getUnbanned() != null && filter.getUnbanned()) {
			hql.append(" AND u.frozen = false");
		}

		if (filter.getRoles() != null) {
			int i = 0;
			hql.append(" AND (");
			for (String role : filter.getRoles()) {
				if (role.trim().length() > 0) {
					String l = "role" + i++;

					if (i > 1) {
						hql.append(" OR");
					}

					hql.append(" r.id like :").append(l);

					parameters.put(l, Integer.parseInt(role.trim()));
				}
			}
			hql.append(" )");
		}

		if (filter.getECASaccess() != null && filter.getNoECASaccess() != null)
			if (filter.getECASaccess() && !filter.getNoECASaccess()) {
				hql.append(" AND u.canAccessEcasFunctionality = true");
			} else if (!filter.getECASaccess() && filter.getNoECASaccess()) {
				hql.append(" AND u.canAccessEcasFunctionality = false");
			}

		if (filter.getECaccess() != null && filter.getNoECaccess() != null)
			if (filter.getECaccess() && !filter.getNoECaccess()) {
				hql.append(" AND u.canAccessECFunctionality = true");
			} else if (!filter.getECaccess() && filter.getNoECaccess()) {
				hql.append(" AND u.canAccessECFunctionality = false");
			}

		if (filter.getSortKey() != null && filter.getSortKey().length() > 0) {

			hql.append(" ORDER BY u.").append(filter.getSortKey());

			if (filter.getSortOrder() != null && filter.getSortOrder().length() > 0) {
				hql.append(" ").append(filter.getSortOrder());
			} else {
				hql.append(" DESC");
			}

		}

		return hql.toString();
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void createDummyUsers(int users, String shortname) {
		Session session = sessionFactory.getCurrentSession();
		
		String surveyUID = null;
		if (shortname != null && shortname.length() > 0) {
			Survey survey = surveyService.getSurveyByAlias(shortname, true);
			surveyUID = survey.getUniqueId();
		}
		
		for (int i = 0; i < users; i++) {
			User user = new User();
			user.setGivenName("Dummy");
			user.setSurName("User " + i);
			user.setLogin("dummy" + i);
			user.setEmail("dummy@noserver.aa");
			user.setType(User.SYSTEM);
			
			session.persist(user);
			
			if (surveyUID != null) {
				ResultAccess resAccess = new ResultAccess();
				resAccess.setSurveyUID(surveyUID);
				resAccess.setUser(user.getId());
				resAccess.setOwner(1);
				surveyService.saveResultAccess(resAccess);	
			}
		}
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void createDummyEcasUsers(int counter) {
		Session session = sessionFactory.getCurrentSession();

		for (int i = 0; i < 100000; i++) {
			EcasUser eu = new EcasUser();
			eu.setDepartmentNumber("Department1");
			eu.setEcMoniker("newuserz" + counter + "#" + i);
			eu.setEmail("test@clam.dialogika.de");
			eu.setName("newnamez" + counter + "#" + i);
			eu.setUserLDAPGroups(new HashSet<>());
			eu.getUserLDAPGroups().add("Department1");
			session.merge(eu);
		}
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void createDummySurAccess() throws Exception {
		Session session = sessionFactory.getCurrentSession();

		User user = getUser(8);

		SurveyFilter filter = new SurveyFilter();
		filter.setUser(getUser(1));
		SqlPagination sqlPagination = new SqlPagination(0, 5000);
		List<Survey> surveys = surveyService.getSurveys(filter, sqlPagination);

		for (Survey survey : surveys) {
			Access a = new Access();
			a.setSurvey(survey);
			a.setUser(user);
			a.getLocalPrivileges().put(LocalPrivilege.FormManagement, 1);
			session.merge(a);
		}
	}

	public boolean isSmtpServerConfigured() {
		return !StringUtils.isEmpty(smtpServer);
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public User setLastEditedSurvey(User user, Integer surveyid) {
		Session session = sessionFactory.getCurrentSession();
		user = session.merge(user);

		String disabled = settingsService.get(Setting.CreateSurveysForExternalsDisabled);
		if (disabled.equalsIgnoreCase("true") && user.getGlobalPrivileges().get(GlobalPrivilege.ECAccess) == 0) {
			user.setCanCreateSurveys(false);
		}

		user.setLastEditedSurvey(surveyid);
		session.merge(user);
		return user;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void banUser(String userId, String mailText) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		User user = getUser(Integer.parseInt(userId));

		if (user == null) {
			throw new MessageException("user does not exist");
		}

		user.setFrozen(true);
		session.merge(user);

		// send email to user
		InputStream inputStream = servletContext.getResourceAsStream("/WEB-INF/Content/mailtemplateeusurvey.html");
		String mailtemplate = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
		String mailtext = mailtemplate.replace("[CONTENT]", mailText).replace("[HOST]", host);
		mailService.SendHtmlMail(user.getEmail(), sender, sender, "Your account has been banned", mailtext, null);

		// send email to admins
		String recipients = settingsService.get(Setting.BannedUserRecipients);
		mailtext = settingsService.get(Setting.FreezeUserTextAdminBan).replace("[LOGIN]", user.getLogin()).replace("[EMAIL]", user.getEmail());
		mailtext = mailtemplate.replace("[CONTENT]", mailtext).replace("[HOST]", host);

		String[] emails = recipients.split(";");
		for (String recipient : emails) {
			if (recipient.trim().length() > 0) {
				mailService.SendHtmlMail(recipient, sender, sender, "User banned", mailtext, null);
			}
		}
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void unbanUser(String userId) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		User user = getUser(Integer.parseInt(userId));

		if (user == null) {
			throw new MessageException("user does not exist");
		}

		user.setFrozen(false);
		session.merge(user);

		// send email to user
		InputStream inputStream = servletContext.getResourceAsStream("/WEB-INF/Content/mailtemplateeusurvey.html");
		String mailtemplate = IOUtils.toString(inputStream, StandardCharsets.UTF_8);

		String content = settingsService.get(Setting.FreezeUserTextUnban);

		String mailtext = mailtemplate.replace("[CONTENT]", content).replace("[HOST]", host);
		mailService.SendHtmlMail(user.getEmail(), sender, sender, "Your account has been unbanned", mailtext, null);

		// send email to admins
		String recipients = settingsService.get(Setting.BannedUserRecipients);
		mailtext = settingsService.get(Setting.FreezeUserTextAdminUnban).replace("[LOGIN]", user.getLogin()).replace("[EMAIL]", user.getEmail());
		mailtext = mailtemplate.replace("[CONTENT]", mailtext).replace("[HOST]", host);

		String[] emails = recipients.split(";");
		for (String recipient : emails) {
			if (recipient.trim().length() > 0) {
				mailService.SendHtmlMail(recipient, sender, sender, "User unbanned", mailtext, null);
			}
		}
	}

	@Transactional(readOnly = true)
	public boolean checkEmailsNotBanned(List<String> allEmailAddresses) {
		if (allEmailAddresses == null || allEmailAddresses.isEmpty()) return true;

		// 2. Clean the list: Hibernate 6 hates nulls or empty strings in an IN clause
		List<String> cleanEmails = allEmailAddresses.stream()
				.filter(e -> e != null && !e.trim().isEmpty())
				.collect(Collectors.toList());

		if (cleanEmails.isEmpty()) return true;

		Session session = sessionFactory.getCurrentSession();
		String query = "SELECT COUNT(u.id) FROM User u WHERE u.frozen = :frozen AND u.email IN :emails";
		// Ensure the 'emails' list is not empty before executing

		Long count = session.createQuery(query, Long.class)
				.setParameter("frozen", true)
				.setParameter("emails", allEmailAddresses)
				.getSingleResult();

		// If count > 0, it means at least one email IS found in the frozen list.
		// Therefore, the user IS banned. We return FALSE to trigger the exception.
		return count == 0;
	}

}
