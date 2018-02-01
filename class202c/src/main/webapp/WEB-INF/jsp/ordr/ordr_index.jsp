<%@ page language="java" contentType="text/html; charset=utf-8"%>


<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.ohhoonim.vo.OrdrVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ include file="/WEB-INF/jsp/inc/common.jsp"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>

<%
	List<OrdrVo> itemList = (List<OrdrVo>) request.getAttribute("itemList");
	List<ProductVo> productList = (List<ProductVo>) request.getAttribute("productList");
	String searchValue = (String) request.getAttribute("searchValue");
	String searchType = (String) request.getAttribute("searchType");
	List<CategoryVo> ctgrList = (List<CategoryVo>) request.getAttribute("ctgrList");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>더조은 총판</title>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="<%=contextPath%>/js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="/class202c/css/w3.css">

		

</head>
<script>

$(function(){
	
	$('#productAdd').click(function(){
		location.href="<%=contextPath%>/product/productAddView.do";		
	});
	
	//ctgr 2nd 호출
	$('#ctgr1st').change(function(){
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
			$("#ctgr3rd").html('<option value="N">소분류</option>');						
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
	
	$('#productId, #productNm, #ptnrNm').keydown(function(event){
		if ( event.which == 13 ) {
			$('#doSearch').click();	
			return false;
		}				
	});		
	$('.btnPutCart').click(clickPutCart);
	
});

function clickPutCart() {
	var tr = $(this).parent().parent();
	var prdId = tr.find('td:nth-child(1)').text();
	var amnt = tr.find('td:nth-child(7) input:nth-child(1)').val();
	
	var frm = document.frm;
	frm.productId.value = prdId;
	frm.amnt.value = amnt;
	frm.submit();
}

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
			'<td>%s</td>'+
			'<td>%s > %s > %s</td>'+				
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td><input type="text" name="amnt" value="1"  onkeydown="return showKeyCode(event)"></td>'+
			'<td><input type="button" class="w3-btn w3-blue-grey btnPutCart" value="담기" ></form></td>'+
			'</tr>';
	
	$.ajax({
		url : '<%=contextPath%>/product/productSearch.do',
			data : {
				ctgr1st : $('#ctgr1st').val(),
				ctgr2nd : $('#ctgr2nd').val(),
				ctgr3rd : $('#ctgr3rd').val(),
				productId : $('#productId').val(),
				productNm : $('#productNm').val(),
				ptnrNm : $('#ptnrNm').val()
			},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {
				var options = '';
				var list = data.result;
				//console.log(list.length)
				for (var i = 0; i < list.length; i++) {
					options += sprintf(a, list[i].productId, list[i].productNm, list[i].ptnrNm,
							list[i].ctgr1st,list[i].ctgr2nd, list[i].ctgr3rd,
							list[i].stock, list[i].salesCost);
					
					
				
				}
				$("#list tbody").html(options);
				$('.btnPutCart').click(clickPutCart);
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: ' + JSON.stringify(jqXHR));
			}
		});

	}

</script>
<script>
function cartAdd(obj) {
	var tr = $(obj).parent().parent()
	alert(tr.find('td:nth-child(1)').text() + '(' + tr.find('td:nth-child(2)').text() + ')' + '상품을 ' + '\n' + tr.find('td:nth-child(7)').find('input').val() + '개 카트에 담았습니다.');
}
</script>

<script>
// input 숫자만 !!
		function showKeyCode(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
			{
				return;
			}
			else
			{
				return false;
			}
		}
	</script>
<style>
#whole {
	position: center;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

h1 {
	font-family: "Trebuchet MS", Dotum, Arial;
	float: left;
	text-align: center;
	margin-left: 100px;
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
</style>

<body>

	<div id="whole">
		<div>
			<jsp:include page="/WEB-INF/jsp/inc/menu_header2.jsp">
				<jsp:param name="" value="" />
			</jsp:include><br/><br/><br/>    

			<br/><br/><br/>
		</div>
		<div>

			<div style="text-align: center">
				<H3>
					<B>제품조회/선택(구매자 페이지)</B>
				</H3>
			</div>

			<div id="buttons">
				<br> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
				<!-- 검색부분 -->
				<div class="w3-container  w3-left-align  w3-margin" id="frm">
					<div class="w3-container  w3-right-align  w3-margin">
						<table>
							<tr>
								<td><select name="ctgr1st" id="ctgr1st" size="6"
									style="width: 200px">
										<option value="N">대분류 선택</option>
										<%
											for (CategoryVo row : ctgrList) {
										%>
										<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
										<%
											}
										%>
								</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="ctgr2nd" id="ctgr2nd" size="6" style="width: 200px">
										<option value="N">중분류 선택</option>

								</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="ctgr3rd"
									id="ctgr3rd" size="6" style="width: 200px">
										<option value="N">소분류 선택</option>


								</select>&nbsp;&nbsp;</td>
							</tr>
						</table>
					</div>

					<label class="">부품id</label>&nbsp;&nbsp;
					<input type="text" name="productId" id="productId">&nbsp;&nbsp;
					<label class="" >부품이름</label>&nbsp;&nbsp;
					<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
					<label class="" >제조사</label>&nbsp;&nbsp;
					<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
					<input type="button" value="검색" id="doSearch" class="w3-blue-grey w3-btn">
				</div>
				<!-- <div class="w3-container  w3-right-align  w3-margin">
					<a href="" class="w3-btn w3-blue-grey">장바구니확인</a> <a href=""
						class="w3-btn w3-blue-grey">주문내역조회</a>
				</div> -->
				
					<table border='1'
						class="table table-striped table-bordered table-hover" id="list">

						<thead>
							<tr>
								<!-- <th class="w3-blue-grey"><input type="checkbox" name="headerChk" value="" /></th> 우선 체크박스는 보류 -->
								<th class="w3-blue-grey">부품ID</th>
								<th class="w3-blue-grey">부품명</th>
								<th class="w3-blue-grey">제조사</th>
								<th class="w3-blue-grey">분류</th>
								<th class="w3-blue-grey">재고수량</th>
								<th class="w3-blue-grey">금액</th>
								<th class="w3-blue-grey">수량</th>
								<th class="w3-blue-grey">담기</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (ProductVo row : productList) {
							%>
							<tr class="temp">
							<!-- <td><input type="checkbox" name="chk" value="" /></td> 우선 현재로써 체크박스는 불필요 -->
								<td><%=row.getProductId()%></td>
								<td><%=row.getProductNm()%></td>   <%-- <a href="<%=contextPath%>/ordr/itemDetail.do?productId=<%=row.getProductId()%>"</a> 링크 생략--%>
								<td><%=row.getPtnrNm()%></td>
								<td><%=row.getCtgr1st()%> > <%=row.getCtgr2nd()%> > <%=row.getCtgr3rd()%></td>
								<td><%=row.getRstock()%></td>

								<td><%=Utils.customNum(row.getSalesCost(), "###,###,##0")%></td>
								
								<td><input type="text" name="amnt" value="1" onkeydown="return showKeyCode(event)" ></td>
								<td><!-- <button onclick="cartAdd(this)" class="testbutton">버튼</button> -->
									<input type="button" class="w3-btn w3-blue-grey btnPutCart" value="담기">
								</td>
							</tr>
									<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<form name="frm" method="post" action="<%=contextPath%>/ordr/putCart.do">
		<input type="hidden" name="productId" value="">
		<input type="hidden" name="amnt" value=""  >
	</form>
</body>
</html>

