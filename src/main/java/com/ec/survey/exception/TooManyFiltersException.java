package com.ec.survey.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TooManyFiltersException extends Exception {
	
	protected static Logger logger = LoggerFactory.getLogger(TooManyFiltersException.class);
	
	public TooManyFiltersException(String message) {		
		super(message);
	}

	
}
