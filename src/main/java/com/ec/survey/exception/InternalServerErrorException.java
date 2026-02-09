package com.ec.survey.exception;

/**
 * Class used only for returning 500 error in webservice scenarios
 */
public class InternalServerErrorException extends Exception {

	

	public InternalServerErrorException() {
		super();
	}
	public InternalServerErrorException(Throwable cause) {
        super(cause);
    }

}
