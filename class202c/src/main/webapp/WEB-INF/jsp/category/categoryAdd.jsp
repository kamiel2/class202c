<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>


<%
	List<CategoryVo> ctgrList = (List<CategoryVo>)request.getAttribute("ctgrList");
	String msg = Utils.toEmptyBlank((String)request.getAttribute("msg"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	if('<%=msg%>'.length>0){
		alert('<%=msg%>');
	}
	
	//ctgr 2nd 호출
	$('#ctgr1stList_3rd').change(function(){
		findCtgr2nd();
	});	
	
	//대분류 중복체크
	$('#ctgr1stDupChk').click(function(){
		if($('#ctgr1stNm').val() !== "" ){			
			$(this).hide();
			//$(this).parent().parent().children().eq(2).children().show();
			$('#ctgr1stNm').prop("readonly",true);
			
			$.ajax({
				url : '<%=contextPath%>/category/ctgrIdGenerator.do',
					data : {
						ctgrNm : $('#ctgr1stNm').val().replace(/\s/gi, "").toUpperCase(), ctgrLvl : 5100 },
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {
						$('#ctgr1stNm').parent().find('.ctgrId').text(data.ctgrId);
						$('#ctgr1stNm').parent().parent().children().eq(2).children().show();						
						if(data.msg === 'false'){
							$('#ctgr1stAdd').hide();
						}else{
							$('#ctgr1stId').val(data.ctgrId);							
							$('#ctgr1stChk').val('Y');							
						}
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
					}
				});				
  		} else{
  			alert('공백은 안되요!');
  		}		
	});
	
	//중분류 중복체크
	
	$('#ctgr2ndDupChk').click(function(){
		if($('#ctgr2ndNm').val() !== "" && $('#ctgr1stList_2nd').val() !== 'N' ){	
			$(this).hide();		
			//$(this).parent().parent().children().eq(2).children().show();
			$('#ctgr2ndNm').prop("readonly",true);
			$.ajax({
				url : '<%=contextPath%>/category/ctgrIdGenerator.do',
					data : {
						ctgrNm : $('#ctgr2ndNm').val().replace(/\s/gi, "").toUpperCase(), ctgrLvl : 5200, ctgrParent : $('#ctgr1stList_2nd').val() },
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {
						$('#ctgr2ndNm').parent().find('.ctgrId').text(data.ctgrId);
						$('#ctgr2ndNm').parent().parent().children().eq(2).children().show();						
						if(data.msg === 'false'){
							$('#ctgr2ndAdd').hide();
						}else{
							$('#ctgr2ndId').val(data.ctgrId);	
							$('#ctgr1stList_2nd').prop('disabled',true);	
							$('#ctgr2ndParent').val($('#ctgr1stList_2nd').val());
							$('#ctgr2ndChk').val('Y');	
						}
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
					}		
				});	
			
			
  		} else if($('#ctgr2ndNm').val() === ""){
  			alert('공백은 안되요!');
  		} else{
  			alert('카테고리를 제대로 선택해주세요');
  		} 
	});
	
	
	//소분류 중복체크
	$('#ctgr3rdDupChk').click(function(){
		if($('#ctgr3rdNm').val() !== "" && $('#ctgr1stList_3rd').val() !== 'N' && $('#ctgr2ndList_3rd').val() !== 'N' ){			
			$(this).hide();
			//$(this).parent().parent().children().eq(2).children().show();
			$('#ctgr3rdNm').prop("readonly",true);
			
			$.ajax({
				url : '<%=contextPath%>/category/ctgrIdGenerator.do',
					data : {
						ctgrNm : $('#ctgr3rdNm').val().replace(/\s/gi, "").toUpperCase(), ctgrLvl : 5300, ctgrParent : $('#ctgr2ndList_3rd').val() },
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {
						$('#ctgr3rdNm').parent().find('.ctgrId').text(data.ctgrId);
						$('#ctgr3rdNm').parent().parent().children().eq(2).children().show();						
						if(data.msg === 'false'){
							$('#ctgr3rdAdd').hide();
						}else{
							$('#ctgr3rdId').val(data.ctgrId);							
							$('#ctgr1stList_3rd').prop('disabled',true);							
							$('#ctgr2ndList_3rd').prop('disabled',true);		
							$('#ctgr3rdParent').val($('#ctgr2ndList_3rd').val());
							$('#ctgr3rdChk').val('Y');
						}
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
					}		
				});	
			
  		} else if($('#ctgr3rdNm').val() === ""){
  			alert('공백은 안되요!');
  		} else{
  			alert('카테고리를 제대로 선택해주세요');
  		} 	
	});
	
	$('.ctgrReset').click(function(){
		$(this).parent().parent().find($(':text')).val('');
		$(this).parent().parent().find($(':text')).prop("readonly",false);
		$(this).parent().parent().find($('span')).text('');		
		$(this).parent().parent().find($('.chk')).val('N');	
		$(this).parent().parent().find($(':button')).show();
		$(this).parent().children().hide();	
		$(this).parent().parent().children().eq(1).children("select[name=ctgr1st_alt]").val("N").change();
	});
	
	$('input[type="text"]').keydown(function() {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});
	//엔터는 무조건적으로 막는다. 중복체크가 필수적이기 때문
	

});

