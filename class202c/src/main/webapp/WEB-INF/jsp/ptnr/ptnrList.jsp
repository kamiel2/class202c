<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.ohhoonim.vo.PtnrVo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%
    
   
	String ptnrNm = (String)request.getAttribute("ptnrNm");//request.getParameter
	List<PtnrVo> ptnrList = (List<PtnrVo>)request.getAttribute("ptnrList");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
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
<script>
$(function(){
	$('#searchButton').click(function(){
		document.ptnrForm.submit();
	});
	
});

$(function(){
	$('#btnAdd').click(function(){
		location.href='<%=contextPath%>/ptnr/ptnrAddView.do';
	});
	
	$('#doSearch').click(function(){
		selectList();
	});
	                       
	$('#type, #ptnrId, #ptnrNm').keydown(function(event ){
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
	var a = '<tr><td>%s</td><td>%s</td>'+
			'<td><a href = "/class202c/ptnr/ptnrDetail.do?ptnrId=%s">%s</a></td>'+
			'<td>%s</td>'+
			'<td>%s</td>'+
			'<td>0</td>'+
			'<td>%s</td>'+
			'<td><a href="<%=contextPath%>/ptnr/ptnrModifyView.do?ptnrId=%s" class="w3-btn w3-blue-grey">수정</a></td></tr>';
	$.ajax({
		url : '<%=contextPath%>/ptnr/ptnrSearch1.do',
			data : {
				type : $('#type').val(), ptnrId : $('#ptnrId').val(), ptnrNm : $('#ptnrNm').val()
			},
			method : "post",
			dataType : "json",
			success : function(data,status,jqXHR){
				var options='';
				var list = data.result;
				for(var i = 0; i < list.length; i++){
					options += sprintf(a, list[i].type, list[i].ptnrId, list[i].ptnrId, list[i].ptnrNm, list[i].countId, list[i].sumAmnt, list[i].sumPrice, list[i].ptnrId);
					
				}
				$("#list tbody").html(options);
			},
			error : function(jqXHR, status, errorThrown){
				alert('ERROR:' + JSON.stringify(jqXHR));
			}
		});
}

</script>
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
</style>
<body>
	<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
</jsp:include>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div id="whole">
				<div id="title" style="text-align: center">
					<H3><B>파트너사 관리</B></H3>
				</div>
				<div id="contents">
					<div id="search">
					<form name="ptnrForm" action="" method="post">
						<label class="w3-label">분류</label>&nbsp;&nbsp;<input type="text" name="type" id="type" value=""/>&nbsp; 
						<label class="w3-label">파트너사id</label>&nbsp;&nbsp;<input type="text" name="ptnrId" id="ptnrId">&nbsp;&nbsp;
						<label class="w3-label">파트너사명</label>&nbsp;&nbsp;<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
						<input type="button" id="doSearch" value="검색">
					</form>
					</div>
					<div id="buttons">
			
					<input type="button" value="파트너사 등록" id="btnAdd">
			
					</div>
					
					<table border='1' class="table table-striped table-bordered table-hover" id="list">
					<thead>
					<tr >
					<th class="w3-blue-grey" >분류</th>
					<th class="w3-blue-grey">파트너사ID</th>
					<th class="w3-blue-grey">파트너사명</th>
					<th class="w3-blue-grey">누적거래횟수</th>
					<th class="w3-blue-grey">누적구매량</th>
					<th class="w3-blue-grey">누적판매량</th>
					<th class="w3-blue-grey">누적거래금액</th>
					<th class="w3-blue-grey">수정</th>
					</tr>
					</thead>
					<tbody>
					<%
						for(PtnrVo row: ptnrList){
					%>
					<tr>
					<td><%=row.getType() %></td>
					<td><%=row.getPtnrId()%></td>
					<td><a href = "<%=contextPath%>/ptnr/ptnrDetail.do?ptnrId=<%=row.getPtnrId()%>"><%=row.getPtnrNm()%></a></td>
					<td><%=row.getCountId() %></td>
					<%if((row.getType()).equals("1000")){%>
					<td><%=Utils.customNum(row.getSumAmnt(), "###,###,##0") %></td>
					<td>0</td>
					<%}else{  %>
					<td>0</td>
					<td><%=Utils.customNum(row.getSumAmnt(), "###,###,##0") %></td>
					<%}%>
					<td><%=row.getSumPrice()%></td>
					<td><a href="<%=contextPath %>/ptnr/ptnrModifyView.do?ptnrId=<%=row.getPtnrId() %>" class="w3-btn w3-blue-grey">수정</a>
					</td>
					</tr>
					<%
					}
					%>
					</tbody>
				</table>
			
		</div>
		
	</div>
</body>
</html>