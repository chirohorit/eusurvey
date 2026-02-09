package com.ec.survey.model.selfassessment;

import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.Cacheable;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "SASCORECARDS", uniqueConstraints = {
		@UniqueConstraint(columnNames = { "SASCORECARD_DATASETID" }, name = "DATASET_SCORE") })
@Cacheable
//@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class SAScoreCard implements java.io.Serializable {

	private int id;
	private int datasetID;
	
	private List<SAScore> scores = new ArrayList<>();
	
	@Id
	@Column(name = "SASCORECARD_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "SASCORECARD_DATASETID")
	public int getDatasetID() {
		return datasetID;
	}

	public void setDatasetID(int datasetID) {
		this.datasetID = datasetID;
	}

	@OneToMany(targetEntity = SAScore.class, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "scoreCard")
	@Fetch(value = FetchMode.SELECT)
	//@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	public List<SAScore> getScores() {
		return scores;
	}

	public void setScores(List<SAScore> scores) {
		this.scores = scores;
	}

	public boolean hasScoreForCriterion(SACriterion criterion) {
		for (SAScore saScore : scores) {
			if (saScore.getCriterion() == criterion.getId()) {
				return true;
			}
		}
		return false;
	}	
}
