<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
	String contextPath = request.getContextPath();
	String memberId = (String)session.getAttribute("memberId");
%>


<!DOCTYPE html>
<html>
<head>
<title>추가</title>
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
		<h1>게시판 등록 <small>Board</small></h1>
		</div>
		</article>
	<div class="col-md-6 col-md-offset-3">

   <div class="w3-card-4">
      <div class="w3-container w3-right w3-margin">
         <a href="<%=contextPath%>/board/board.do"
            class="w3-btn w3-brown">목록</a> <a
            href="<%=contextPath%>/board/board.do"
            class="w3-btn w3-brown">취소</a>
      </div>
      


      <form class="w3-container" name="boardForm" id="boardForm"
         action="<%=contextPath%>/board/boardAdd.do" method="post">

  
  		<input type="hidden" name="memberId" value="<%=(String)session.getAttribute("memberId") %>">
		<label class="w3-label">분류</label>
	<%
		if(memberId !=null && memberId.equals("ADMIN")) {
	%>
		<select class="w3-input" name="category">
			<option value="공지">공지</option>
			<option value="일반&후기">일반&후기</option>
			<option value="건의사항">건의사항</option>
		</select>
     <%
		} else {
	%>
		<select class="w3-input" name="category">
			<option value="일반&후기">일반&후기</option>
			<option value="건의사항">건의사항</option>
		</select>
	<%
		}
     %>
      
		<label class="w3-label">제목</label>
		<input class="w3-input" type="text" name="title" id="title"><br>
	
	
	
		<table>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <label class="w3-label">내용</label>
      <td><textarea id="contents" name="contents" cols="50" rows="13" style="resize: none;"></textarea></td>
      <td>&nbsp;</td>
     </tr>
     </table>

            <input type="submit" class="w3-btn w3-brown" value="저장"><br>
         </div>

      </form>
      </div>



<script src="<%=contextPath%>/js/jquery-3.1.1.min.js"></script>

         <script>
     
     $(function(){
     
     $('#boardForm').submit(function(event){
    	 var title = $('#title').val();
    	 var contents = $('#contents').val();
         
            if(title.length < 1){
             alert('제목을 입력하세요');
             $('#title').val('');
             $('#title').focus();
             event.preventDefault();
     		}else if(title.length > 50){
             alert('제목은 50자 이내로 입력하세요.');
             $('#title').focus();
             event.preventDefault();
            }else if(contents.length > 2000){
            	alert('내용은 2000자 이내로 입력하세요');
                $('#contents').val('');
                $('#contents').focus();
                event.preventDefault();
            }
     });
     
     });
 </script>
</body>
</html> 