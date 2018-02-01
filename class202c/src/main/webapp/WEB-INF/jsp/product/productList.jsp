<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>

<%
	List<ProductVo> productList = (List<ProductVo>) request.getAttribute("productList");
	String searchValue = (String)request.getAttribute("searchValue");
	String searchType = (String)request.getAttribute("searchType");
	List<CategoryVo> ctgrList = (List<CategoryVo>)request.getAttribute("ctgrList");
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
<link rel="stylesheet" href="/class202c/css/w3.css">
</head>
<script>

$(function(){
	selectList();
	$('#productAdd').click(function(){
		location.href="<%=contextPath%>/product/productAddView.do";		
	});
	
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
	

	$('#doSearch').click(function(){
		selectList();		
	});	
	
	$('#productId, #productNm, #ptnrNm').keydown(function(event ){
		if ( event.which == 13 ) {
			$('#doSearch').click();	
			return false;
		}				
	});		
});

function sprintf(str) {
    var args = arguments,
      flag = true,
      i = 1;
  
    str = str.replace(/%s/g, function() {
      var arg = args[i++];
  
      if (typeof arg === 'undefined') {
        flag = false;
        return '';
      }
      return arg;
    });
    return flag ? str : '';
  }

function selectList(){
	var a = '<tr><td>%s</td>'+
			'<td><a href = "/class202c/product/productDetail.do?productId=%s">%s</a></td>'+
			'<td>%s</td>'+
			'<td>%s > %s > %s</td>'+				
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td><a href="<%=contextPath %>/product/productModifyView.do?productId=%s"	class="w3-btn w3-blue-grey">수정</a></td>	</tr>';
	$.ajax({
		url : '<%=contextPath%>/product/productSearch.do',
			data : {
				ctgr1st : $('#ctgr1st').val(), ctgr2nd : $('#ctgr2nd').val(), ctgr3rd : $('#ctgr3rd').val(),
				//searchType : $("#searchType option:selected").val(), searchValue : $("#searchValue").val()
				productId : $('#productId').val(), productNm : $('#productNm').val(), ptnrNm : $('#ptnrNm').val()
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {					
				var options='';					
				var list = data.result;
			      for (var i = 0; i < list.length; i++) {
			    	  options += sprintf(a, 
			    			  list[i].productId,
			    			  list[i].productId, 
			    			  list[i].productNm, 
			    			  list[i].ptnrNm, 
			    			  list[i].ctgr1st, list[i].ctgr2nd, list[i].ctgr3rd, 
			    			  numberWithCommas(list[i].stock), 
			    			  numberWithCommas(list[i].safetyStock), 
			    			  numberWithCommas(Number(list[i].unitPrice).toFixed(0)), 
			    			  numberWithCommas(list[i].salesCost), 
			    			  list[i].productId
			    			  ); 	  
			      }				     
			      $("#list tbody").html(options);
			      
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: ' + JSON.stringify(jqXHR));
			}
		});
	
}
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
		<jsp:param name="curMenu" value="board"/>
		</jsp:include>
		</div>
		<br>
		<div>
				<div style="text-align: center">
					<H3>
						<B>제품조회/수정페이지(관리자)</B>
					</H3>
				</div>

				<div id="buttons">
					<br> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
					<!-- 검색부분 -->
					<div class="w3-container  w3-left-align  w3-margin" id="frm">
					<form action="<%=contextPath%>/product/productView.do" method="post" name="searchFrm" id="searchFrm">
					
					<div class="w3-container  w3-right-align  w3-margin">
					<table>
						<tr>
						<td><select name="ctgr1st" id = "ctgr1st" size="6" style="width: 200px">
								<option value="N">대분류</option>
								<%for(CategoryVo row : ctgrList){ %>
								<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
								<%} %>

						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr2nd" id = "ctgr2nd" size="6" style="width: 200px">
						<option value="N">중분류</option>
									
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr3rd" id = "ctgr3rd" size="6" style="width: 200px">
						<option value="N">소분류</option>								

						</select>&nbsp;&nbsp;</td>
						</tr>
					</table>
					</div>
					
					<label class="w3-label">부품id</label>&nbsp;&nbsp;<input type="text" name="productId" id="productId">&nbsp;&nbsp;
	    			<label class="w3-label">부품이름</label>&nbsp;&nbsp;<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
	    			<label class="w3-label">제조사</label>&nbsp;&nbsp;<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
	    			<input type="button" value="검색" id="doSearch">									
					<!-- 삭제될파트 구버전 SELECT 박스 사용-->	
					<!-- 
					<select name="searchType" id="searchType">
									<option value="pId">부품id 검색</option>
									<option value="pNm">부품이름 검색</option>
									<option value="ptnrNm">제조사 검색</option>
	    			</select>    			
							<input type="text" name="searchValue" value="" id="searchValue">
							-->
					<!-- 삭제될파트 -->	
							
					</form>
						<input type = "button" value = "추가" id="productAdd">					
					</div>				
				</div>
					<table border='1' class="table table-striped table-bordered table-hover" id="list">
					<thead>
					<tr>
						<th class="w3-blue-grey">부품ID</th>
						<th class="w3-blue-grey">부품명</th>
						<th class="w3-blue-grey">제조사</th>
						<th class="w3-blue-grey">분류</th>
						<th class="w3-blue-grey">재고수량</th>
						<th class="w3-blue-grey">안전재고</th>
						<th class="w3-blue-grey">매입가격</th>
						<th class="w3-blue-grey">판매가격</th>
						<th class="w3-blue-grey">수정</th>
					</tr>
					</thead>
					<tbody>
					</tbody>

				</table>
		</div>
	</div>
</body>

</html>