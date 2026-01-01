package com.ec.survey.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AccessDeniedException extends RuntimeException {

    protected static Logger logger = LoggerFactory.getLogger(AccessDeniedException.class);

    public AccessDeniedException(String message) {
        super(message);
    }

    private static final long serialVersionUID = 1L;
}