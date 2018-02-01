<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>

<%
	ProductVo productDetail = (ProductVo)request.getAttribute("productDetail");
	String pId = (String)request.getAttribute("pId");
	List<CategoryVo> ctgrList = (List<CategoryVo>)request.getAttribute("ctgrList");
	Map<String,String> productDetailMap = (Map<String,String>) request.getAttribute("productDetailMap");
	
	String productId	= pId;  
	String productNm	= Utils.toEmptyBlank(productDetailMap.get("productNm"));
	String ptnrId		= Utils.toEmptyBlank(productDetailMap.get("ptnrId"));
	String ptnrNm		= Utils.toEmptyBlank(productDetailMap.get("ptnrNm"));
	String ctgr1st		= Utils.toEmptyBlank(productDetailMap.get("ctgr1st"));
	String ctgr2nd		= Utils.toEmptyBlank(productDetailMap.get("ctgr2nd"));
	String ctgr3rd		= Utils.toEmptyBlank(productDetailMap.get("ctgr3rd"));
	String ctgrid1st	= Utils.toEmptyBlank(productDetailMap.get("ctgrid1st"));
	String ctgrid2nd	= Utils.toEmptyBlank(productDetailMap.get("ctgrid2nd"));
	String ctgrid3rd	= Utils.toEmptyBlank(productDetailMap.get("ctgrid3rd"));	
	String stock 		= Utils.toEmptyBlank(productDetailMap.get("stock"));
	String safetyStock	= Utils.toEmptyBlank(productDetailMap.get("safetyStock"));
	String unitPrice 	= Utils.toEmptyBlank(productDetailMap.get("unitPrice"));
	String salesCost	= Utils.toEmptyBlank(productDetailMap.get("salesCost"));
	String cmnt			= Utils.toEmptyBlank(productDetailMap.get("cmnt"));
	
	
	Map<String, String> rtnParams =  (Map<String, String>) request.getAttribute("reAttr");
	if (rtnParams != null){
		productId	= rtnParams.get("productId");
		ptnrId		= rtnParams.get("ptnrId");
		ptnrNm		= rtnParams.get("ptnrNm");
		productNm	= rtnParams.get("productNm");
		ctgr1st		= rtnParams.get("ctgr1st");
		ctgr2nd		= rtnParams.get("ctgr2nd");
		ctgr3rd		= rtnParams.get("ctgr3rd");
		cmnt		= rtnParams.get("cmnt");
		salesCost	= rtnParams.get("salesCost");
		safetyStock = rtnParams.get("safetyStock");	
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
<link rel="stylesheet" href="<%=contextPath%>/css/common.css">
</head>
<script>

$(function(){
	
	//ctgr 2nd 호출
	$('#ctgr1st').change(function(){
		$("#ctgr3rd").html('<option value="N">소분류</option>');
		if( $('#ctgr1st').val() != 'N' ) {
		$.ajax({
			url : '<%=contextPath%>/category/findCtgr.do',
				data : {
					ctgrId : $('#ctgr1st').val() },
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					var	title = '<option value="N">중분류</option>';
					var options='';					
					var list = data.ctgrList;
				      for (var i = 0; i < list.length; i++) {
				    	  options += '<option value="' + list[i].ctgrId + '">' + list[i].ctgrNm + '</option>';
				      }				     
				      $("#ctgr2nd").html(title+options);				      
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: ' + JSON.stringify(jqXHR));
				}
			});	
		
		}else {
			$("#ctgr2nd").html('<option value="N">중분류</option>');
									
		}
		});	
	
	//ctgr 3rd 호출
	$('#ctgr2nd').change(function(){
		if( $('#ctgr2nd').val() != 'N' ) {
		$.ajax({
			url : '<%=contextPath%>/category/findCtgr.do',
				data : {
					ctgrId : $('#ctgr2nd').val() },
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					var	title = '<option value="N">소분류</option>';
					var options='';					
					var list = data.ctgrList;
				      for (var i = 0; i < list.length; i++) {
				    	  options += '<option value="' + list[i].ctgrId + '">' + list[i].ctgrNm + '</option>';
				      }				     
				      $("#ctgr3rd").html(title+options);				      
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: ' + JSON.stringify(jqXHR));
				}
			});
		}else {
			$("#ctgr3rd").html('<option value="N">소분류</option>');						
		}		
	});	
	
	//파트너사 검색
	$('#ptnrSearch').click(function(){
		window.open("<%=contextPath%>/ptnr/ptnrSearch.do", "window");
	});
	//detail 돌아가는 페이지
	$('#goToDetail').click(function(){
		location.href = "<%=contextPath%>/product/productDetail.do?productId=<%=productId%>";
	});
	
	//submit일어날때 값 검증하는 구간
	$('#doSubmit').click(function(){
		if($('#ptnrId').val() === undefined || $('#productNm').val() === undefined || $('#salesCost').val() === undefined || $('#safetyStock').val() === undefined || isNaN($('#salesCost').val()) ||  isNaN($('#safetyStock').val()) ){
			alert ('제품ID/제품이름/제조사ID/판매가격을 다시 확인해 주세요');
			}else if ($('#salesCost').val()<=0 || $('#safetyStock').val()<=0 ){ 
			alert ('판매가격과 안전재고를 제대로 입력해주세요');
			}else{
			document.productModifyFrm.submit();				
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
				<form name="productModifyFrm" action="<%=contextPath %>/product/productModify.do" method="post">

				<table border='1' class="table table-striped table-bordered table-hover">
					<tr>
						<td class="w3-blue-grey">부품ID</td>
						<td>
						<label id="item"> <input type="text" name="productId" id="productId" value = "<%=productId%>"readonly ></label>
						</td>

					</tr>
					<tr>
						<td class="w3-blue-grey">부품명</td>
						<td><input type="text" name="productNm" id="productNm" value="<%=productNm%>"></td>
					</tr>
					<tr>

						<td class="w3-blue-grey">제조사ID</td>
						<td><input type="text" name="ptnrId" value = "<%=ptnrId %>" id="ptnrId" readonly ></td>

					</tr>
					<tr>

						<td class="w3-blue-grey">제조사</td>
						<td><input type="text" name="prntrNm" value="<%=ptnrNm %>"  id="ptnrNm" readonly >
						<input type="button" id = "ptnrSearch" value="제조사검색">
						</td>

					</tr>
					<tr>
						<td class="w3-blue-grey">분류</td>
						<td>
						<label id="ctgr"><%=ctgr1st%> > <%=ctgr2nd%> > <%=ctgr3rd%></label>
						<input type="hidden" name="ctgrid1st" value="<%=ctgrid1st%>">
						<input type="hidden" name="ctgrid2nd" value="<%=ctgrid2nd%>">
						<input type="hidden" name="ctgrid3rd" value="<%=ctgrid3rd%>">
						<input type = "button" name="ctgrModify" value = "카테고리 검색">
						</td>
						
					</tr>	
					<tr>					
						<td class="w3-blue-grey">재고수량</td>
						<td><input type="text" name="stock" id="stock" value="<%=stock%>" readonly></td>						
						
					</tr>
					<tr>
						<td class="w3-blue-grey">안전재고</td>
						<td><input type="text"  name="safetyStock" id = "safetyStock" value="<%=safetyStock%>"
						onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'></td>
						
					</tr>
					<tr>
						<td class="w3-blue-grey">매입가격</td>
						<td><input type="text" name="unitPrice" id="unitPrice" value="<%=unitPrice%>" readonly></td>
					
					</tr>
					<tr>
						<td class="w3-blue-grey">판매가격</td>
						<td><input type="text" name="salesCost" id ="salesCost" value="<%=salesCost%>"
						onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;'></td>	
					</tr>	
					<tr>
						<td class="w3-blue-grey">코멘트</td>
						<td><textarea cols="30" id ="cmnt" name="cmnt"><%=cmnt%></textarea>						
						</td>
					</tr>				
				</table>
				</form>
				<input type = "button" value = "등록하기" id="doSubmit">
				<input type = "button" value = "취소" id ="goToDetail">
		</div>
	
</body>

</html>