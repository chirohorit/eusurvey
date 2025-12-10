package com.ec.survey.exception;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class AccessDeniedException extends RuntimeException {

    protected static Logger logger = LogManager.getLogger(AccessDeniedException.class);

    public AccessDeniedException(String message) {
        super(message);
    }

    private static final long serialVersionUID = 1L;
}