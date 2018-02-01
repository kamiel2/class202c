<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<header id="header">
				<a href="<%=contextPath%>/product/productList.do"> <img
					src="<%=contextPath %>/img/더조은 메인.jpg" id=mainimg></a> <br>
				<nav id="topMenu">
					<ul>
					<li><a class="menuLink" href="<%=contextPath%>/ordr/ordrList.do">판매/출고</a></li>
					<li><a class="menuLink" href="<%=contextPath%>/purchase/purchaseList.do">발주/입고</a></li>
					<li><a class="menuLink" href="<%=contextPath%>/stock/stockList.do">재고 관리</a></li>
					<li><a class="menuLink" href="<%=contextPath%>/ptnr/ptnrList.do">파트너사 관리</a></li>
					<li><a class="menuLink" href="<%=contextPath%>/product/productAddView.do">부품 등록</a></li>
					<li><a class="menuLink" href="<%=contextPath%>/category/categoryAddView.do">카테고리 등록</a></li>
					</ul>
				</nav>
</header>