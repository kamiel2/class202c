<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>

<%
	List<CategoryVo> ctgrList = (List<CategoryVo>)request.getAttribute("ctgrList");
	String productId	="";  
	String productNm	="";  
	String ptnrId		="";     
	String ptnrNm		=""; 	
	String ctgr1st		="";    
	String ctgr2nd		="";    
	String ctgr3rd		="";  
	String safetyStock	="";
	String salesCost	="";	
	String cmnt			="";
	
	Map<String, String> rtnParams =  (Map<String, String>) request.getAttribute("reAttr");
	if (rtnParams != null){
		productId	= rtnParams.get("productId");
		productNm	= rtnParams.get("productNm");
		ptnrId		= rtnParams.get("ptnrId");
		ptnrNm		= rtnParams.get("ptnrNm");		
		ctgr1st		= rtnParams.get("ctgr1st");
		ctgr2nd		= rtnParams.get("ctgr2nd");
		ctgr3rd		= rtnParams.get("ctgr3rd");	
		safetyStock = rtnParams.get("safetyStock");	
		salesCost	= rtnParams.get("salesCost");		
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
	
	//ctgr 2nd 호출
	$('#ctgr1st').change(function(){
		$("#ctgr3rd").html('<option value="N">소분류</option>');
		$("#productId").val('');
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
		$("#productId").val('');
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
		})
	
	//ctgr3rd를 값을 이용해서 pid 생성
	$('#ctgr3rd').change(function(){
		if( $('#ctgr3rd').val() != 'N' ) {
		$.ajax({
			url : '<%=contextPath%>/product/pIdGenerator.do',
				data : {
					ctgrId : $('#ctgr3rd').val() },
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					$('#productId').val(data.pId);	
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: ' + JSON.stringify(jqXHR));
				}
			});
		}else {
			$("#ctgr3rd").html('<option value="N">소분류</option>');
			$("#productId").val('');			
		}			
		}).trigger('change');
	
	//파트너사 검색
	$('#ptnrSearch').click(function(){
		window.open("<%=contextPath%>/ptnr/ptnrSearch.do", "window");
	});
	
	//submit일어날때 값 검증하는 구간
	$('#doSubmit').click(function(){
	if($('#ptnrId').val() === undefined || $('#productId').val() === undefined || $('#productNm').val() === undefined || $('#salesCost').val() === undefined || $('#safetyStock').val() === undefined || isNaN($('#salesCost').val()) ||  isNaN($('#safetyStock').val()) ){
		alert ('제품ID/제품이름/제조사ID/판매가격을 다시 확인해 주세요');
		}else if ($('#salesCost').val()<=0 || $('#safetyStock').val()<=0 ){ 
		alert ('판매가격과 안전재고를 제대로 입력해주세요');
		}else{
			document.productAddFrm.submit();				
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
							<B>부품 등록</B>
						</H3>
					</div>
				
			</div>
			<div id="contents">
			<form name="productAddFrm" action="<%=contextPath %>/product/productAdd.do" method="post">
				<table border='1' class="table table-striped table-bordered table-hover" id="add">
					<tr>
						<th class="w3-blue-grey">분류</th>
						<td><select name="ctgr1st" id = "ctgr1st">
								<option value="N">대분류</option>
								<%for(CategoryVo row : ctgrList){ %>
								<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
								<%} %>

						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr2nd" id = "ctgr2nd">
						<option value="N">중분류</option>
								
	
								
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr3rd" id = "ctgr3rd">
						<option value="N">소분류</option>
						</select>
						</td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">부품ID</th>
						<td><label id="item"> <input type="text" name="productId" id="productId" value = "<%=productId%>"readonly ></label>
						</td>

					</tr>
					<tr>

						<th class="w3-blue-grey">부품명</th>
						<td><label id="itemnm"> <input type="text" name="productNm" id="productNm" value="<%=productNm%>"></label>
						</td>

					</tr>
					<tr>

						<th class="w3-blue-grey">제조사ID</th>
						<td><label id="item"><input type="text" name="ptnrId" id="ptnrId" value = "<%=ptnrId %>"  readonly ></label> </td>

					</tr>
					<tr>

						<th class="w3-blue-grey">제조사</th>
						<td><label id="item"><input type="text" name="prntrNm" id="ptnrNm" value="<%=ptnrNm %>"   readonly ></label> 
						<input type="button" id = "ptnrSearch" value="제조사검색">
						</td>

					</tr>

					<!--  	<tr>

				<th class="w3-blue-grey">현재재고</th>
				<td> </td> 등록 시에는 당연히 0이기 때문에 재고는 없어도 됨,

			</tr>
			<tr>

				<th class="w3-blue-grey">현재재고평균단가</th>
				<td></td>

			</tr>-
					<tr>

						<th class="w3-blue-grey">입고 가격</th>
						<td>입고 가격</td>

					</tr>
					-->
					<tr>
						<th class="w3-blue-grey">안전재고</th>
						<td><input type="text"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="safetyStock" id = "safetyStock" value="<%=safetyStock %>"></td>
					</tr>					
					<tr>
						<th class="w3-blue-grey">판매가격</th>
						<td><input type="text"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="salesCost" id ="salesCost" value="<%=salesCost %>"></td>
					</tr>			
					<tr>
						<th class="w3-blue-grey">코멘트</th>
						<td><textarea cols="30"  name="contents" id ="cmnt"><%=cmnt%></textarea>						
						</td>
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