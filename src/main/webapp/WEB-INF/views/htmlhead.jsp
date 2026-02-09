<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>EUSurvey - <spring:message code="label.Welcome" /></title>

    <!-- Bootstrap core CSS -->
    <link href="${contextpath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <style>
        .bd-placeholder-img {font-size: 1.125rem;text-anchor: middle;-webkit-user-select: none;-moz-user-select: none;user-select: none;}
        @media (min-width: 768px) {.bd-placeholder-img-lg {font-size: 3.5rem;}}
    </style>
    <!-- Custom styles for this template -->
    <link href="${contextpath}/resources/css/welcome.css" rel="stylesheet" type="text/css" />
</head>
<body>