<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.List" %>
<%
	String contextPath = request.getContextPath();
	String curMenu = request.getParameter("curMenu");
	String fName = (String)request.getAttribute("fName");
	
%>
<head>
	<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/css/bootstrap-theme.min.css">
   	
    <script src="<%=contextPath%>/js/jquery-3.1.1.min.js"></script>
    <script src="<%=contextPath%>/js/bootstrap.min.js"></script>
</head>
 <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <li <%= curMenu.equals("festival") ? "class=\"active\"" : ""%>>
          <a class="navbar-brand" href="<%=contextPath %>/user/userMain.do">Festival<%=curMenu.equals("festival") ? "<span class='sr-only'> 메인메뉴. </span>" : ""%></a>
          </li>
        </div>
        <div id="navbar" class="navbar-collapse collapse">

			<ul class="nav navbar-nav">  
			<li <%= curMenu.equals("location") ? "class=\"active\"" : ""%>><a
					href="<%=contextPath%>/user/locationCate.do"> 지역별 <%=curMenu.equals("location") ? "<span class='sr-only'> 지역메뉴입니다. </span>" : ""%></a>
			</li>
			<li <%= curMenu.equals("theme") ? "class=\"active\"" : ""%>><a
					href="<%=contextPath%>/user/themeCate.do"> 테마별 <%=curMenu.equals("theme") ? "<span class='sr-only'> 테마메뉴입니다. </span>" : ""%></a>
			</li>
			<li <%= curMenu.equals("season") ? "class=\"active\"" : ""%>><a
					href="<%=contextPath%>/user/seasonCate.do"> 계절별 <%=curMenu.equals("season") ? "<span class='sr-only'> 지역메뉴입니다. </span>" : ""%></a>
			</li>
			<li <%= curMenu.equals("ranking") ? "class=\"active\"" : ""%>><a
					href="<%=contextPath%>/user/rankingCateList.do"> RANKING <%=curMenu.equals("ranking") ? "<span class='sr-only'> 랭킹입니다. </span>" : ""%></a>
			</li>
			<li <%= curMenu.equals("board") ? "class=\"active\"" : ""%>><a
					href="<%=contextPath%>/user/board.do"> 자유게시판 <%=curMenu.equals("board") ? "<span class='sr-only'> 자유게시판입니다. </span>" : ""%></a>
			</li>

			</ul>

<form class="navbar-form navbar-right " action="<%=contextPath%>/adFestival/userList.do" method="post" name="searchForm">
			 <input type="text" name="fName" placeholder="축제명" style="width:150px;" value="">	 
				<button type="submit" class="btn btn-success">검색</button>
</form>
	</div>
  </div>
</nav>

<script>
</script>