<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

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
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#datepicker1" ).datepicker({ dateFormat: 'yy-mm-dd' });
    } );
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
</style>
<body>
	<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
</jsp:include>
		</div>
	<br><br><br><br><br>
	<div id="whole">
		<div id="title" style="text-align: center">
					<H3>
						<B>기간별재고변동현황조회</B>
					</H3>
				</div>
		<div id="contents">
		<div id="search">
			<form name="stockForm" action="" method="post">
				<label class="w3-label">제조사id</label>&nbsp;&nbsp;<input type="text" name="ptnrId2" id="ptnrId2">&nbsp; 
				<label class="w3-label">제조사이름</label>&nbsp;&nbsp;<input type="text" name="ptnrNm2" id="ptnrNm2">&nbsp;&nbsp;
				<label class="w3-label">부품id</label>&nbsp;&nbsp;<input type="text" name="productId" id="productId">&nbsp;&nbsp;
				<label class="w3-label">부품이름</label>&nbsp;&nbsp;<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
				<input type="button" value="검색" id="doSearch"><br>
				<a href="" class="w3-btn w3-blue-grey">1주</a> 
				<a href="" class="w3-btn w3-blue-grey">1달</a> 
				<a href="" class="w3-btn w3-blue-grey">3달</a> 
				&nbsp;&nbsp;<input id="datepicker" type="text" value="2017-11-17" />~
				<input id="datepicker1" type="text" value="2017-11-17" />
			</form>
		</div>
		<br><br><br>
			<table border='1'
				class="table table-striped table-bordered table-hover" id="list">
				<thead>
				<tr>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사ID</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">분류</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">주문가격</th>
					<th class="w3-blue-grey">최근입고일</th>
					<th class="w3-blue-grey">기간재입고회수</th>
					<th class="w3-blue-grey">기간내입고량</th>
					<th class="w3-blue-grey">기간내출고량</th>
					<th class="w3-blue-grey">재고증감량</th>
					<th class="w3-blue-grey">안전재고</th>
					<th class="w3-blue-grey">간편 주문</th>

				</tr>
				</thead>
				<tbody>
				<tr class="temp">
					<td>01425706</td>
					<td>GALAXY1081TI</td>
					<td>021552</td>
					<td>GALAXY</td>
					<td>VGA>NVIDIA>GTX1080TI</td>
					<td>200</td>
					<td>1,395,000</td>
					<td>20171105</td>
					<td>5</td>
					<td>300</td>
					<td>177</td>
					<td>123</td>
					<td><input type="number" name="quantity" min="0" step="1"
						value="0" width="20px"><a href="" class="w3-btn w3-blue-grey">수량변경</a></td>
					<th class="w3-btn w3-blue-grey">주문하기</th>
					<!-- '안전재고' - '현재 재고' = '수량만큼' 자동 주문-->
				</tr>

				<tr>
					<td>01370862</td>
					<td>GIGABYTE GTX1070 8GB</td>
					<td>021741</td>
					<td>GIGABYTE</td>
					<td>VGA>NVIDIA>GTX1070</td>
					<td>250</td>
					<td>598,000</td>
					<td>20171106</td>
					<td>7</td>
					<td>410</td>
					<td>511</td>
					<td>-101</td>
					<td><input type="number" name="quantity" min="0" step="1"
						value="0" width="20px"><a href="" class="w3-btn w3-blue-grey">수량변경</a></td>
					<th class="w3-btn w3-blue-grey">주문하기</th>
					<!-- '안전재고' - '현재 재고' = '수량만큼' 자동 주문-->
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>