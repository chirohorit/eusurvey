package com.ec.survey.tools;

import com.ec.survey.service.AnswerService;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("deleteInvalidStatisticsWorker")
@Scope("singleton")
public class DeleteInvalidStatisticsWorker implements Runnable {

	protected static final Logger logger = LogManager.getLogger(DeleteInvalidStatisticsWorker.class);
	
	@Resource(name="answerService")
	private AnswerService answerService;
		
	@Override
	public void run() {
		try {
			logger.info("DeleteInvalidStatisticsWorker started");
			
			answerService.deleteInvalidStatistics();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}		
		logger.info("DeleteInvalidStatisticsWorker completed");
	}
	
}
