package com.ec.survey.handler.worker;

import com.ec.survey.service.ExportService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

@Service("exportWorker")
@Scope("singleton")
public class ExportUpdater implements Runnable {

	protected static final Logger logger = LoggerFactory.getLogger(ExportUpdater.class);
	
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
