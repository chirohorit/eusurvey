package com.ec.survey.exception;

public class SurveyException extends Exception {

	

	private int surveyID;

	public SurveyException(Integer surveyID) {
		this.surveyID = surveyID;
	}

	public int getSurveyID() {
		return surveyID;
	}
}
