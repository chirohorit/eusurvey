package com.ec.survey.exception;

/**
 * Class used only for returning 403 error in webservice scenarios
 */
public class ForbiddenException extends Exception {

	

	public ForbiddenException() {
		super();
	}
	public ForbiddenException(Throwable cause) {
        super(cause);
    }
	
}
