package com.ec.survey.tools;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.security.authentication.BadCredentialsException;


public class BadSurveyCredentialsException extends BadCredentialsException {
	
	protected static final Logger logger = LoggerFactory.getLogger(BadCredentialsException.class);
	
	public BadSurveyCredentialsException(String message) {		
		super(message);
        logger.error("BadSurveyCredentialsException".toUpperCase() + " HAS BEEN CALLED WITH MESSAGE " + message);
	}

	private static final long serialVersionUID = 1L;
}
