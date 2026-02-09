package com.ec.survey.model.selfassessment;

import jakarta.persistence.Cacheable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "SASCORES")
@Cacheable
//@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class SAScore implements java.io.Serializable {

	private int id;
	private int criterion;
	private String criterionName;
	private double score;
	private boolean notRelevant; 
	private SAScoreCard scoreCard;
	
	@Id
	@Column(name = "SASCORE_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getId() {
		return id;
	}
	
	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "SASCORE_NOTRELEVANT")
	public boolean getNotRelevant() {
		return notRelevant;
	}

	public void setNotRelevant(boolean notRelevant) {
		this.notRelevant = notRelevant;
	}

	@Column(name = "SASCORE_SCORE")
	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	@JsonIgnore
	@ManyToOne  
	@JoinColumn(name="ScoreCard_ID")   
	public SAScoreCard getScoreCard() {
		return scoreCard;
	}

	public void setScoreCard(SAScoreCard scoreCard) {
		this.scoreCard = scoreCard;
	}

	@Column(name = "SASCORE_CRITERION")
	public int getCriterion() {
		return criterion;
	}

	public void setCriterion(int criterion) {
		this.criterion = criterion;
	}

	
	@Transient
	public String getCriterionName() {
		return criterionName;
	}

	public void setCriterionName(String criterionName) {
		this.criterionName = criterionName;
	}
	
	

}
