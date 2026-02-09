package com.ec.survey.handler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import com.ec.survey.config.ServerEnvironmentConfig;

public class ServerEnvironmentHandlerInterceptor implements HandlerInterceptor {

    private ServerEnvironmentConfig config;
    public void setServerEnvironmentConfig(ServerEnvironmentConfig config) {
        this.config = config;
    }

    @Override
    public void postHandle(final HttpServletRequest request, final HttpServletResponse response,
                           final Object handler, final ModelAndView modelAndView) throws Exception {

        if (modelAndView != null && modelAndView.hasView() && !modelAndView.getViewName().startsWith("redirect")) {

            // Populate the model from the memory-resident Config bean
            modelAndView.addObject("serverprefix", config.getServerPrefix());
            modelAndView.addObject("captchaBypass", config.isByPassCaptcha());
            modelAndView.addObject("enableevote", config.isEVoteAvailable());
            modelAndView.addObject("enablechargeback", config.isEnableChargeback());
            modelAndView.addObject("captcha", config.getCaptchaType());
            modelAndView.addObject("uisessiontimeout", config.getUiSessionTimeout());
            //modelAndView.addObject("languages", config.getLanguages());

            // Request-specific context
            modelAndView.addObject("origin", request.getRequestURI());
            modelAndView.addObject("contextpath", request.getContextPath());

            // Handle Session-based attributes (like notifications)
            Object saved = request.getSession().getAttribute("surveyeditorsaved");
            if (saved != null) {
                modelAndView.addObject("surveyeditorsaved", saved);
                request.getSession().removeAttribute("surveyeditorsaved");
            }
        }
    }
}
