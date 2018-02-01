<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.vo.BoardVo"%>
<%
	String contextPath = request.getContextPath();
	List<BoardVo> list = (List<BoardVo>) request.getAttribute("resultList");
	List<BoardVo> notice = (List<BoardVo>) request.getAttribute("noticeList");
	String title = (String) request.getAttribute("title");
	String fName = (String)request.getAttribute("fName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List</title>
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
		<h1>자유게시판 <small>Board</small></h1>
		</div>
		</article>
	<div class="col-md-6 col-md-offset-3">

		<div>		
			<form action="<%=contextPath%>/board/board.do" method="post"
				name="searchForm3">
				게시물 검색 : <input type="text"
					class="w3-input  w3-border w3-round-large " name=title
					value="<%=title%>" style="width: 30%; display: inline"> <input
					type="submit" class="w3-btn w3-brown w3-round-xxlarge" value="검색">
							  <input type="hidden" name="pageNo" value="${paging.pageNo}">
			</form>
		</div>

		<div class="w3-container  w3-right-align  w3-margin">
			<a href="<%=contextPath%>/board/boardAddView.do"
				class="w3-btn w3-brown">글쓰기</a>
				<a href="<%=contextPath%>/board/board.do"
				class="w3-btn w3-brown">목록</a>
		</div>

		<div>
			<table class="w3-table w3-bordered w3-striped w3-border test">
				<tr class="w3-brown">
					<th class="w3-center">게시판번호</th>
					<th class="w3-center">분류</th>
					<th class="w3-center">회원아이디</th>
					<th class="w3-center">제목</th>
					<th class="w3-center">등록일</th>
					<th class="w3-center">조회수</th>
				</tr>
				
				<%
					for (BoardVo vo : notice) {
				%>

				<tr>

					<td class="w3-center"><%=vo.getbNumber()%></td>
					<td class="w3-center"><font color="red"><%=vo.getCategory()%></font></td>
					<td class="w3-center"><%=vo.getMemberId()%></td>
					<td class="w3-center"><a
						href="<%=contextPath%>/board/boardView.do?bNumber=<%=vo.getbNumber()%>">
							<%=vo.getTitle()%></a></td>
					<td class="w3-center"><%=vo.getrDate()%></td>
					<td class="w3-center"><%=vo.getClickNum()%></td>
					
					</tr>
				<%
					}
				%>		
				
				<%
					for (BoardVo vo : list) {
				%>

				<tr>


					<td class="w3-center"><%=vo.getbNumber()%></td>
					<td class="w3-center"><%=vo.getCategory()%></td>
					<td class="w3-center"><%=vo.getMemberId()%></td>
					<td class="w3-center"><a
						href="<%=contextPath%>/board/boardView.do?bNumber=<%=vo.getbNumber()%>">
							<%=vo.getTitle()%></a></td>
					<td class="w3-center"><%=vo.getrDate()%></td>
					<td class="w3-center"><%=vo.getClickNum()%></td>
					</tr>
				<%
					}
				%>


			</table>
			</div>
		<center>
			<jsp:include page="/WEB-INF/jsp/inc/paging.jsp">
				<jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
				<jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
				<jsp:param name="startPageNo" value="${paging.startPageNo}" />
				<jsp:param name="pageNo" value="${paging.pageNo}" />
				<jsp:param name="endPageNo" value="${paging.endPageNo}" />
				<jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
				<jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
			
			</jsp:include>
		</center>
		</div>
		<script type="text/javascript">
			function goPage(pageNo) {
				document.searchForm3.pageNo.value = pageNo;
				document.searchForm3.submit();
			}
		</script>
		
		


	</div>
</body>
</html>