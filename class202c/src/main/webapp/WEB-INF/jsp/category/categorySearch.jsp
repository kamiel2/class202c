<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.ohhoonim.vo.PtnrVo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file="/WEB-INF/jsp/inc/common.jsp"%>
<%
	String ptnrNm = (String) request.getAttribute("ptnrNm");//request.getParameter
	List<PtnrVo> ptnrList = (List<PtnrVo>) request.getAttribute("ptnrList");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<link rel="stylesheet" href="<%=contextPath%>/css/w3.css">
<link rel="stylesheet" href="<%=contextPath%>/css/common.css">
<script>
	$(function() {
		$('#searchButton').click(function() {
			document.ptnrForm.submit();
		});
		$('#exit').click(function() {
			window.self.close();
		});
		
		$("#ptnrList tbody tr").click(function() {

					var str = ""
					var tdArr = new Array(); 

					// 현재 클릭된 Row(<tr>)
					var tr = $(this);
					var td = tr.children();

					// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
					console.log("클릭한 Row의 모든 데이터 : " + tr.text());

					// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
					td.each(function(i) {
						tdArr.push(td.eq(i).text());
					});

					console.log("배열에 담긴 값 : " + tdArr);

					// td.eq(index)를 통해 값을 가져올 수도 있다.
					var ptnrId = td.eq(0).text();
					var ptnrNm = td.eq(1).text();
					
					$("#ptnrId", parent.opener.document).val(ptnrId);
					$("#ptnrNm", parent.opener.document).val(ptnrNm);
					window.self.close();
				});
	});
</script>
</head>

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

#ptnrList tbody{
cursor:pointer;
}

</style>
<body>

	<div id="whole">
		<div id="title" style="text-align: center">
			<H3>
				<B>파트너사 검색</B>
			</H3>
		</div>
		<div id="contents">
			<div id="search">
				<input type="button" id="exit" value="창닫기">
				<form name="ptnrForm" action="" method="post">
					<input type="text" name="ptnrNm" value="<%=ptnrNm%>" />&nbsp;&nbsp;
					<input type="button" id="searchButton" value="검색">
				</form>
			</div>
			<div id="list">
				<table border='1'
					class="table table-striped table-bordered table-hover"
					id="ptnrList">
					<thead>
						<tr>
							<th class="w3-blue-grey">파트너사ID</th>
							<th class="w3-blue-grey">파트너사명</th>
							<th class="w3-blue-grey">주소</th>
							<th class="w3-blue-grey">거래처TEL</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (PtnrVo row : ptnrList) {
						%>
						<tr>
							<td><%=row.getPtnrId()%></td>
							<td><%=row.getPtnrNm()%> / <%=row.getPtnrNmEng()%></td>
							<td><%=row.getAddr()%></td>
							<td><%=row.getCltTel()%></td>
						</tr>

						<%
							}
						%>
					</tbody>
				</table>
				<div class="col-lg-12" id="ex1_Result1"></div>
				<div class="col-lg-12" id="ex1_Result2"></div>

			</div>
		</div>

	</div>

	<script>


		

	</script>


</body>
</html>