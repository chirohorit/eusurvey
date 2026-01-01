package com.ec.survey.tools;

import com.ec.survey.service.ValidCodesService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("validCodesRemover")
@Scope("singleton")
public class ValidCodesRemover implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(ValidCodesRemover.class);
	
	@Resource(name="validCodesService")
	private ValidCodesService validCodesService;
	
	@Override
	public void run() {
		try {	
			validCodesService.removeOldCodes();		
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}
	
}
