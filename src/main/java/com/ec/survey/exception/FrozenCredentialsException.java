package com.ec.survey.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.security.authentication.BadCredentialsException;


public class FrozenCredentialsException extends BadCredentialsException {
	
	protected static final Logger logger = LoggerFactory.getLogger(BadCredentialsException.class);
	
	public FrozenCredentialsException(String message) {		
		super(message);
		logger.error("FrozenCredentialsException".toUpperCase() + " HAS BEEN CALLED WITH MESSAGE " + message);
	}

	
}
