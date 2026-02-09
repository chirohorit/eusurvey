package com.ec.survey.config;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import com.ec.survey.service.SettingsService;
import com.ec.survey.service.SurveyService;
import com.ec.survey.model.Language;

public class ServerEnvironmentConfig {

    private SettingsService settingsService;
    private SurveyService surveyService;

    // Properties from spring.properties
    @Value("${server.prefix:}") private String serverPrefix;
    @Value("${captcha.bypass:false}") private String captchaBypass;
    @Value("${captcha.key:}") private String captchaKey;
    @Value("${enable.evote:false}") private String enableEvote;
    @Value("${enable.evote.lux:false}") private String enableEvoteLux;
    // ... add other @Value fields here (Delphi, Archiving, etc.) ...

    // Cached values from Database
    private boolean enableChargeback;
    private String captchaType;
    private String uiSessionTimeout;
    //private List<Language> languages;

    // Setters for XML Injection
    public void setSettingsService(SettingsService settingsService) { this.settingsService = settingsService; }
    public void setSurveyService(SurveyService surveyService) { this.surveyService = surveyService; }

    /**
     * Triggered by init-method="refresh" in XML.
     * Hits the DB once at startup, then stores values in memory.
     */
    public void refresh() {
        this.enableChargeback = "true".equalsIgnoreCase(settingsService.get("EnableChargeback"));
        this.captchaType = settingsService.get("captcha");
        this.uiSessionTimeout = settingsService.get("uisessiontimeout");
        //this.languages = surveyService.fetchLanguages();
    }

    // Logic Methods
    public boolean isByPassCaptcha() { return "true".equalsIgnoreCase(captchaBypass); }

    public boolean isEVoteAvailable() {
        return "true".equalsIgnoreCase(enableEvote) &&
                ("true".equalsIgnoreCase(enableEvoteLux) || /* check other regions */ true);
    }

    // Getters for the Interceptor
    public String getServerPrefix() { return serverPrefix; }
    public boolean isEnableChargeback() { return enableChargeback; }
    public String getCaptchaType() { return captchaType; }
    public String getUiSessionTimeout() { return uiSessionTimeout; }
    //public List<Language> getLanguages() { return languages; }
}
