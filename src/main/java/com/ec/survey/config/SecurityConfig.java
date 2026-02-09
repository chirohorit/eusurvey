//package com.ec.survey.config;
//
//import com.ec.survey.security.*;
//import org.hibernate.resource.transaction.backend.jta.internal.synchronization.ExceptionMapper;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
//import org.springframework.security.config.annotation.web.configurers.SessionManagementConfigurer;
//import org.springframework.security.web.SecurityFilterChain;
//import org.springframework.security.web.authentication.ExceptionMappingAuthenticationFailureHandler;
//import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
//import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
//import org.springframework.security.web.authentication.session.SessionFixationProtectionStrategy;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Configuration
//@EnableWebSecurity
//public class SecurityConfig {
//
//    @Value("${frameancestors:'none'}")
//    private String frameAncestors;
//
//    @Bean
//    public SecurityFilterChain filterChain(HttpSecurity http)  // Spring finds the bean here
//        throws Exception {
//            http
//                .csrf(csrf -> csrf.requireCsrfProtectionMatcher(csrfSecurityRequestMatcher()))
//                .exceptionHandling(ex -> ex
//                        //.authenticationEntryPoint(authenticationEntryPoint())
//                        .accessDeniedPage("/auth/login?securityerror=true")
//                )
//                .headers(headers -> headers
//                        .frameOptions(HeadersConfigurer.FrameOptionsConfig::disable)
//                        .contentSecurityPolicy(csp -> csp.policyDirectives("frame-ancestors " + frameAncestors))
//                )
//                .sessionManagement(session -> session
//                        .sessionFixation(SessionManagementConfigurer.SessionFixationConfigurer::newSession)
//                )
//                .authorizeHttpRequests(auth -> auth
//                        .requestMatchers("/", "/captcha.html", "/EuCaptchaApi/**", "/editcontribution/**",
//                                "/preparecontribution/**", "/preparedraft/**", "/preparequizresults/**",
//                                "/preparesaresults/**", "/graphics/**", "/printcontribution/**",
//                                "/preparepublishedcontribution/**", "/*/management/preparecharts/**",
//                                "/*/management/preparestatistics/**", "/*/management/preparestatisticsquiz/**",
//                                "/*/management/preparepdfreport/**", "/*/management/statisticsJSON/**",
//                                "/*/management/resultsJSON", "/*/management/selfassessment/results",
//                                "/ecfResultJSON", "/webservice/**", "/pdf/**", "/errors/**", "/files/**",
//                                "/home/**", "/validate/**", "/validateNewEmail/**", "/deleteaccount/**",
//                                "/runner/**", "/runner2/**", "/publication/**", "/auth/**", "/resources/**",
//                                "/info/**", "/administration/checkPasswordNotWeak", "/administration/system/complexity",
//                                "/administration/system/message", "/administration/system/deletemessage",
//                                "/administration/system/messages/runner", "/utils/**").permitAll()
//                        .requestMatchers("/worker/**", "/monitoring", "/testdata/**",
//                                "/administration/languages", "/administration/departments",
//                                "/administration/synchronizeLDAP", "/administration/synchronizeDomains")
//                        .hasAnyRole("USER_ADMIN", "RIGHT_ADMIN")
//                        .requestMatchers("/addressbook/**").hasAnyRole("CONTACT_MANAGER", "CONTACT_ADMIN")
//                        .requestMatchers("/administration").hasAnyRole("USER_ADMIN", "RIGHT_ADMIN", "RIGHT_MANAGER")
//                        .requestMatchers("/administration/users/**").hasRole("USER_ADMIN")
//                        .requestMatchers("/administration/roles").hasAnyRole("RIGHT_ADMIN", "RIGHT_MANAGER")
//                        .requestMatchers("/administration/system/messages").hasRole("USER")
//                        .requestMatchers("/administration/system/**", "/administration/**").hasAnyRole("SYSTEM_ADMIN", "SYSTEM_MANAGER")
//                        .requestMatchers("/administration/publicsurveys/**").hasRole("FORM_ADMIN")
//                        .requestMatchers("/ownership/accept/*", "/ownership/reject/*", "/**",
//                                "/*/management/**", "/settings/**").hasRole("USER")
//                        .anyRequest().authenticated()
//                )
//                .formLogin((formLogin) -> formLogin
//                        .loginPage("/auth/login")
//                        .loginProcessingUrl("/auth/login")
//                        .permitAll()
//                )
//                .logout(logout -> logout
//                        .logoutUrl("/j_spring_security_logout")
//                        .logoutSuccessHandler(myLogoutSuccessHandler())
//                        .invalidateHttpSession(false)
//                )
//                // Register custom filters
//                .addFilterBefore(blacklistFilter(), UsernamePasswordAuthenticationFilter.class)
//                .addFilterAt(authenticationFilter(customAuthenticationManager(), customAuthenticationSuccessHandler()), UsernamePasswordAuthenticationFilter.class);
//
//        return http.build();
//    }
//
//    @Bean
//    public UsernamePasswordAuthenticationFilter authenticationFilter(CustomAuthenticationManager authManager, CustomAuthenticationSuccessHandler successHandler) {
//        UsernamePasswordAuthenticationFilter filter = new UsernamePasswordAuthenticationFilter();
//        filter.setAuthenticationManager(authManager);
//        filter.setAuthenticationSuccessHandler(successHandler);
//        filter.setAuthenticationFailureHandler(customAuthenticationFailureHandler());
//        filter.setPostOnly(false);
//
//        SessionFixationProtectionStrategy strategy = new SessionFixationProtectionStrategy();
//        strategy.setMigrateSessionAttributes(false);
//        strategy.setAlwaysCreateSession(true);
//        filter.setSessionAuthenticationStrategy(strategy);
//
//        return filter;
//    }
//
//    @Bean
//    public CsrfSecurityRequestMatcher csrfSecurityRequestMatcher() {
//        return new CsrfSecurityRequestMatcher();
//    }
//
//    @Bean
//    public MyLogoutSuccessHandler myLogoutSuccessHandler() {
//        return new MyLogoutSuccessHandler();
//    }
//
//    @Bean
//    public BlacklistFilter blacklistFilter() {
//        return new BlacklistFilter();
//    }
//
//    @Bean
//    public ExceptionMappingAuthenticationFailureHandler failureHandler() {
//        return new ExceptionMappingAuthenticationFailureHandler();
//    }
//
//    @Bean
//    public LoginUrlAuthenticationEntryPoint authenticationEntryPoint() {
//        return new LoginUrlAuthenticationEntryPoint("/auth/login");
//    }
//
//    @Bean
//    public CustomAuthenticationManager customAuthenticationManager() {
//        return new CustomAuthenticationManager();
//    }
//
//    @Bean
//    public CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler() {
//        CustomAuthenticationSuccessHandler successHandler = new CustomAuthenticationSuccessHandler();
//        successHandler.setDefaultTargetUrl("/forms");
//
//        return successHandler;
//    }
//
//    @Bean
//    public ExceptionMappingAuthenticationFailureHandler customAuthenticationFailureHandler() {
//        ExceptionMappingAuthenticationFailureHandler handler = new ExceptionMappingAuthenticationFailureHandler();
//        Map<String, String> failureUrlMap = new HashMap<>();
//
//        // Mapping specific exceptions to URLs
//        failureUrlMap.put("com.ec.survey.exception.BadSurveyCredentialsException", "/errors/403.html");
//        failureUrlMap.put("com.ec.survey.exception.Bad2faCredentialsException", "/errors/2fa.html");
//        failureUrlMap.put("com.ec.survey.exception.FrozenCredentialsException", "/errors/frozen.html");
//        failureUrlMap.put("org.springframework.security.authentication.BadCredentialsException", "/auth/login?error=true");
//        failureUrlMap.put("org.springframework.security.authentication.LockedException", "/errors/403.html");
//
//        handler.setExceptionMappings(failureUrlMap);
//        handler.setDefaultFailureUrl("/auth/login?error=true"); // Fallback URL
//        return handler;
//    }
//}
