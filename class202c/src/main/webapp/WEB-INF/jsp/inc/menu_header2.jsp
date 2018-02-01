<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<header>
			<a href="<%=contextPath %>/ordr/ordr_index.do"> <img src="<%=contextPath %>/img/더조은 메인.jpg" id=mainimg></a> <br>


			<nav id="topMenu">
				<ul>
					<li><a class="menuLink"
						href="<%=contextPath%>/ordr/ordr_index.do">제품조회</a></li>
					<li><a class="menuLink"
						href="<%=contextPath%>/ordr/ordr-001.do">장바구니</a></li>
					<li><a class="menuLink"
						href="<%=contextPath%>/ordr/ordr-004.do">주문내역</a></li>

				</ul>
			</nav>
</header>