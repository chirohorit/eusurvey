package com.ec.survey.handler.worker;

import java.util.Date;
import java.util.List;

import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import com.ec.survey.service.ReportingService;
import com.ec.survey.service.ReportingServiceProxy;
import com.ec.survey.service.SurveyService;

@Service("updateAllOLAPTablesExecutor")
@Scope("prototype")
public class UpdateAllOLAPTablesExecutor implements Runnable {

	@Resource(name="surveyService")
	private SurveyService surveyService;
	
	@Resource(name="reportingServiceProxy")
	private ReportingServiceProxy reportingService;	

	private static final Logger logger = LoggerFactory.getLogger(UpdateAllOLAPTablesExecutor.class);
	
	public void run()
	{
		try {
			logger.info("UpdateAllOLAPTablesExecutor started");
			
			Date start = new Date();
			List<String> surveyUIDs = surveyService.getAllSurveyUIDs(false);
			for (String uid : surveyUIDs)
			{
				try {
					if (!reportingService.OLAPTableExists(uid, true))
					{
						reportingService.createOLAPTable(uid, true, false);
					} else {
						reportingService.updateOLAPTable(uid, true, false);
					}
					
					if (!reportingService.OLAPTableExists(uid, false))
					{
						reportingService.createOLAPTable(uid, false, true);
					} else {
						reportingService.updateOLAPTable(uid, false, true);
					}
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
					logger.error("last query: " + ReportingService.lastQuery);
				}
			}
					
			Date end = new Date();
			long diff = end.getTime() - start.getTime();
			long diffMinutes = diff / (60 * 1000) % 60; 
				
			logger.info("UpdateAllOLAPTablesExecutor finished, duration: " + diffMinutes + " minutes");
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}
	
}
