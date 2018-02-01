<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>

<%
	Map<String,String>detailList = (Map<String, String>) request.getAttribute("purchaseAddDetail");

	String productId	=detailList.get("productId");  
	String productNm	=detailList.get("productNm");  
	String ptnrId		=detailList.get("ptnrId");     
	String ptnrNm		=detailList.get("ptnrNm"); 	
	String stock		=detailList.get("stock");
	String safetyStock	=detailList.get("safetyStock");
	String salesCost	=detailList.get("salesCost");
	String avgUnitPrice	=detailList.get("avgUnitPrice");
	String purchaseSum 		="";
	String amnt 		="";
	String cmnt			="";
	
	Map<String, String> rtnParams =  (Map<String, String>) request.getAttribute("reAttr");
	if (rtnParams != null){
		productId	= rtnParams.get("productId");
		productNm	= rtnParams.get("productNm");
		ptnrId		= rtnParams.get("ptnrId");
		ptnrNm		= rtnParams.get("ptnrNm");		
		stock		= rtnParams.get("stock");	
		safetyStock = rtnParams.get("safetyStock");	
		salesCost	= rtnParams.get("salesCost");
		avgUnitPrice= rtnParams.get("avgUnitPrice");
		amnt 		= rtnParams.get("amnt");
		cmnt		= rtnParams.get("cmnt");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더조은 총판</title>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="<%=contextPath %>/css/w3.css">
</head>
<script>
$(function(){
	$('#goToList').click(function(){
		location.href = "<%=contextPath%>/product/productList.do";
	});

	
	//submit일어날때 값 검증하는 구간
	$('#doSubmit').click(function(){
	if($('#ptnrId').val() === undefined || $('#productId').val() === undefined || $('#amnt').val() === undefined || $('#purchaseSum').val() === undefined || isNaN($('#amnt').val()) ||  isNaN($('#purchaseSum').val()) ){
		alert ('제품ID/제품이름/제조사ID/판매가격을 다시 확인해 주세요');
		}else if ($('#amnt').val()<=0 || $('#purchaseSum').val()<=0 ){ 
		alert ('발주 가격과 발주 수량을 제대로 입력해 주세요');
		}else{			
			document.purchaseAddFrm.submit();				
			}	
	});
	
	
	
});

//숫자만 입력하게 강제한다.
function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}


	
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
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
		<br><br><br><br><br>		
			<div>				
					<div style="text-align: center">
						<H3>
							<B>발주 등록</B>
						</H3>
					</div>
				
			</div>
			<div id="contents">
			<form name="purchaseAddFrm" action="<%=contextPath %>/purchase/purchaseAdd.do" method="post">
				<table border='1' class="table table-striped table-bordered table-hover" id="add">
					<tr>
						<th class="w3-blue-grey">부품ID</th>
						<td><label id="item"> <input type="text" name="productId" id="productId" value = "<%=productId%>"readonly ></label></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">부품명</th>
						<td><label id="itemnm"> <input type="text" id="productNm" value="<%=productNm%>"></label></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">제조사ID</th>
						<td><label id="item"><input type="text" name="ptnrId" id="ptnrId" value = "<%=ptnrId %>"  readonly ></label>
						</td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">제조사</th>
						<td><label id="item"><input type="text" id="ptnrNm" value="<%=ptnrNm %>"   readonly ></label>	
						</td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">현재재고</th>
						<td><input type="text" readonly value="<%=stock %>"></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">안전재고</th>
						<td><input type="text"  readonly value="<%=safetyStock %>"></td>
					</tr>									
					<tr>
						<th class="w3-blue-grey">판매가격</th>
						<td><input type="text"  readonly value="<%=Utils.customNum(salesCost, "###,###,##0") %>"></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">현재재고평균단가</th>
						<td><input type="text"  readonly value="<%=Utils.customNum(avgUnitPrice, "###,###,##0") %>"></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">발주 가격</th>
						<td><input type="text"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="purchaseSum" id ="purchaseSum" value="<%=purchaseSum%>"></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">발주 수량</th>
						<td><input type="text"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="amnt" id ="amnt" value=""></td>
					</tr>								
					<tr>
						<th class="w3-blue-grey">코멘트</th>
						<td><textarea cols="30"  name="contents" id ="cmnt"><%=cmnt%></textarea></td>
					</tr>
				</table>
				</form>
			</div>
			<div class="w3-container  w3-left-align  w3-margin">
				<input type = "button" value = "취소" id ="goToList">
				<input type = "button" value = "등록하기" id="doSubmit">
			</div>
		</div>
</body>

</html>