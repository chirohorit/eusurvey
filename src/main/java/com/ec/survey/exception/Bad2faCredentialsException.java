package com.ec.survey.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.security.authentication.BadCredentialsException;


public class Bad2faCredentialsException extends BadCredentialsException {
	
	protected static final Logger logger = LoggerFactory.getLogger(BadCredentialsException.class);
	
	public Bad2faCredentialsException(String message) {		
		super(message);
        logger.error("BadSurveyCredentialsException".toUpperCase() + " HAS BEEN CALLED WITH MESSAGE " + message);
	}

	public Bad2faCredentialsException() {
		this("Ecas user does not use two factor authentication!");
	}

	
}
