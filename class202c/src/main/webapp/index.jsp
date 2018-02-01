<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>더조은 총판 로그인</title>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
</head>
<style>

#border {
	position: center;
	width: 1400px;
	min-width : 1200px;
	margin-left: auto;
	margin-right: auto;
}
#Menu {
	height: 40px;
	text-align: center;
	width: 400px;
	display: block;
	margin-left: auto;
	margin-right: auto;
	margin-top: 20px;
}

#Menu ul li {
	list-style: none;
	color: white;
	background-color: #2d2d2d;
	float: left;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
	margin: 10px;
}

#Menu .connect {
	text-decoration: none;
	color: white;
	display: block;
	width: 150px;
	font-size: 16px;
	font-weight: bold;
	font-family: "Trebuchet MS", Dotum, Arial;
	text-align: center;
}

#Menu .connect:hover {
	color: #ff3;
	background-color: #4d4d4d;
}

#mainimg {
	display: block;
	margin-left: auto;
	margin-right: auto;
	margin-top:20px;
}

#silhouette {
 transform: scale(0.8);
	display: block;
	margin-left: auto;
	margin-right: auto;
	margin-top : 110px;
}

footer {
	text-align: center;
	display: block;
	margin: 10px;
}
</style>
<script>
	
</script>
<body>
<div id=border>
		<img src="img/memory.jpg" id=silhouette>
	<a href="index.html"> <img src="img/더조은 메인.jpg" id=mainimg></a>

	<nav id="Menu">
		<ul>
			<li><a class="connect" href="<%=contextPath%>/product/productList.do"> 운영자 접속 </a></li>
			<li><a class="connect" href="<%=contextPath%>/ordr/ordr_index.do"> 소매처 접속 </a></li>
		</ul>
	</nav>


	<footer> copyright(c) 2017 All rights reserved by us </footer>
	</div>
</body>
</html>