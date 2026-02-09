/*
package com.ec.survey.security;

import com.ec.survey.exception.FrozenCredentialsException;
import com.ec.survey.exception.MessageException;
import com.ec.survey.model.administration.User;
import com.ec.survey.service.*;
import org.jspecify.annotations.NonNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import java.util.List;

//@Component("customAuthenticationProvider")
public class CustomAuthenticationProvider implements AuthenticationProvider {
    private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationProvider.class);
    @Autowired
    AuthenticationService authenticationService;

    @Override
    public Authentication authenticate(@NonNull Authentication auth) throws AuthenticationException {
        // Your existing logic here
        logger.debug("INSIDE AUTHENTICATE");
        try {
            // Retrieve user details from database
            List<User> users = authenticationService.getUserForLogin(auth.getName(), false);
            if (users.isEmpty())
                throw new MessageException("No user found for login " + auth.getName());
            if (users.size() > 1)
                throw new MessageException("Multiple users found for login " + auth.getName());

            User user = users.get(0);
            logger.debug("{} Found", user.getName());

            if (authenticationService.checkUserPassword(user, auth)) {
                //replaced md5 hash by salted SHA-512 hash
                logger.debug("User validated successfully!");
            } else {
                logger.debug("VALIDATION FAILED");
                if (authenticationService.getBadLoginAttempts(user) >= 2)
                    throw new LockedException("More than two bad login attempts");
                throw new BadCredentialsException("Wrong password!");
            }

            if (authenticationService.isValidated(user))
                throw new BadCredentialsException("User not validated!");
            if (authenticationService.checkUserNotBanned(user))
                throw new FrozenCredentialsException("User is banned!");

            return new UsernamePasswordAuthenticationToken(
                    auth.getName(),
                    auth.getCredentials(),
                    authenticationService.getAuthorities(user, false, false, false, false)
            );
        } catch (Exception e) {
            throw new BadCredentialsException("User does not exist! EXCEPTION: " + e.getLocalizedMessage());
        }
    }

    @Override
    public boolean supports(@NonNull Class<?> authentication) {
        // Tell Spring this provider handles standard login tokens
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}


*/
