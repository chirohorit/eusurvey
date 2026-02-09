package com.ec.survey.handler.worker;


import java.util.Set;

import jakarta.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import com.ec.survey.model.DepartmentItem;
import com.ec.survey.service.LdapDBService;
import com.ec.survey.service.LdapService;

@Service("departmentWorker")
@Scope("singleton")
public class DepartmentUpdater implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(DepartmentUpdater.class);

	@Resource(name = "ldapDBService")
	private LdapDBService ldapDBService;
	
	@Resource(name = "ldapService")
	private LdapService ldapService;
	
	@Override
	public void run() {
		try {
			logger.info("DepartmentUpdater started");
			Set<DepartmentItem> departments = ldapService.getAllDepartments();  
			logger.info("DepartmentUpdater: departments loaded");
			reloadDepartments(departments);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}		
		logger.info("DepartmentUpdater completed");
	}
	
	private void reloadDepartments(Set<DepartmentItem> departments)
	{
		ldapDBService.reload(departments);
	}
	
}
