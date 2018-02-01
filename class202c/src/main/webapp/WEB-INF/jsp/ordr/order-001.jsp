<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/inc/common.jsp"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.vo.OrdrVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>

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

<%
	List<ProductVo> productList = (List<ProductVo>) request.getAttribute("productList");
	List<Map<String, Object>> cart = (List<Map<String, Object>>) request.getAttribute("cartView"); // 이게 카트
	int sum = 0;
%>
</head>
<script>
	function onlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
				|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	
	
</script>
<script> /// 체크박스 전체 선택
$(document).ready(function(){
    $("#checkall").click(function(){
        if($("#checkall").prop("checked")){
            $("input[name=chk]").prop("checked",true);
        }else{
            $("input[name=chk]").prop("checked",false);
        }
    })
    
})


</script>
<script>
$(function(){
	  $('#btnDel').click(chkDel);
});
function chkDel() {
	
	var chkList = [];
	$('input[name="chk"]').each(function(){
	   	if($(this).is(":checked")){ 
			var tr = $(this).parent().parent();
			var prdId = tr.find('td:nth-child(2)').text();
	   		chkList.push(prdId);
	   	}
	});
	alert('선택하신 제품을 장바구니에서 삭제 했습니다.');
	var form = document.form;
	form.productId.value = chkList.join(',');
	form.submit();
};


</script>
<script>
$(function(){
	  $('.amntUpdate').click(function() {
		  var cartAmnt = ($(this).siblings('input[name="cartAmnt"]').val());
		  
		  var tr = $(this).parent().parent();
		  var productId = tr.find('td:nth-child(2)').text();
		  alert(productId + '의 수량을 ' + cartAmnt + '개 로 변경하였습니다.');
		  
		  $('#pIDID').val(productId);
		  $('#aIDID').val(cartAmnt);
		  
		  document.update.submit();

	  });
});	  


</script>
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
				<jsp:param name="" value="" />
			</jsp:include>
		</div>
		<br> <br> <br>
		<div id="whole">
			<form name="frm" action="" method="post">
				<div style="text-align: center">
					<H3>
						<B>장바구니</B>
					</H3>
				</div>
				<div class="w3-container  w3-left-align  w3-margin">
					<H4>COMPUZONE 님의 장바구니</H4>
				</div>
				<div class="w3-container  w3-right-align  w3-margin">
					<input type="button" id="btnDel" class="w3-btn w3-blue-grey "	value="선택 삭제">
				</div>

			</form>
		</div>
		<!-- 주문을 위한 form -->
		<form method="post" action="<%=contextPath%>/ordr/finalOrdr.do">
			<div>
				<table border='1'
					class="table table-striped table-bordered table-hover">
					<tr>
						<th class="w3-blue-grey"><input type="checkbox" id="checkall" /></th>
						<th class="w3-blue-grey">부품ID</th>
						<th class="w3-blue-grey">부품명</th>
						<th class="w3-blue-grey">제조사</th>
						<th class="w3-blue-grey">개당가격</th>
						<th class="w3-blue-grey">수량</th>
						<th class="w3-blue-grey">삭제</th>
					</tr>
					<%
						for (Map<String, Object> row : cart) {
					%>
					<tr class="temp">
						<td><input type="checkbox" name="chk" value="" /></td>
						<%--  <td><%=row.get("cartId")%></td> --%>
						<td><%=row.get("productId")%><input type="hidden" name="productId" value="<%=row.get("productId")%>"></td>
						<td><%=row.get("productNm")%></td>
						<td><%=row.get("ptnrNm")%></td>
						<td class="td3" style="text-align: 'right';"><%=Utils.customNum(row.get("salesCost").toString(), "###,##0")%>원</td>
						<td>
						
						<input type="text" name="cartAmnt" value="<%=row.get("cartAmnt")%>" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'
						style="width: 40px; ime-mode: disabled;">
						<input type="button" class="amntUpdate" value="변경 저장" name="amntUpdate">
						
						</td>
						<td><a href="<%=contextPath%>/ordr/delCart.do?productId=<%=row.get("productId")%>"> 삭제 </a></td>
				    </tr>
					<%
						sum += Integer.parseInt(row.get("salesCost").toString())
									* Integer.parseInt(row.get("cartAmnt").toString());
						}
					%>
					<tr>
						<td colspan="4"></td>
						<td text-align="right">장바구니 금액 합계</td>
						<td text-align="right"><%=Utils.customNum(String.valueOf(sum), "###,##0")%>
							원<input type="hidden" name="sum"
							value="<%=Utils.customNum(String.valueOf(sum), "##0")%>"></td>
						<!--  (각각의 상품*각각의 구매 갯수)의 총합 -->
						<td></td>
					</tr>
				</table>
			</div>
			<input type="submit" class="w3-btn w3-blue-grey" value="주문하기">
			<%-- <a href="<%=contextPath%>/ordr/ordr-002.do" class="w3-btn w3-blue-grey w3-center-align" id="order"> --%>
		</form>
	</div>
	<form name="form" method="post" action="<%=contextPath%>/ordr/delCart.do">
		<input type="hidden" name="productId" value="">
	</form>
	<form name="update" method="post" action="<%=contextPath%>/ordr/amntUpdate.do">
		<input type="hidden" id="pIDID" name="productId" value="">
		<input type="hidden" id="aIDID" name="cartAmnt" value="">
	</form>
	

	
</body>
</html>