<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.ohhoonim.vo.OrdrVo"%>
<%@ page import="com.ohhoonim.vo.CategoryVo"%>
<%@ page import="com.ohhoonim.vo.ProductVo"%>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/jsp/inc/common.jsp"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="/class202c/css/w3.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=contextPath%>/js/moment.js" type="text/javascript"></script>
<script src="<%=contextPath%>/js/mypage.js" type="text/javascript"></script>
<%
	List<ProductVo> productList = (List<ProductVo>) request.getAttribute("productList");
	List<Map<String, Object>> cartList = (List<Map<String, Object>>) request.getAttribute("cartList");

%>
<script>
	$(function() {
		init();
		selected_search_period('7D');		
		$.fn.rowspan = function(colIdx, isStats) {
			return this
				.each(function() {
					var that;
						$('tr', this).each(function(row) {
							$('td:eq(' + colIdx + ')', this).filter(':visible')
								.each(function(col) {if ($(this).html() == $(that).html()&& (!isStats || isStats&& $
										(
									this).prev().html() == $(that).prev().html())) {
									rowspan = $(that).attr("rowspan") || 1;
									rowspan = Number(rowspan) + 1;
									$(that).attr("rowspan",	rowspan);
									$(this).hide();
									} else {
									that = this;
									}
									that = (that == null) ? this
									: that;
							});
					});
			});
		};
		
		$('#selllist').rowspan(1);
		$('#selllist').rowspan(9);
		/* 		
		$('#startDate').val("");
		$('#endDate').val(""); */
		
		$('.opt').change(function(){
			order_list_period();			
		})
	
		$('.inner').click(function() {
			order_list_period();
		})
	});
	
</script>
<script> // endDate 오늘날짜로 설정
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
	}   // 여기까지가 초기값 오늘로 설정 + 
 
	// 기간 검색
	function order_list_period() {
		var startDate = $('#search_start_year').val()
				+ maker($('#search_start_month').val())
				+ maker($('#search_start_date').val()) + '000000';
		$('#startDate').val(startDate);
		console.log(startDate);
		var endDate = $('#search_end_year').val()
				+ maker($('#search_end_month').val())
				+ maker($('#search_end_date').val()) + '235959';
		$('#endDate').val(endDate);
		console.log(endDate);
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
<script>
// input 숫자만 !!
		function showKeyCode(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
			{
				return;
			}
			else
			{
				return false;
			}
		}
</script>
<script> //체크박스 전체 선택
$(document).ready(function(){
    $("#checkall").click(function(){
        if($("#checkall").prop("checked")){
            $("input[name=chk]").prop("checked",true);
        }else{
            $("input[name=chk]").prop("checked",false);
        }
    })
})
</script>
<script>
$(function(){
	  $('#btnDel').click(chkDel);
});
function chkDel() {
	
	var chkList = [];
	var ochkList = [];
	$('input[name="chk"]').each(function(){
	   	if($(this).is(":checked")){ 
			var tr = $(this).parent().parent();
			var prdId = tr.find('td:nth-child(4)').text();
	   		chkList.push(prdId);
	   		var ordId = tr.find('td:nth-child(2)').text();
	   		ochkList.push(ordId);
	   	}
	});


	
	var form = document.form;
	form.productId.value = chkList.join(',');
	form.ordrId.value = ochkList.join(',');
	form.submit();
};


</script>
</head>

<style>
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

#whole {
	position: center;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

h1 {
	font-family: "Trebuchet MS", Dotum, Arial;
	float: left;
	text-align: center;
	margin-left: 100px;
}

#topMenu {
	height: 30px;
	width: 850px;
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

	<div id="whole">
		<div>
			<jsp:include page="/WEB-INF/jsp/inc/menu_header2.jsp">
				<jsp:param name="" value="" />
			</jsp:include>
		</div>
		<br /> <br /> <br /> <br />
		<div>
			<form name="frm" action="<%=contextPath%>/ordr/ordr-004.do"
				method="post">
				<div style="text-align: center">
					<H3>
						<B>구매 내역 확인 페이지(소매처용)</B>
					</H3>
				</div>

				<table>
					<tr>
						
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

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


											<button type="submit" class="w3-btn w3-blue-grey"
												onclick="order_list_period">
												<span class="inner">조회하기</span>
											</button>
										</div>
									</div>
								</fieldset>
							</div> <!--					
<div class="box_radio">
<input id="datepicker" type="text" />~<input id="datepicker1"type="text" /> 
<label id="search_period_7D" for="radio01" class="btn_label search_period fst on" onclick="selected_search_period('7D')"><span class="inner">1주일</span></label>
<label id="search_period_15D" for="radio02" class="btn_label search_period" onclick="selected_search_period('15D');"><span class="inner">15일</span></label>
<label id="search_period_1M" for="radio03" class="btn_label search_period" onclick="selected_search_period('1M');"><span class="inner">1개월</span></label>
<label id="search_period_3M" for="radio04" class="btn_label search_period lst" onclick="selected_search_period('3M');"><span class="inner">3개월</span></label>
	 -->
							</div>
						</td>
					</tr>
					<tr>
					
					
					</tr>
				</table>
				<div class="w3-container  w3-right-align  w3-margin">
					<input type="button" id="btnDel" class="w3-btn w3-blue-grey" value="선택 주문 취소">
				</div>
			</form>
		</div>
		<div>
			<table border='1'
				class="table table-striped table-bordered table-hover" id="selllist">
				<tr>
					<th class="w3-blue-grey"><input type="checkbox" id="checkall" value="" /></th>
					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">주문시간</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">수량</th>
					<th class="w3-blue-grey">상태</th>
					<th class="w3-blue-grey">개당가격</th>
					<th class="w3-blue-grey">총합</th>
				</tr>

				<%
					for (Map<String, Object> row : cartList) {
				%>

				<tr class="temp">
					<td><input type="checkbox" name="chk" value="" /></td>
					<td><%=row.get("ordrId")%></td>
					<td><%=row.get("ordrDate")%></td>
					<td><%=row.get("productId")%></td>
					<td><%=row.get("productNm")%></td>
					<td><%=row.get("ptnrNm")%></td>
					<td><%=row.get("amnt")%></td>
					<td><%=row.get("status")%></td>
					<td><%=Utils.customNum(row.get("salesCost").toString(), "###,###")%></td>
					<td><%=Utils.customNum(row.get("total").toString(), "###,###")%></td>
				</tr>
				<%
					}
				%>
			</table>

		</div>
	</div>
<form name="form" method="post" action="<%=contextPath%>/ordr/delOrdr.do">
		<input type="hidden" name="productId" value="">
		<input type="hidden" name="ordrId" value="">
</form>
</body>
</html>




