<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="/class202c/css/w3.css">

</head>

<style>
#whole {
	position: center;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

#topMenu {
	height: 30px;
	width: 850px;
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

#order {
	width: 160px;
	position: absolute;
	height: 40px;
	left: 50%;
	top: 50%;
	margin-left: -80px;
	margin-top: -40px
}
</style>

<body>


<div id="whole">
	<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header2.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
	<br>
	<br>
	<br>
	<div>
		<form name="frm" action="" method="post">
			<div style="text-align: center">
				<H3>
					<B>주문 확인</B>
				</H3>
			</div>
			<div class="w3-container  w3-left-align  w3-margin">
				<H4>COMPUZONE 님의 주문 최종 확정</H4>
			</div>


		</form>
	</div>
	<div>
		<table border='1'
			class="table table-striped table-bordered table-hover">
			<!--  표 전체 readonly 로 설정 -->
			<tr>
				<th class="w3-blue-grey">부품ID</th>
				<th class="w3-blue-grey">부품명</th>
				<th class="w3-blue-grey">제조사</th>
				<th class="w3-blue-grey">수량</th>
				<th class="w3-blue-grey">개당금액</th>
				<th class="w3-blue-grey">금액</th>
			</tr>
			<tr class="temp">
				<td>01425706</td>
				<td>GALAXY1080TI</td>
				<td>GALAXY</td>
				<td>10</td>
				<td>1,395,000</td>
				<td>13,950,000</td>
			</tr>
			<tr>
				<td>01370862</td>
				<td>GIGABYTE GTX1070 8GB</td>
				<td>GIGABYTE</td>
				<td>20</td>
				<td>598,000</td>
				<td>11,960,000</td>
			</tr>
			<tr>
				<td colspan="4"></td>
				<td>총합</td>
				<td>25,910,000</td>
			</tr>
		</table>
	</div>
	<div class="w3-container  w3-right-align  w3-margin">
		<a href="<%=contextPath%>/ordr/ordr-003.do" class="w3-btn w3-blue-grey" id="order">주문확정</a>
	</div>
</div>
</body></html>