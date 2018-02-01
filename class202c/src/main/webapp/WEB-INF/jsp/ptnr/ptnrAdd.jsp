<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.util.List"%>
<%
	Map<String, String> rtnParam = (Map<String,String>)request.getAttribute("rtnParam");
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
	String msg = "";
	
	if(rtnParam !=null){
		ptnrId = Utils.toEmptyBlank(rtnParam.get("ptnrId"));
		ptnrNm = Utils.toEmptyBlank(rtnParam.get("ptnrNm"));
		ptnrNmEng = Utils.toEmptyBlank(rtnParam.get("ptnrNmEng")); 
		registerNo = Utils.toEmptyBlank(rtnParam.get("registerNo"));
		type = Utils.toEmptyBlank(rtnParam.get("type"));
		addr = Utils.toEmptyBlank(rtnParam.get("tel"));
		tel = Utils.toEmptyBlank(rtnParam.get("addr"));
		fax = Utils.toEmptyBlank(rtnParam.get("fax"));
		ceoNm = Utils.toEmptyBlank(rtnParam.get("ceoNm"));
		cltNm = Utils.toEmptyBlank(rtnParam.get("cltNm"));
		cltTel = Utils.toEmptyBlank(rtnParam.get("cltTel"));
		cmnt = Utils.toEmptyBlank(rtnParam.get("cmnt"));
		msg = Utils.toEmptyBlank(rtnParam.get("msg"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>파트너사추가</title>
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
	$('#goToList').click(function(){
		location.href = "<%=contextPath%>/ptnr/ptnrList.do";
	});
	
	$('#ptnrType').click(function(){
		$.ajax({
			url : '<%=contextPath%>/ptnr/ptIdGenerator.do',
				data : {
					type : $('#ptnrType').val()},
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					$('#ptnrId').val(data.ptId);
					$('#type').val(data.ptId.substr(0,4));
				},
				error : function(jqXHR, status, errorThrown){
					alert('ERROR:' + JSON.stringify(jqXHR));
			}
	});
		
	});
	
	$('#ptnrType1').click(function(){
		$.ajax({
			url : '<%=contextPath%>/ptnr/ptIdGenerator.do',
				data : {
					type : $('#ptnrType1').val()},
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					$('#ptnrId').val(data.ptId);
					$('#type').val(data.ptId.substr(0,4));
				},
				error : function(jqXHR, status, errorThrown){
					alert('ERROR:' + JSON.stringify(jqXHR));
			}
	});
		
	});
	
	$('#doSubmit').click(function(){
		
		if($('#ptnrId').val()<=0){
			alert('분류를 선택해주세요');
		}else if($('#ptnrNm').val()<=0){
			alert('회사명을 입력해주세요');
		}else if($('#registerNo').val()<=0){
			alert('사업자등록번호를 입력해주세요');
		}else if($('#addr').val()<=0){
			alert('주소를 입력해주세요');
		}else if($('#tel').val()<=0){
			alert('전화번호를 입력해주세요');
		}else if($('#ceoNm').val()<=0){
			alert('대료이름을 입력해주세요');
		}else{
			document.frm.submit();
		}
	})
	
	
	
	
});

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
		<br><br><br><br><br>
		
			<div>
				
					<div style="text-align: center">
						<H3>
							<B>파트너사추가</B>
						</H3>
					</div>
				
			</div>
		<div id="contents">
		<form name="frm" action="<%=contextPath %>/ptnr/ptnrAdd.do" method="post" >
			
			<table border='1' class="table table-striped table-bordered table-hover" id="add">
					<tr>
						<th class="w3-blue-grey">분류</th>
						<td><input type="radio" name="ptnrType" id="ptnrType" value = "1000">제조사
							<input type="radio" name="ptnrType" id="ptnrType1" value = "2000">소매처
							<input type="hidden"  name="TYPE" id="type" value="<%=type %>">
						</td>
					</tr>
					<tr>
						<th class="w3-blue-grey">파트너ID</th>
						<td><input type="text" name="PTNR_ID" id="ptnrId" value = "<%=ptnrId%>" readonly></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">회사명</th>
						<td><input type="text" name="PTNR_NM" id="ptnrNm" ></td>

					</tr>
					<tr>
						<th class="w3-blue-grey">회사영문명</th>
						<td><input type="text" name="PTNR_NM_ENG" id="ptnrNmEng" value = "<%=ptnrNmEng %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">사업자등록번호</th>
						<td><input type="text" name="REGISTER_NO" id="registerNo" value="<%=registerNo %>" ></td>
					</tr>			
					<tr>
						<th class="w3-blue-grey">주소</th>
						<td><input type="text"  name="ADDR" id="addr" value="<%=addr %>"></td>
					</tr>			
					<tr>
						<th class="w3-blue-grey">전화번호</th>
						<td><input type="text" name="TEL" id="tel" value="<%=tel %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">팩스</th>
						<td><input type="text" name="FAX" id="fax" value="<%=fax %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">대표이름</th>
						<td><input type="text" name="CEO_NM" id="ceoNm" value="<%=ceoNm %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">담당자이름</th>
						<td><input type="text" name="CLT_NM" id="cltNm" value="<%=cltNm %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">담당자번호</th>
						<td><input type="text" name="CLT_TEL" id="cltTel" value="<%=cltTel %>"></td>
					</tr>
					<tr>
						<th class="w3-blue-grey">코멘트</th>
						<td><input type="text" name="CMNT" id="cmnt" value="<%=cmnt %>"></td>
					</tr>
				</table>	
			
		</form>
		</div>
		<div class="w3-container  w3-left-align  w3-margin">
				<input type = "button" value = "취소" id ="goToList">
				<input type = "button" value = "파트너사추가" id="doSubmit">
		</div>
		<div id=footer"></div>
	</div>


</body>
</html>