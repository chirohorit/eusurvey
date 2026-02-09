package com.ec.survey.exception;

public class InvalidEmailException extends Exception {
	
	private final Object element;

	public InvalidEmailException(Object element, String message)
	{
		super(message);
		this.element = element;
	}

	public Object getElement() {
		return element;
	}
}
