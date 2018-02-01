<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.util.List"%>
<%
	Map<String, String> rtnParams = (Map<String,String>)request.getAttribute("ptnr");
	String ptnrId = "";
	String ptnrNm = "";
	String ptnrNmEng = "";
	String registerNo = "";
	String type = "";
	String addr = "";
	String tel = "";
	String fax = "";
	String ceoNm = "";
	String cltNm = "";
	String cltTel = "";
	String cmnt = "";
	    
	if(rtnParams !=null){
		ptnrId = Utils.toEmptyBlank(rtnParams.get("ptnrId"));
		ptnrNm = Utils.toEmptyBlank(rtnParams.get("ptnrNm"));
		ptnrNmEng = Utils.toEmptyBlank(rtnParams.get("ptnrNmEng")); 
		registerNo = Utils.toEmptyBlank(rtnParams.get("registerNo"));
		type = Utils.toEmptyBlank(rtnParams.get("type"));
		addr = Utils.toEmptyBlank(rtnParams.get("addr"));
		tel = Utils.toEmptyBlank(rtnParams.get("tel"));
		fax = Utils.toEmptyBlank(rtnParams.get("fax"));
		ceoNm = Utils.toEmptyBlank(rtnParams.get("ceoNm"));
		cltNm = Utils.toEmptyBlank(rtnParams.get("cltNm"));
		cltTel = Utils.toEmptyBlank(rtnParams.get("cltTel"));
		cmnt = Utils.toEmptyBlank(rtnParams.get("cmnt"));
		
	}
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
		location.href='<%=contextPath%>/ptnr/ptnrModifyView.do';
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
		<br>
		
		
		<div id="contents">
			<div style="text-align: center">
					<H3>
						<B>파트너사 수정</B>
					</H3>
				</div>
				</div>
			<div>
				<br> <br> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
			</div>
			<table border='1' class="table table-striped table-bordered table-hover">
				
					<tr>
						<td class="w3-blue-grey" width="500px">파트너ID</td>
						<td><label id="PTNR_ID"> <%=ptnrId%></label></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">회사명</td>
						<td><input type="text" name="PTNR_NM" value="<%=ptnrNm%>"></td>
					</tr>
					<tr>

						<th class="w3-blue-grey">회사영문명</th>
						<td><input type="text" name="PTNR_NM_ENG" value = "<%=ptnrNmEng %>" id="ptnrId" readonly ></td>

					</tr>
					<tr>

						<th class="w3-blue-grey">사업자등록번호</th>
						<td><input type="text" name="REGISTER_NO" value="<%=registerNo %>"  id="ptnrNm" readonly >
					
						</td>

					</tr>
					<tr>
						<td class="w3-blue-grey">분류</td>
						<td><input type="text" name="TYPE" value="<%=type%>" readonly>
						
						</td>
						
					</tr>	
					<tr>					
						<td class="w3-blue-grey">주소</td>
						<td><input type="text" name="ADDR" value="<%=addr%>" readonly></td>						
						
					</tr>
					<tr>
						<td class="w3-blue-grey">전화번호</td>
						<td><input type="text" name="TEL" value="<%=tel%>"
						onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'></td>
						
					</tr>
					<tr>
						<td class="w3-blue-grey">팩스</td>
						<td><input type="text" name="FAX" value="<%=fax%>" readonly></td>
					
					</tr>
					<tr>
						<td class="w3-blue-grey">대표이름</td>
						<td><input type="text" name="CEO_NM" value="<%=ceoNm%>">
						</td>	
					</tr>
					<tr>
						<td class="w3-blue-grey">담당자이름</td>
						<td><input type="text" name="CLT_NM" value="<%=cltNm%>">
						</td>	
					</tr>	
					<tr>
						<td class="w3-blue-grey">담당자번호</td>
						<td><input type="text" name="CLT_TEL" value="<%=cltTel%>">
						</td>	
					</tr>	
					<tr>
						<td class="w3-blue-grey">코멘트</td>
						<td><input type="text" name="CMNT" value="<%=cmnt%>">
						</td>	
					</tr>			
				</table>
				<input type="submit" value="파트너사수정">&nbsp;&nbsp;<input type="button" value="목록" id="btnList">
		<div id=footer"></div>
	</div>


</body>
</html>