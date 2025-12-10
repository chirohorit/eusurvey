package com.ec.survey.tools;

import com.ec.survey.service.ExportService;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("exportWorker")
@Scope("singleton")
public class ExportUpdater implements Runnable {

	protected static final Logger logger = LogManager.getLogger(ExportUpdater.class);
	
	@Resource(name="exportService")
	private ExportService exportService;
	
	@Override
	public void run() {
		try {	
			exportService.applyExportTimeout();
			
			logger.info("Starting deletion of old webservice exports");
			exportService.deleteOldWebserviceExports();
			logger.info("Starting deletion of old exports");
			exportService.deleteOldExports();	
			logger.info("Starting deletion of old export zombie files");
			exportService.deleteExportZombieFiles();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}
	
}
