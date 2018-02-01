<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.vo.BoardVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%
	String contextPath = request.getContextPath();
	BoardVo vo = (BoardVo) request.getAttribute("resultVo");

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 상세보기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http:<%=contextPath %>/css/w3.css">
</head>
<body>




<div>
	<jsp:include page="/WEB-INF/jsp/inc/menu_header.jsp">
			<jsp:param name="curMenu" value="board"/>
	</jsp:include>
</div>

<article class="container">
		<div class="page-header">
		<h1>상세보기 <small>Detail</small></h1>
		</div>
		</article>
<div class="col-md-6 col-md-offset-3">
		<div class="w3-container  w3-right-align  w3-margin">
       <a href="<%=contextPath %>/board/board.do" class="w3-btn w3-brown">목록</a>
          </div>

      <form class="w3-container"  action="<%=contextPath %>/board/boardModify.do" method="post">
   <div class="w3-row">
     <label class="w3-label ">게시판번호</label>
    	<%=Utils.toEmptyBlank(vo.getbNumber())%>
     </div>
    
    
   <div class="w3-row">
     <label class="w3-label">회원아이디</label>
     <%=Utils.toEmptyBlank(vo.getMemberId())%>
     </div>
    
    
   <div class="w3-row">
    	<label class="w3-label">분류</label>
		<%=Utils.toEmptyBlank(vo.getCategory()) %>
	
     </div>
     
     	   
    
   <div class="w3-row">
     <label class="w3-label">제목</label>
     <%=Utils.toEmptyBlank(vo.getTitle())%>
     </div>
    
    
   <div class="w3-row">
     <label class="w3-label">등록일</label>
     <%=Utils.toEmptyBlank(vo.getrDate())%>
     </div>
    
    
   <div class="w3-row">
     <label class="w3-label">조회수</label>
     <%=Utils.toEmptyBlank(vo.getClickNum())%>
     </div>
    
    
		  
   <div class="w3-row">
    <label class="w3-label">글 내용</label>
   <textarea cols="60" rows="10" name="contents" READONLY cols="50" rows="5" style="resize: none;"><%=Utils.toEmptyBlank(vo.getContents())%></textarea>
     </div>
<%
	String memberId = (String)session.getAttribute("memberId");
	
	if(memberId !=null && memberId.equals(vo.getMemberId()) || memberId!=null && memberId.equals("ADMIN")) {
%>
	<div class="w3-card-4">
		<a href="<%=contextPath%>/board/boardModifyView.do?bNumber=<%=vo.getbNumber() %>" class="w3-btn w3-brown">수정</a>
	    <a href="<%=contextPath%>/board/boardDelete.do?bNumber=<%=vo.getbNumber() %>" class="w3-btn w3-brown">삭제</a>
    </div>
<%
	}
%>
 </div>


</body>
</html>