//중분류 Ajax
function findCtgr2nd(){
	if( $('#ctgr1stList_3rd').val() != 'N' ) {
		$.ajax({
			url : '<%=contextPath%>/category/findCtgr.do',
				data : {
					ctgrId : $('#ctgr1stList_3rd').val() },
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					var	title = '<option value="N">중분류</option>';
					var options='';					
					var list = data.ctgrList;
				      for (var i = 0; i < list.length; i++) {
				    	  options += '<option value="' + list[i].ctgrId + '">' + list[i].ctgrNm + '</option>';
				      }				     
				      $("#ctgr2ndList_3rd").html(title+options);				      
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: ' + JSON.stringify(jqXHR));
				}
			});	
		
		}else {
			$("#ctgr2ndList_3rd").html('<option value="N">중분류</option>');								
		}
	

}	
</script>
<style>
.ctgrReset, #ctgr1stAdd, #ctgr2ndAdd, #ctgr3rdAdd {
	display:none;
}
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
	<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
		
	<br><br><br><br><br>
		
			<div>
				
					<div style="text-align: center">
						<H3>
							<B>카테고리 등록</B>
						</H3>
					</div>
				
			</div>
			<div id="contents">
			<table border='1' class="table table-striped table-bordered table-hover" id="add">
				<!-- 대분류 등록  -->
				<form name="ctgr1stFrm" action="<%=contextPath %>/category/categoryAdd.do" method="post">
					<tr>					
						<th class="w3-blue-grey">대분류</th>
						<td>
						<!-- 대분류입력 -->
							<input type="text" name="ctgrNm" id="ctgr1stNm">
							<input type="hidden" name="ctgrLvl" value="5100">
							<input type="hidden" name="ctgrId" id="ctgr1stId" value="">
							<span class="ctgrId"></span>
							<input type ="button" id ="ctgr1stDupChk" value = "중복체크">
							<input type="hidden" class="chk" id="ctgr1stChk" value="N" />
						</td>
						<td>
							<input type ="submit" id ="ctgr1stAdd" value = "등록">
							<input type ="button" class ="ctgrReset" value = "리셋">
						</td>									
					</tr>
				</form>	
					
				<!-- 중분류 등록  -->	
				<form name="ctgr1stFrm" action="<%=contextPath %>/category/categoryAdd.do" method="post">
				<tr>
					<th class="w3-blue-grey">중분류</th>
					<td><select id = "ctgr1stList_2nd">
								<option value="N">대분류</option>
								<%for(CategoryVo row : ctgrList){ %>
								<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
								<%} %>
						</select>
						<!-- 중분류입력 -->
						<input type="text" name="ctgrNm" id="ctgr2ndNm">
						<input type="hidden" name="ctgrLvl" value="5200">
						<input type="hidden" name="ctgrId" id="ctgr2ndId" value="">
						<input type="hidden" name="ctgrParent" id="ctgr2ndParent" value="">
						<span class="ctgrId"></span>
						<input type ="button" id ="ctgr2ndDupChk" value = "중복체크">
						<input type="hidden" class="chk" id="ctgr2ndChk" value="N" />
					</td>
					<td>
						<input type ="submit" id ="ctgr2ndAdd" value = "등록">
						<input type ="button" class ="ctgrReset" value = "리셋">
					</td>
				</tr>
				</form>	
					
				<!-- 소분류 등록  -->	
				<form name="ctgr1stFrm" action="<%=contextPath %>/category/categoryAdd.do" method="post">
					<tr>
						<th class="w3-blue-grey">소분류</th>
						<td>
							<select id = "ctgr1stList_3rd">
								<option value="N">대분류</option>
								<%for(CategoryVo row : ctgrList){ %>
								<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
								<%} %>
							</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<select id = "ctgr2ndList_3rd">
								<option value="N">중분류</option>
							</select>							
						<!-- 소분류입력 -->
							<input type="text" name="ctgrNm" id="ctgr3rdNm">
							<input type="hidden" name="ctgrParent" id="ctgr3rdParent" value="">
							<input type="hidden" name="ctgrLvl" value="5300">
							<input type="hidden" name="ctgrId" id="ctgr3rdId" value="">
							<span class="ctgrId"></span>
							<input type ="button" id ="ctgr3rdDupChk" value = "중복체크">	
							<input type="hidden" class="chk" id="ctgr3rdChk" value="N" />						
						<td>
							<input type ="submit" id ="ctgr3rdAdd" value = "등록">
							<input type ="button" class ="ctgrReset" value = "리셋">
						</td>
					</tr>
				</form>	
				</table>
				

			</div>
			<div class="w3-container  w3-right-align  w3-margin">
				<a href="" class="w3-btn w3-blue-grey">취소</a>
			</div>
		
	
</body>

</html>