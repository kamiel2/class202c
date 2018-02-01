<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>


<%	
	String pId = (String)request.getAttribute("pId");
		
	//String productId	="";  
	/*
	ProductVo productDetail = (ProductVo)request.getAttribute("productDetail");
	//VO를 사용했던..
	
	String productNm	= Utils.toEmptyBlank(productDetail.getProductNm()  );
	String ptnrId		= Utils.toEmptyBlank(productDetail.getPtnrId()     );
	String ptnrNm		= Utils.toEmptyBlank(productDetail.getPtnrNm()	   );
	String ctgr1st		= Utils.toEmptyBlank(productDetail.getCtgr1st()    );
	String ctgr2nd		= Utils.toEmptyBlank(productDetail.getCtgr2nd()    );
	String ctgr3rd		= Utils.toEmptyBlank(productDetail.getCtgr3rd()    );
	String stock 		= Utils.toEmptyBlank(productDetail.getStock()      );
	String safetyStock	= Utils.toEmptyBlank(productDetail.getSafetyStock());
	String unitPrice 	= Utils.toEmptyBlank(productDetail.getUnitPrice()  );
	String salesCost	= Utils.toEmptyBlank(productDetail.getSalesCost()  );
	String cmnt			= Utils.toEmptyBlank(productDetail.getCmnt()       );
	*/
	
	Map<String,String> productDetailMap = (Map<String,String>) request.getAttribute("productDetailMap");
	//Map사용함
	String productNm	= Utils.toEmptyBlank(productDetailMap.get("productNm"));
	String ptnrId		= Utils.toEmptyBlank(productDetailMap.get("ptnrId"));
	String ptnrNm		= Utils.toEmptyBlank(productDetailMap.get("ptnrNm"));
	String ctgr1st		= Utils.toEmptyBlank(productDetailMap.get("ctgr1st"));
	String ctgr2nd		= Utils.toEmptyBlank(productDetailMap.get("ctgr2nd"));
	String ctgr3rd		= Utils.toEmptyBlank(productDetailMap.get("ctgr3rd"));
	String stock 		= Utils.toEmptyBlank(productDetailMap.get("stock"));
	String safetyStock	= Utils.toEmptyBlank(productDetailMap.get("safetyStock"));
	String unitPrice 	= Utils.toEmptyBlank(productDetailMap.get("unitPrice"));
	String salesCost	= Utils.toEmptyBlank(productDetailMap.get("salesCost"));
	String cmnt			= Utils.toEmptyBlank(productDetailMap.get("cmnt"));
	
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

				<table border='1' class="table table-striped table-bordered table-hover">
				
					<tr>
						<td class="w3-blue-grey">부품ID</td>
						<td><%=pId%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">부품명</td>
						<td><%=productNm%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">제조사 ID / 제조사</td>
						<td><%=ptnrId %> / <%=ptnrNm%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">분류</td>
						<td><%=ctgr1st%> > <%=ctgr2nd%> > <%=ctgr3rd%></td>
					</tr>
					<tr>					
						<td class="w3-blue-grey">재고수량</td>						
						<td><%=Utils.customNum(stock, "###,###,##0")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">안전재고</td>
						<td><%=Utils.customNum(safetyStock, "###,###,##0")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">매입가격</td>
						<td><%=Utils.customNum(unitPrice, "###,###,##0")%></td>
					</tr>
					<tr>
						<td class="w3-blue-grey">판매가격</td>
						<td><%=Utils.customNum(salesCost, "###,###,##0")%></td>
					</tr>					
					<tr>
						<td class="w3-blue-grey">코멘트</td>
						<td><textarea cols="30" name="contents"><%=cmnt%></textarea>						
						</td>
					</tr>					
				</table>
				<a href="<%=contextPath %>/product/productModifyView.do?productId=<%=pId%>">
				<input type = "button" value = "부품 수정"></a>
				<a href="<%=contextPath %>/purchase/purchaseAddView.do?productId=<%=pId%>">
				<input type = "button" value = "부품 발주"></a>
		</div>
	
</body>

</html>