<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>

<%
	ProductVo productDetail = (ProductVo)request.getAttribute("productDetail");
	String pId = (String)request.getAttribute("pId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>더조은 총판</title>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="<%=contextPath %>/css/w3.css">
<link rel="stylesheet" href="<%=contextPath%>/css/common.css">
</head>
<script>
	
</script>
<style>
#whole {
	width: 1500px;
	position: center;
	margin-left: auto;
	margin-right: auto;
}

#header {
	position: center;
	width: 1500px;
	margin-left: auto;
	margin-right: auto;
}

h1 {
	font-family: "Trebuchet MS", Dotum, Arial;
	float: left;
	text-align: center;
	left: 50%;
}

h3 {
	font-family: "Trebuchet MS", Dotum, Arial;
	margin: 15px 0px;
}

#topMenu {
	height: 30px;
	width: 950px;
	text-align: center;
	float: left;
	margin-top: 40px;
}

#topMenu ul li {
	list-style: none;
	color: white;
	background-color: #2d2d2d;
	float: left;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
}

#topMenu .menuLink {
	text-decoration: none;
	color: white;
	display: block;
	width: 150px;
	font-size: 16px;
	font-weight: bold;
	font-family: "Trebuchet MS", Dotum, Arial;
	text-align: center;
}

#topMenu .menuLink:hover {
	color: #ff3;
	background-color: #4d4d4d;
}

#mainimg {
	float: left;
}

#form {
	margin-top: 80px;
	position: center;
	margin-left: auto;
	margin-right: auto;
}
</style>

<body>
	<div id="whole">
		<div>
			<header id="header">
				<a href="<%=contextPath%>/manage-000.html"> 
				<img src="<%=contextPath %>/img/더조은 메인.jpg" id=mainimg></a> <br>
				<nav id="topMenu">
					<ul>
						<li><a class="menuLink" href="manage-001.html">판매/출고</a></li>
						<li><a class="menuLink" href="order-100.html">발주/입고</a></li>
						<li><a class="menuLink" href="manage-005.html">재고 관리</a></li>
						<li><a class="menuLink" href="manage-008.html">파트너사 관리</a></li>
						<li><a class="menuLink" href="manage-003.html">부품 등록</a></li>
						<li><a class="menuLink" href="manage-009.html">카테고리 등록</a></li>
					</ul>
				</nav>
			</header>
		</div>
		<br>
		<div id="contents">
				<div style="text-align: center">
					<H3>
						<B>제품 상세 정보</B>
					</H3>
				</div>
				</div>
				<div id="buttons">

					<br> <br> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
					<div class="w3-container  w3-left-align  w3-margin">
					</div>
				</div>			
				<div>
				<a href="<%=contextPath %>/product/productList.do">
				<input type = "button" value = "부품 목록"></a>
				</div>

				<table border='1' class="table table-striped table-bordered table-hover">
				
					<tr>
						<td class="w3-blue-grey">부품ID</td>
						<td><%=pId%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">부품명</td>
						<td><%=productDetail.getProductNm()%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">제조사 / 제조사 ID</td>
						<td><%=productDetail.getPtnrNm()%> / <%=productDetail.getPtnrId() %></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">분류</td>
						<td><%=productDetail.getCtgr1st()%> > <%=productDetail.getCtgr2nd()%> > <%=productDetail.getCtgr3rd()%></td>
					</tr>
					<tr>					
						<td class="w3-blue-grey">재고수량</td>						
						<td><%=productDetail.getStock()%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">안전재고</td>
						<td><%=productDetail.getSafetyStock()%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">매입가격</td>
						<td><%=productDetail.getUnitPrice()%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">판매가격</td>
						<td><%=productDetail.getSalesCost()%></td>
					</tr>					
				</table>
				<a href="<%=contextPath %>/productModifyView?productId=<%=pId%>">
				<input type = "button" value = "부품 수정"></a>
		</div>
	
</body>

</html>