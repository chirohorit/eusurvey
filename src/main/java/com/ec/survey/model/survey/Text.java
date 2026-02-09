package com.ec.survey.model.survey;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.owasp.esapi.errors.ValidationException;

import jakarta.persistence.Cacheable;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

/**
 * Represents a text element in a survey
 */
@Entity
@DiscriminatorValue("TEXT")
@Cacheable
////@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class Text extends Question {	

	public Text(String text, String uid) {
		setTitle(text);
		setUniqueId(uid);
	}
	
	public Text() {
	}	
	
	public Text copy(String fileDir) throws ValidationException
	{
		Text copy = new Text();
		baseCopy(copy);
		return copy;
	}
	
	@Override
	public boolean differsFrom(Element element) {
		return basicDiffersFrom(element);
	}
	
}
