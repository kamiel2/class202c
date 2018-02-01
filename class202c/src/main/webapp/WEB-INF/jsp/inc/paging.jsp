<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul class="w3-pagination w3-border w3-round w3-center">
    <li><a href="javascript:goPage(${param.firstPageNo})">&laquo;&laquo;</a></li>
    <li><a href="javascript:goPage(${param.prevPageNo})">&laquo;</a></li>
    
    <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
        <c:choose>
            <c:when test="${i eq param.pageNo}"> <li><a class="w3-btn w3-brown" href="javascript:goPage(${i})">${i}</a></li></c:when>
            <c:otherwise><li><a href="javascript:goPage(${i})">${i}</a></li></c:otherwise>
        </c:choose>
    </c:forEach>
	
	<li><a href="javascript:goPage(${param.nextPageNo})">&raquo;</a>
	<li><a href="javascript:goPage(${param.finalPageNo})">&raquo;&raquo;</a>
</li>


