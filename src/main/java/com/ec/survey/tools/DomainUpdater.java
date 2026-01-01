package com.ec.survey.tools;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import com.ec.survey.service.LdapDBService;
import com.ec.survey.service.LdapService;

@Service("domainWorker")
@Scope("singleton")
public class DomainUpdater implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(DomainUpdater.class);

	@Resource(name = "ldapDBService")
	private LdapDBService ldapDBService;
	
	@Resource(name = "ldapService")
	private LdapService ldapService;
	
	@Override
	public void run() {
		try {
			logger.info("DomainUpdater started");
			Map<String, String> allDomains = ldapService.getAllDomains();
			logger.info("DomainUpdater get all Domains " + allDomains.size());
			reloadDomains(allDomains);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}		
		logger.info("DomainUpdater completed");
	}
	
	private void reloadDomains(Map<String, String> allDomains)
	{
		ldapDBService.reloadDomains(allDomains);
	}

}
