package com.ec.survey.handler.worker;

import java.util.List;

import jakarta.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import com.ec.survey.service.ReportingService;
import com.ec.survey.service.ReportingServiceProxy;
import com.ec.survey.service.SurveyService;

@Service("createAllOLAPTablesExecutor")
@Scope("prototype")
public class CreateAllOLAPTablesExecutor implements Runnable {

	@Resource(name="surveyService")
	private SurveyService surveyService;
	
	@Resource(name="reportingServiceProxy")
	private ReportingServiceProxy reportingService;	

	private static final Logger logger = LoggerFactory.getLogger(CreateAllOLAPTablesExecutor.class);
	
	public void run()
	{
		try {
			logger.info("CreateAllOLAPTablesExecutor started");
			
			List<String> surveyUIDs = surveyService.getAllSurveyUIDs(false);
			for (String uid : surveyUIDs)
			{
				try {
					if (!reportingService.OLAPTableExists(uid, true))
					{
						reportingService.createOLAPTable(uid, true, false);
					}
					if (!reportingService.OLAPTableExists(uid, false))
					{
						reportingService.createOLAPTable(uid, false, true);
					}
				} catch (Exception e) {
					logger.error(e.getMessage(), e);
					logger.error("last query: " + ReportingService.lastQuery);
				}
			}
				
			logger.info("CreateAllOLAPTablesExecutor finished");
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}
	
}
