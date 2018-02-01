<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="java.util.Calendar"%>

<%
	Calendar cal=Calendar.getInstance();
	String year=request.getParameter("search_end_year");
		if(year==null) year=cal.get(Calendar.YEAR)+"";
	String month=request.getParameter("search_end_month");
		if(month==null) month=cal.get(Calendar.MONTH)+1+"";
	String day=request.getParameter("search_end_date");
		if(day==null) day=cal.get(Calendar.DATE)+"";
%>
<%


	List<HashMap<String,String>> purchaseList = (List<HashMap<String,String>>)request.getAttribute("purchaseList");
	List<CategoryVo> ctgrList = (List<CategoryVo>)request.getAttribute("ctgrList");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<title>더조은 총판</title>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery.scrollfollow.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<link rel="stylesheet" href="/class202c/css/w3.css">
<script src="<%=contextPath%>/js/moment.js" type="text/javascript"></script>
<script src="<%=contextPath%>/js/mypage.js" type="text/javascript"></script>
<script>
	$(function() {
		$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
		
		init();
		selected_search_period('7D');
		order_list_period(); //날짜 hidden 에 기입
		selectPurchaeList(); //발주내역 ajax 기본호출
		$('#doSearch').click(function(){
			selectPurchaeList();		
		});			

		//ctgr 2nd 호출
		$('#ctgr1st').change(function(){
			$("#ctgr3rd").html('<option value="N">소분류</option>');
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
		
		$('.opt').change(function(){
			order_list_period();			
		})
	
		$('.inner').click(function() {
			order_list_period();
		})
		
		/* 
		$("#purchaseList tbody tr :nth-child(2)").click(function() {	
			var regText = $(this).text();
			regText.replace(/\s/gi, ""); 
			location.href = "<%=contextPath%>/purchase/purchaseDetail.do?purchaseId="+regText;
		});
		*/
		

	})
	
	function findPurchaseId(line){
		//선택된 행에대한 incoming List
		var str = "";
		var tdArr = new Array(); 
		
		// 현재 클릭된 Row(<tr>)
		var tr = line;
		var td = tr.children();
		
		var status = tr.find('input[type=hidden]').val();
		console.log(status);		
		
		// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
		console.log("클릭한 Row의 모든 데이터 : " + tr.text());

		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		td.each(function(i) {
			tdArr.push(td.eq(i).text());
		});
		
		console.log("배열에 담긴 값 : " + tdArr);

		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var purchaseId=td.eq(0).text();
		$('#purchaseId').val(purchaseId);
		return purchaseId
		}
	

	function selectPurchaeList(){		
		$("#purchaseList tbody tr").off('click');
			//purchase 검색결과
			var a = '<tr>'+						
						'<td>%s</td>'+	
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
						'<td>%s</td>'+
					'</tr>';	
			$.ajax({
				url : '<%=contextPath%>/purchase/purchaseSearch.do',
					data : {
						ctgr1st : $('#ctgr1st').val(), ctgr2nd : $('#ctgr2nd').val(), ctgr3rd : $('#ctgr3rd').val(),
						startDate : $('#startDate').val(), endDate : $('#endDate').val(),
						productId : $('#productId').val(), productNm : $('#productNm').val(), ptnrNm : $('#ptnrNm').val()
						},
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {					
						var options='';					
						var list = data.result;
					      for (var i = 0; i < list.length; i++) {
					    	  options += sprintf(a, 
					    			  list[i].purchaseId, 
					    			  stringToDate(list[i].purchaseDate),
					    			  list[i].productId,
					    			  list[i].productNm,
					    			  list[i].ptnrNm,
					    			  numberWithCommas(list[i].stock),
					    			  numberWithCommas(list[i].amnt),
					    			  numberWithCommas(list[i].amntLo),
					    			  numberWithCommas(list[i].unitPrice),
					    			  numberWithCommas(list[i].purchaseSum),
					    			  list[i].statusNm 	
					    			  ); 	  
					      }				     
					      $("#purchaseList tbody").html(options);	
					      
							$("#purchaseList tbody tr").on('click',function(){								
								selectIcList(findPurchaseId($(this)));			
							});					      
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
					}
				});
			
		}

	function selectIcList(purchaseId){

		var purchaseId=purchaseId;
		//클릭한 행의 purchaseId를 ajax를 통해 incoming 테이블을 조회하여 값을 뿌린다.		
		
		var a = '<tr>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'<td>%s</td>'+
				'</tr>';				
					
		$.ajax({
			url : '<%=contextPath%>/incoming/incomingSearch.do',
				data : {
					'purchaseId' : purchaseId
					},
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {					
					var options='';					
					var list = data.result;
				      for (var i = 0; i < list.length; i++) {
				    	  options += sprintf(a, 
				    			  list[i].purchaseId,
				    			  numberWithCommas(list[i].count),
				    			  list[i].icDate,
				    			  list[i].productId,
				    			  list[i].productNm,
				    			  list[i].ptnrNm,
				    			  numberWithCommas(list[i].stock),
				    			  numberWithCommas(list[i].amnt),
				    			  numberWithCommas(list[i].icAmnt),
				    			  numberWithCommas(list[i].unitPrice * list[i].icAmnt)						    			  							    			  
				    			  ); 	  
				      }
				      var status = list[0].status;
				      console.log(status);
				      
				      $('#purchaseId').val(purchaseId);
				      
						if(status === '2313'){
							$('#popup_open').hide();
							}else{
								$('#popup_open').show();								
							}
				      $("#incomingList tbody").html(options);	
				      
						$("#incomingList tbody tr").click(function() {
							$("#popup_wrap").css("display", "block"); 
							$("#mask").css("display", "block"); 							
							icView(findIcPk($(this)));	
						});
				      
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: 입고내역이 없어요!');
					$("#incomingList tbody").html("");
					$('#popup_open').show();
					$('#purchaseId').val(purchaseId);
				}
			});	
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
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function stringToDate(str){
		//yyyymmddhh24miss  -> yyyy-mm-dd hh24:mi:ss 변환
		
		str = str.substring(0, 4)+'-'+str.substring(4, 6)+'-'+str.substring(6, 8)+' '+str.substring(8, 10)+':'
				+str.substring(10, 12)+':'+str.substring(12, 14);
		
		return str		
	}
	


</script>
<script> 

function init(){
	
	var oYear=document.getElementById("search_end_year").options;
	console.log(oYear);
		for(var i=1;i<oYear.length;i++){
	var val=oYear[i].value;	
		if('<%=year%>'==parseInt(val)){
			oYear.selectedIndex=i;
		break;
		}
	}

	
	var oMonth=document.getElementById("search_end_month").options;	
		for(var i=1;i<oMonth.length;i++){
	var val=oMonth[i].value;
		if('<%=month%>'==parseInt(val)){
			oMonth.selectedIndex=i;
		break;	
		}
	}
	

	var oDay=document.getElementById("search_end_date").options;	
		for(var i=1;i<oDay.length;i++){
	var val=oDay[i].value;	
	if('<%=day%>' == parseInt(val)) {
				oDay.selectedIndex = i;

				break;
			}
		}
	}

	function order_list_period() {
		var startDate = $('#search_start_year').val()
				+ maker($('#search_start_month').val())
				+ maker($('#search_start_date').val()) + '000000';
		$('#startDate').val(startDate);
		//console.log(startDate);
		var endDate = $('#search_end_year').val()
				+ maker($('#search_end_month').val())
				+ maker($('#search_end_date').val()) + '235959';
		$('#endDate').val(endDate);
		//console.log(endDate);
	}

	function maker(a) {
		if (a.length == 1) {
			var b = '0' + a;
		} else {
			var b = a;
		}
		return b;

	}

</script>
<!-- 팝업창 -->


<script> 
$(document).ready(function(){ 
	$("#popup_open").click(function(){ 
		$("#popup_wrap").css("display", "block"); 
		$("#mask").css("display", "block"); 
		icView();
	}); 
	$("#popup_close").click(function(){ 
		popup_close();
	});
	function popup_close(){
		$("#popup_wrap").css("display", "none"); 
		$("#mask").css("display", "none"); 
		$("#popup_title").find("span").text("");
		$("#popup_table tbody").html("");
		$("#icCount").val("");	
	}
});

function popup_close(){
	$("#popup_wrap").css("display", "none"); 
	$("#mask").css("display", "none"); 
	$("#popup_title").find("span").text("");
	$("#popup_table tbody").html("");
	$("#icCount").val("");	
}



// 팝업창 로드 화면 
// 부품 ID, 부품명, 총 발주수량, 남은 발주수량, 입고수량
function icView(icPk){
	$("#popup_confirm").off('click');
var a =
		'<tr>'+
		'<td>%s</td>'+
		'<td>%s</td>'+
		'<td>%s</td>'+
		'<td>%s</td>'+
		'<td><input type="text" id="addIcAmnt" value="%s"></td>'+
		'</tr>';	
		
		if(icPk ==null){
			var purchaseId = $('#purchaseId').val();
			var situation = '입고 등록';
			
			$("#popup_confirm").on('click', function() {
				icAdd();	
			});
			
			
		}else{
			var purchaseId = icPk[0];
			var icCount = icPk[1];			
			var situation = '입고 수정';
			$('#icCount').val(icCount);			
			$("#popup_confirm").on('click', function() {
				icModify();		
			});
		}
			
$.ajax({
	url : '<%=contextPath%>/incoming/incomingAddView.do',
		data : {
			'purchaseId' : purchaseId , 'icCount' : icCount			
			},
		method : "post",
		dataType : "json",
		success : function(data, status, jqXHR) {					
			var options='';					
			var list = data.result;
			
		    	  options += sprintf(a,
		    			  list.productId,
		    			  list.productNm,
		    			  numberWithCommas(list.amnt),
		    			  numberWithCommas(list.amntLo),
		    			  numberWithCommas(list.icAmnt)
		    			  ); 	  		    	  
			      $("#popup_title").find("span:nth-child(1)").text(list.purchaseId);	
			      $("#popup_title").find("span:nth-child(2)").text(list.ptnrNm);			   
			      $("#popup_title").find("span:nth-child(3)").text(list.count);			   
			      $("#popup_title").find("span:nth-child(4)").text(situation);	      
	  
		      $("#popup_table tbody").html(options);
		      
		},
		error : function(jqXHR, status, errorThrown) {
			alert('ERROR: 관리자문의');
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none"); 
			$("#popup_title").find("span").text("");
			$("#popup_table tbody").html("");	
		}
	});
}

//입고등록 ajax 등록되고 해당 주문번호 ajax다시 실행시킨다
function icAdd(){	
	$("#popup_confirm").off('click');
	var icAddAmnt = $('#addIcAmnt').val();
	var purchaseId = $('#purchaseId').val();
	$.ajax({
		url : '<%=contextPath%>/incoming/incomingAdd.do',
			data : {
				'purchaseId' : purchaseId, 'icAddAmnt' : $('#addIcAmnt').val()
				},
			method : "post",
			dataType : "json",
			success : function(data, status, jqXHR) {
				 //$("#popup_confirm").unbind('click');
				var chk = data.result;
				alert(chk);				
				selectIcList(purchaseId);
				selectPurchaeList();	
				popup_close();
			},
			error : function(jqXHR, status, errorThrown) {
				alert('ERROR: 관리자문의');

			}
		});
	}
	

//입고 수정을 위해 pk 값 찾아낸다.
	function findIcPk(line){
		
		//선택된 행에대한 incoming PK 값 찾는다.
		var str = "";
		var tdArr = new Array(); 
		
		// 현재 클릭된 Row(<tr>)
		var tr = line;
		var td = tr.children();
		
		var status = tr.find('input[type=hidden]').val();
		console.log(status);		
		
		// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
		console.log("클릭한 Row의 모든 데이터 : " + tr.text());

		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		td.each(function(i) {
			tdArr.push(td.eq(i).text());
		});
		
		console.log("배열에 담긴 값 : " + tdArr);

		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var purchaseId=td.eq(0).text();
		var icCount=td.eq(1).text();

		return [purchaseId, icCount]
		}
	
	//incoming 수정 ajax. 수정후에 주문의 상태코드가 변경되면 해당사항 알려주고 ajax 재실행!
	function icModify(){	
		$("#popup_confirm").off('click');
		var icAddAmnt = $('#addIcAmnt').val();
		var purchaseId = $('#purchaseId').val();
		var icCount = $('#icCount').val();
		$.ajax({
			url : '<%=contextPath%>/incoming/incomingModify.do',
				data : {
					'purchaseId' : purchaseId, 'icCount' : icCount, 
					'icAddAmnt' :icAddAmnt
					},
				method : "post",
				dataType : "json",
				success : function(data, status, jqXHR) {
					 //$("#popup_confirm").unbind('click');
					var chk = data.result;
					alert(chk);				
					selectIcList(purchaseId);
					selectPurchaeList();
					popup_close();
					
				},
				error : function(jqXHR, status, errorThrown) {
					alert('ERROR: 관리자문의');

				}
			});
		}
 
</script>

</head>
<style> 
#popup_wrap {width:90%; height:270px; background:#fff; border: solid 1px #666666; position:fixed; top:30%; left:5%; z-index:9999; display:none;} 
#mask {width:100%; height:100%; position:fixed; background:rgba(0,0,0,0.7) repeat; top:0; left:0; z-index:999; display:none;} 
.popup_content {margin-left:10px;}
.popup-cont01 {width:478px; margin: 40px auto; text-align: center;}
.popup-cont01 button { width: 138px; height: 36px; line-height: 36px; background: #9f2f60; color: #ffffff; text-align: center; border: none; font-size: 16px;}
</style>


<style>

#popup_open {
	display:none;
	}	


</style>
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

#form2, form1 {
	margin: 10px;
}

/* 날짜 */
.wrap_listsearch {
	display: block;
	padding: 14px 19px;
	border: 1px solid #ddd;
	background-color: #f9f9f9;
	zoom: 1;
	width: 750px;
	height: 100%;
}

.wrap_listsearch .fieldset {
	width: 750px;
	height: 100%;
}

.wrap_listsearch .tit_mypage {
	float: left;
	margin: 24px 0 24px 10px;
}

.wrap_listsearch .box_cont {
	float: left;
	margin-left: 20px;
}

.wrap_listsearch .box_cont .box_opt .btn_flexible03 .inner {
	min-width: 45px;
}

.wrap_listsearch .box_cont .box_radio, .wrap_listsearch .box_cont .box_opt
	{
	clear: both;
	display: block;
	overflow: hidden;
	padding: 5px 0;
}

.wrap_listsearch .box_radio .btn_label .inner {
	float: left;
	height: 100%;
	padding-left: 9px;
	font-size: 14px;
	line-height: 21px;
	color: #666;
	letter-spacing: 1px;
}

.wrap_listsearch .box_radio .on .inner {
	font-weight: bold;
	color: #F13;
}

.wrap_listsearch .box_opt select {
	height: 21px;
	border: 1px solid #ccc;
}

.wrap_listsearch .box_opt .txt {
	font-size: 12px;
	line-height: 21px;
	font-family: Gulim, '굴림';
	color: #666;
}

.wrap_listsearch .box_opt .opt_year {
	width: 68px;
}

.wrap_listsearch .box_opt .opt_month {
	width: 46px;
}

.wrap_listsearch .box_opt .opt_day {
	width: 46px;
}

.wrap_listsearch .box_opt .btn_flexible {
	margin-left: 5px;
	vertical-align: top
}

</style>
<body>
	<div id="whole">
		<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
		</jsp:include>
		</div>
		<br> <br> <br> <br>		
		<div>
			<form name="frm" action="" method="post" id="form1">
				<div style="text-align: center">
					<H3>
						<B>발주 내역 확인 페이지</B>
					</H3>
				</div>
				<!--  -->
				
				<div class="w3-container  w3-left-align  w3-margin" id="frm">
					<form action="<%=contextPath%>/product/productView.do" method="post" name="searchFrm" id="searchFrm">
					
					<div class="w3-container  w3-right-align  w3-margin">
					<table>
					<tr>
						<td><select name="ctgr1st" id = "ctgr1st">
								<option value="N">대분류</option>
								<%for(CategoryVo row : ctgrList){ %>
								<option value="<%=row.getCtgrId()%>"><%=row.getCtgrNm()%></option>
								<%} %>

						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr2nd" id = "ctgr2nd">
						<option value="N">중분류</option>
									
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<select name="ctgr3rd" id = "ctgr3rd">
						<option value="N">소분류</option>								

						</select>&nbsp;&nbsp;</td>
						
					</tr>
					</table>
					
					</div>
						<div class="wrap_listsearch">
								<fieldset>
									<legend class="hide">조회기간 검색</legend>
									<strong class="tit_mypage tit_inquiry_period">조회기간</strong>
									<div class="box_cont">
										<div class="box_radio">
												<label id="search_period_7D"class="btn_label search_period fst on" onclick="selected_search_period('7D');">
												<input type="button" class="inner" value="1주일"></label>
												
												<label id="search_period_15D" class="btn_label search_period " onclick="selected_search_period('15D');">
												<input type="button" class="inner" value="15일"></label>
												
												<label id="search_period_1M" class="btn_label search_period " onclick="selected_search_period('1M');">
												<input type="button" class="inner" value="1개월"></label>
												
												<label id="search_period_3M" class="btn_label search_period lst " onclick="selected_search_period('3M');">
												<input type="button" class="inner" value="3개월"></label>
										</div>

										<div class="box_opt">

											<input type="hidden" id="startDate" name="startDate" value="">
											<input type="hidden" id="endDate" name="endDate" value="">

											<select id="search_start_year" name="search_start_year" class="opt">
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
											</select>
											<span class="txt">년</span>
											
											<select id="search_start_month" name="search_start_month" class="opt">
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
											<span class="txt">월</span>
											
											<select id="search_start_date" name="search_start_date" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>											
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
											</select>
											<span class="txt">일</span>									
											
											<span class="txt_bar"> ~ </span>


											<select id="search_end_year" name="search_end_year" class="opt">
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
											</select>
											<span class="txt">년</span>
											
											<select id="search_end_month"name="search_end_month" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
											</select>
											<span class="txt">월</span>
											
											<select id="search_end_date" name="search_end_date" class="opt">
												<option value="1">01</option>
												<option value="2">02</option>
												<option value="3">03</option>
												<option value="4">04</option>
												<option value="5">05</option>
												<option value="6">06</option>
												<option value="7">07</option>
												<option value="8">08</option>
												<option value="9">09</option>
												<option value="10">10</option>
												<option value="11">11</option>
												<option value="12">12</option>
												<option value="13">13</option>
												<option value="14">14</option>
												<option value="15">15</option>
												<option value="16">16</option>
												<option value="17">17</option>
												<option value="18">18</option>
												<option value="19">19</option>
												<option value="20">20</option>
												<option value="21">21</option>
												<option value="22">22</option>
												<option value="23">23</option>
												<option value="24">24</option>
												<option value="25">25</option>
												<option value="26">26</option>
												<option value="27">27</option>
												<option value="28">28</option>
												<option value="29">29</option>
												<option value="30">30</option>
												<option value="31">31</option>
											</select>
											<span class="txt">일</span>

										</div>
									</div>
								</fieldset>
							</div>
					
					<label class="w3-label">부품id</label>&nbsp;&nbsp;<input type="text" name="productId" id="productId">&nbsp;&nbsp;
	    			<label class="w3-label">부품이름</label>&nbsp;&nbsp;<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
	    			<label class="w3-label">제조사</label>&nbsp;&nbsp;<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
	    			<input type="button" value="검색" id="doSearch">
	    									
					</form>
		
					</div>
					<div class="w3-container  w3-right-align  w3-margin">
					<a href="" class="w3-btn w3-blue-grey">선택확인</a>
					</div>
			</form>
		</div>
		<!-- 주문내역 -->
		<div>
			<table border='1' class="table table-striped table-bordered table-hover" id="purchaseList">
			<thead>
				<tr>
					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">주문시간</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">발주수량</th>
					<th class="w3-blue-grey">남은수량</th>
					<th class="w3-blue-grey">단가</th>
					<th class="w3-blue-grey">총합</th>
					<th class="w3-blue-grey">현재상황</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
			</table>
			<br>
		</div>
		
		<!-- 입고내역 -->
		<div style="text-align: center">
			<H3>
				<B>입고내역</B>
			</H3>
		</div>		
		<div>
		<div>
				
		<input type ="button" id="popup_open" value="입고 등록">		
		<input type ="hidden" id="purchaseId" name = "purchaseId" value = "">
		
		</div>
			<table border='1' class="table table-striped table-bordered table-hover" id = "incomingList">
			<thead>
				<tr>
					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">입고 차수</th>
					<th class="w3-blue-grey">입고시간</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>					
					<th class="w3-blue-grey">발주수량</th>
					<th class="w3-blue-grey">입고수량</th>
					<th class="w3-blue-grey">발주가격</th>
				</tr>
			</thead>			
			<tbody>
			</tbody>
				<!--  
				<tr>
					<td colspan="7"></td>
					<td>총가격</td>
					<td id ="incoming_sum">25,910,000</td>
				</tr>
				나중에 넣는걸로..
				-->
			
			</table>
			<!-- 
			<p> 총가격은 <span id="incoming_sum"> 25,910,000</span>원 </p>
			 -->
		</div>
	</div>
	
	
	<!-- 입고등록 popup -->
	<div id="popup_wrap">
		<div id="popup_title">		
			<h2>[<span></span>] 발주에 대한 [<span></span>]에서의 <span></span> <span></span></h2>
		</div>
		<div class="popup_content">
			<table border='1' class="table table-striped table-bordered table-hover" id="popup_table">
				<thead>
					<tr>
						<th>부품ID</th>
						<th>부품명</th>
						<th>총 발주수량</th>
						<th>남은 발주수량</th>
						<th>입고수량</th>						
					</tr>
				</thead>
				<tbody>
				</tbody>		
			</table>
			<input type = "hidden" id="icCount" value="">			
		</div>		
		<div class="popup-cont01">      
			<button id="popup_confirm">확인</button> 
        	<button id="popup_close">닫기</button> 
  		</div> 
	</div> 
	<div id="mask"></div> 





</body>
</html>