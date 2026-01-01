package com.ec.survey.tools;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.ec.survey.model.survey.Survey;
import com.ec.survey.service.PDFService;

@Service("surveyExecutor")
@Scope("prototype")
public class SurveyExecutor implements Runnable {

	@Resource(name="pdfService")
	private PDFService pdfService;
	
	private Survey survey;
	private String lang;
	
	private static final Logger logger = LoggerFactory.getLogger(SurveyExecutor.class);
	
	public void init(Survey survey, String lang)
	{
		this.survey = survey;
		this.lang = lang;
	}
	
	public void run()
	{
		try {
			pdfService.createSurveyPDF(survey, lang, null);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
	}
	
}
