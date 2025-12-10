package com.ec.survey.tools;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;


import org.springframework.security.authentication.BadCredentialsException;


public class FrozenCredentialsException extends BadCredentialsException {
	
	protected static final Logger logger = LogManager.getLogger(BadCredentialsException.class);
	
	public FrozenCredentialsException(String message) {		
		super(message);
		logger.error("FrozenCredentialsException".toUpperCase() + " HAS BEEN CALLED WITH MESSAGE " + message);
	}

	private static final long serialVersionUID = 1L;
}
