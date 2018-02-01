<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.PtnrVo"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%
	String ptnrId = (String)request.getAttribute("ptnrId");
	Map<String,Object> ptnr = (Map<String,Object>)request.getAttribute("ptnr");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>더조은 총판</title>
<script src="<%=contextPath%>/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="<%=contextPath%>/css/w3.css">
<link rel="stylesheet" href="<%=contextPath%>/css/common.css">
<script>
$(function(){
	$('#btnList').click(function(){
		location.href='<%=contextPath%>/ptnr/ptnrList.do';
	});
	$('#btnModify').click(function(){
		location.href='<%=contextPath%>/ptnr/ptnrModifyView.do?ptnrId=<%=ptnrId%>';
	});
})


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
</head>
<body>
	<div id="whole">
		<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
		<div id="contents">
			<div style="text-align: center">
					<H3>
						<B>파트너사 상세 정보</B>
					</H3>
				</div>
				</div>
			<div>
				<br> <br> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
			</div>
			<table border='1' class="table table-striped table-bordered table-hover">
				
					<tr>
						<td class="w3-blue-grey" width="500px">파트너사ID</td>
						<td><%=ptnr.get("ptnrId")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">회사명</td>
						<td><%=ptnr.get("ptnrNm")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">회사영문명</td>
						<td><%=ptnr.get("ptnrNmEng")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">사업자등록번호</td>
						<td><%=ptnr.get("registerNo")%> </td>
					</tr>
					<tr>					
						<td class="w3-blue-grey">분류</td>						
						<td><%=ptnr.get("type")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">주소</td>
						<td><%=ptnr.get("addr")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">전화번호</td>
						<td><%=ptnr.get("tel")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">팩스</td>
						<td><%=ptnr.get("fax")%></td>
					</tr>					
					<tr>
						<td class="w3-blue-grey">대표이름</td>
						<td><%=ptnr.get("ceoNm")%></td>
					</tr>	
					<tr>
						<td class="w3-blue-grey">담당자이름</td>
						<td><%=ptnr.get("cltNm")%></td>
					</tr>		
					<tr>
						<td class="w3-blue-grey">담당자번호</td>
						<td><%=ptnr.get("cltTel")%></td>
					</tr>	
					<tr>
						<td class="w3-blue-grey">코멘트</td>
						<td><%=ptnr.get("cmnt")%></td>
					</tr>						
				</table>
				<input type="button" value="목록" id="btnList">
				<input type="button" value="수정" id="btnModify">
			
			
	</div>


</body>
</html>