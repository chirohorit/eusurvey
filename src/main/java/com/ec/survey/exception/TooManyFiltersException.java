package com.ec.survey.exception;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class TooManyFiltersException extends Exception {
	
	protected static Logger logger = LogManager.getLogger(TooManyFiltersException.class);
	
	public TooManyFiltersException(String message) {		
		super(message);
	}

	private static final long serialVersionUID = 1L;
}
