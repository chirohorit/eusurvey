package com.ec.survey.exception.httpexception;

/**
 * Represents a 500 exception that will be sent back to the browser
 */
public class InternalServerErrorException extends Exception {

    
    
    public InternalServerErrorException(Throwable cause) {
        super(cause);
    }

}
