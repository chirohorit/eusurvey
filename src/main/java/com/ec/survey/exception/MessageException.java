package com.ec.survey.exception;

public class MessageException extends Exception {
	
	/**
	 * 
	 */
	

	public MessageException(String message) {		
		super(message);
	}

	public MessageException(String message, Exception e) {
		super(message, e);
	}

}
