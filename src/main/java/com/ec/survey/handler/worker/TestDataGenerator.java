package com.ec.survey.handler.worker;

import java.util.*;

import com.ec.survey.handler.SurveyCreator;
import com.ec.survey.handler.SurveyHelper;
import com.ec.survey.model.AnswerSet;
import com.ec.survey.model.Language;
import com.ec.survey.model.survey.Survey;
import jakarta.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import com.ec.survey.model.administration.User;
import com.ec.survey.service.AdministrationService;
import com.ec.survey.service.AnswerService;
import com.ec.survey.service.ArchiveService;
import com.ec.survey.service.AttendeeService;
import com.ec.survey.service.FileService;
import com.ec.survey.service.MailService;
import com.ec.survey.service.SurveyService;
import org.springframework.transaction.annotation.Transactional;

@Service("testDataGenerator")
public class TestDataGenerator implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(TestDataGenerator.class);

	@Resource(name = "surveyService")
	protected SurveyService surveyService;	
	
	@Resource(name = "archiveService")
	protected ArchiveService archiveService;	

	@Resource(name = "answerService")
	protected AnswerService answerService;	
	
	@Resource(name="mailService")
	private MailService mailService;
	
	@Resource(name = "taskExecutor")
	private TaskExecutor taskExecutor;
	
	@Resource(name = "fileService")
	private FileService fileService;
	
	@Resource(name = "attendeeService")
	private AttendeeService attendeeService;
	
	@Resource(name = "administrationService")
	private AdministrationService administrationService;
	
	@Autowired
	protected MessageSource resources;	
	
	private String fileDir;
	private String sender;
	
	private User user;
	private int answers;
	private int files;
	private Integer questions;
	private String email;
	private String shortname;
	private BeanFactory context;
	private int surveys;
	private int contacts;
	private int users;
	
	//private boolean archive = false;
	
	public void init(User user, int answers, String fileDir, String sender, String email, String shortname, Integer questions, int files, int surveys, int contacts, int users)
	{
		this.user = user;
		this.answers = answers;
		this.questions = questions;
		this.fileDir = fileDir;
		this.sender = sender;
		this.email = email;
		this.shortname = shortname;
		this.files = files;
		this.surveys = surveys;
		this.contacts = contacts;
		this.users = users;
	}
	
	@Override
	public void run() {
		try {
			if (users > 0) {
				administrationService.createDummyUsers(users, shortname);
			} else if (contacts > 0)
			{
				attendeeService.createDummyAttendees(contacts, user.getId());
				if (email != null) mailService.SendHtmlMail(email, sender, sender, "Test data generated", contacts + " contacts have been generated", null);
			} else if (files > 0)
			{
				fileService.createDummyFiles(files);
				if (email != null) mailService.SendHtmlMail(email, sender, sender, "Test data generated", files + " files have been generated", null);
			} else {
				if (shortname != null && !shortname.isEmpty())
				{
					createDummyAnswers(shortname, answers, user, fileDir, answerService, surveyService, true, resources, Locale.ENGLISH, fileService);
				} else {
					for (int i = 0; i < surveys; i++)
					{
						if (answers != -1 && surveys > 1 && i > 0)
						{
							answers = (int) Math.floor(150000/i - 1);
						}
						createSurvey(answers, user, surveyService.getLanguage("EN"), surveyService, answerService, fileDir, false, resources, Locale.ENGLISH, questions, archiveService, taskExecutor, fileService);
					}
				}
				
				if (email != null) mailService.SendHtmlMail(email, sender, sender, "Test data generated", "The test survey with " + answers + " answers has been generated", null);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}

	public static Survey createSurvey(int answerCount, User user, Language objLang, SurveyService surveyService, AnswerService answerService, String fileDir, boolean init, MessageSource resources, Locale locale, Integer questions, ArchiveService archiveService, TaskExecutor taskExecutor, FileService fileService) throws Exception {
		Survey survey = SurveyCreator.createDummySurvey(user, objLang, init, questions);
		survey.setListForm(true);
		survey.getPublication().setShowContent(true);
		survey.getPublication().setShowStatistics(true);
		survey.getPublication().setShowCharts(true);
		survey.getPublication().setShowSearch(true);

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, 2);
		survey.setEnd(cal.getTime());

		survey = surveyService.add(survey, -1);

		surveyService.publish(survey, -1, -1, false, user.getId(), false, false);
		createDummyAnswers(survey.getShortname(), answerCount, user, fileDir, answerService, surveyService, false, resources, locale, fileService);

		return survey;
	}

	public static void createDummyAnswers(String shortname, int answerCount, User user, String fileDir, AnswerService answerService, SurveyService surveyService, boolean validate, MessageSource resources, Locale locale, FileService fileService) throws Exception {
		if (answerCount <= 0) return;

		Survey psurvey = surveyService.getSurvey(shortname, false, false, false, true, null, true, false);

		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());

		for (int j = 0; j < answerCount; j++) {
			AnswerSet answerSet = SurveyCreator.createDummyAnswerSet(psurvey, user);

			if (psurvey.getIsEVote()) {
				answerSet.setDate(cal.getTime());
				cal.add(Calendar.MINUTE, -10);
			}

			if (validate)
			{
				Set<String> invisibleElements = new HashSet<>();
				SurveyHelper.validateAnswerSet(answerSet,answerService,invisibleElements, resources, locale, null, null, true, null, fileService);
			}

			saveAnswerSet(answerSet, fileDir, answerService, null);
		}
	}

	@Transactional
	public static void saveAnswerSet(AnswerSet answerSet, String fileDir, AnswerService answerService, String draftid) throws Exception {
		boolean saved = false;

		int counter = 1;

		while(!saved)
		{
			try {
				answerService.internalSaveAnswerSet(answerSet, fileDir, draftid, false, true);
				saved = true;
			} catch (org.hibernate.exception.LockAcquisitionException ex)
			{
				logger.info("lock on answerSet table catched; retry counter: {}", counter);
				counter++;

				if (counter > 60)
				{
					logger.error(ex.getLocalizedMessage(), ex);
					throw ex;
				}

				Thread.sleep(1000);
			}
		}
	}
	
}
