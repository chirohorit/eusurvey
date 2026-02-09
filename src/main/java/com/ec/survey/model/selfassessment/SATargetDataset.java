package com.ec.survey.model.selfassessment;

import jakarta.persistence.Cacheable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Table(name = "SATARGETDATASETS", uniqueConstraints = {
		@UniqueConstraint(columnNames = { "SATARGETDATASETS_NAME", "SATARGETDATASETS_SURVEY" }, name = "NAME_SURVEY") })
@Cacheable
//@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class SATargetDataset implements java.io.Serializable {

	private int id;
	private String surveyUID;
	private String name;
	
	@Id
	@Column(name = "SATARGETDATASETS_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "SATARGETDATASETS_NAME")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SATARGETDATASETS_SURVEY")
	public String getSurveyUID() {
		return surveyUID;
	}

	public void setSurveyUID(String surveyUID) {
		this.surveyUID = surveyUID;
	}
}
