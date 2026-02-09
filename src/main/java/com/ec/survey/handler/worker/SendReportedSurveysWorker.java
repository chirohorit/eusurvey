package com.ec.survey.handler.worker;

import com.ec.survey.service.SurveyService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

@Service("sendReportedSurveysWorker")
@Scope("singleton")
public class SendReportedSurveysWorker implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(SendReportedSurveysWorker.class);
	
	@Resource(name="surveyService")
	private SurveyService surveyService;
		
	@Override
	public void run() {
		try {
			logger.info("SendReportedSurveysWorker started");
			
			surveyService.sendAbuseReportsMailForYesterday();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}		
		logger.info("SendReportedSurveysWorker completed");
	}
	
}
