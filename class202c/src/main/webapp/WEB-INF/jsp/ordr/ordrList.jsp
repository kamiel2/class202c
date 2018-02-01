<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.ohhoonim.vo.OrdrVo" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ include file = "/WEB-INF/jsp/inc/common.jsp" %>
<%@ page import="com.ohhoonim.common.util.Utils"%>
<%@ page import="java.util.Calendar"%>

<%
	Calendar cal=Calendar.getInstance();
	String year=request.getParameter("search_end_year");
		if(year==null) year=cal.get(Calendar.YEAR)+"";
	String month=request.getParameter("search_end_month");
		if(month==null) month=cal.get(Calendar.MONTH)+1+"";
	String day=request.getParameter("search_end_date");
		if(day==null) day=cal.get(Calendar.DATE)+"";

	List<Map<String,Object>> ordrList = (List<Map<String,Object>>)request.getAttribute("ordrList");
	List<Map<String,Object>> ordroutgoingList = (List<Map<String,Object>>)request.getAttribute("ordroutgoingList");
	String ordrId = (String)request.getAttribute("ordrId");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>더조은 총판</title>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
		integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
		crossorigin="anonymous">
	<link rel="stylesheet" href="<%=contextPath %>/css/w3.css">
	<link rel="stylesheet" href="<%=contextPath %>/css/common.css">
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="<%=contextPath%>/js/moment.js" type="text/javascript"></script>
	<script src="<%=contextPath%>/js/mypage.js" type="text/javascript"></script>
	<script src="<%=contextPath%>/js/common.js" type="text/javascript"></script>
	<script>
		$(function() {
			init(); // 검색영역 날짜초기화
			selected_search_period('7D'); // 기본 검색 기간 설정 : 7일
			$('.opt').change(order_list_period); // 달력
			$('.inner').click(order_list_period); // 달력
			$('#chkAll').click(chkAll);  // 전체선택
			$('#selectConfirm').click(chkConfirm); // 선택확인
			$('#doSearch').click(selectList); // 검색
			$('#ordrId, #ptnrNm, #productNm').keydown(searchEnter);// 조회시 엔터 이벤트 -> 검색 실행	
			$("#popup_open").click(popup_open); // 출고 등록 팝업
			$("#popup_close").click(popup_close); 
			$("#popup_confirm").click(popup_confirm); 
		});
		
		function init() {
			var oYear = document.getElementById("search_end_year").options;
			
			for(var i=1; i < oYear.length; i++) {
				var val=oYear[i].value;	
					if('<%=year%>'==parseInt(val)){
						oYear.selectedIndex=i;
						break;
					}
			}
		
			var oMonth=document.getElementById("search_end_month").options;	
			for(var i=1;i<oMonth.length;i++){
				var val=oMonth[i].value;
				if('<%=month%>' == parseInt(val)) {
					oMonth.selectedIndex=i;
					break;	
				}
			}
			
			var oDay=document.getElementById("search_end_date").options;	
			for(var i=1;i<oDay.length;i++) {
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
			
			var endDate = $('#search_end_year').val()
					+ maker($('#search_end_month').val())
					+ maker($('#search_end_date').val()) + '235959';
			$('#endDate').val(endDate);
			
		}
		
		function chkAll() {
			if ($(this).prop("checked")) {
				$("input[name=chk]").prop("checked",true);
			} else {
				$("input[name=chk]").prop("checked",false);
			}
		}
		
		//선택확인: '주문미승인' -> '출고대기' 로 변경 
		function chkConfirm() {
			
			var chkListOrdrId = [];
			var chkListPrdId = [];
			$('input[name="chk"]').each(function(){
				if($(this).is(":checked")){
					var tr = $(this).parent().parent();
					var ordrId = tr.find('td:nth-child(2)').text();
					var prdId = tr.find('td:nth-child(6)').text();
					
					chkListOrdrId.push(ordrId);
					chkListPrdId.push(prdId);
				}
			});
			
			var form = document.form;
			form.ordrId.value = chkListOrdrId.join(',');
			form.prdId.value = chkListPrdId.join(',');
			form.submit();
		}
		
		function searchEnter(event) {
			if ( event.which == 13 ) {
				$('#doSearch').click();	
				return false;
			}
		}
		/////////////////////////////////////////////////////////////////////////////////////////
		// 주문내역
		function selectList(){
			var a = '<tr><td><input type="checkbox" name="chk" %s/></td><td>%s</td>'+
					'<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+
					'<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+
					'<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td></tr>';
			$.ajax({
				url : '<%=contextPath%>/ordr/ordrSearch.do',
					data : {
								ordrId : $('#ordrId1').val(), 
								ptnrNm : $('#ptnrNm').val(), 
								productNm : $('#productNm').val(),
								startDate : $('#startDate').val(), 
								endDate : $('#endDate').val()
							},
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {					
						var options='';
						var isDisabled = 'disabled';
						var list = data.result;
					      for (var i = 0; i < list.length; i++) {
					    	  isDisabled = 'disabled';
					    	  if (list[i].status == '1101') {
					    		  isDisabled = '';
					    	  }
					    	  options += sprintf(a,
					    			  isDisabled, list[i].ordrId, list[i].ordrDate,
					    			  list[i].ptnrId, list[i].ptnrNm, list[i].productId,
					    			  list[i].productNm, list[i].ptnrNm2, list[i].rstock,
					    			  list[i].amnt, numberWithCommas(list[i].unitPrice), 
					    			  numberWithCommas(list[i].salesCost),
					    			  numberWithCommas(list[i].total), 
					    			  numberWithCommas(list[i].profit), 
					    			  list[i].statusnm); 	  
					      }				     
					      $("#list tbody").html(options);
					      
					    //출고 상세 내역
					      $("#list tbody tr").click(function(){
					  		var temp = $(this);
					  		selectList1(temp);
					  		
					  	});
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
					}
				});	
		}
		
		//출고 상세 내역
		function selectList1(temp){
			var tr = temp;
			var td = tr.children();
			var ordrId = td.eq(1).text();
			//$('#ordrId1').val(ordrId);  //ordrId1 -> 검색영역의 주문Id
				
			var a = '<tr><td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+
					'<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+
					'<td><input type="text" name="amnt2" id="amnt2" value="%s" ><span class="w3-btn w3-blue-grey btnChangeQty">수량변경</span></td> '+
					'<td>%s</td></tr>';
			$.ajax({
				url : '<%=contextPath%>/ordr/ordrSearch1.do',
					data : { ordrId : ordrId },
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {					
						var options='';					
						var list = data.result1;
						
						if (list != null && list.length > 0) {
						    for (var i = 0; i < list.length; i++) {
						    	options += sprintf(a,
						    			  list[i].ordrId, list[i].count, list[i].ogDate, list[i].productId,
						    			  list[i].productNm, list[i].ptnrNm2, list[i].rstock, list[i].amnt,
						    			  list[i].amnt1, numberWithCommas(list[i].salesCost * list[i].amnt1)
						    			  ); 	  
						    }
						    var status = list[0].status;
					      
							if(status === '1303'){ // 출고완료
								$('#popup_open').hide();
								$('#ordrId').val("");
							} else {
								$('#popup_open').show();
								$('#ordrId').val(ordrId);
							}
						    $("#list1 tbody").html(options);
						    $('.btnChangeQty').click(btnChangeQty); // 출고내역 수량변경
						} else {
							$("#list1 tbody").html('<tr><td colspan="10">데이터가 없습니다.</td></tr>');
							$("#list1 tbody").html("");	
							$('#popup_open').show();
							$('#ordrId').val(ordrId);
						}
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: ' + JSON.stringify(jqXHR));
						$("#list1 tbody").html("");	
						$('#popup_open').show();
						$('#ordrId').val(ordrId);
					}
				});
		}
		// 출고내역 수량변경
		function btnChangeQty() {
			var amnt2 = $(this).parent().find('input').val();
			var ordrId = $(this).parent().parent().find('td:nth-child(1)').text();
			var productId = $(this).parent().parent().find('td:nth-child(5)').text();
			var count = $(this).parent().parent().find('td:nth-child(10)').text();
			
			$('#changeQtyFormAmnt2').val(amnt2);
			$('#changeQtyFormOrdrId').val(ordrId);
			$('#changeQtyFormProductId').val(productId);
			$('#changeQtyFormCount').val(count);
			
			document.changeQtyForm.submit();
		}
		
		
		///////////////////////////////////////////////////////////////////////////
		//출고 등록 팝업
		function popup_open(){ 
			$("#popup_wrap").css("display", "block"); 
			$("#mask").css("display", "block"); 
			ogAddView();  // 출고 등록 확인버튼
		}
		
		function ogAddView() {
			$("#popup_confirm").off('click');
			var a = '<tr>'+
					'<td><input type="hidden" class="productId" value="%s">%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+ '<td>%s</td>'+
					'<td><input type="text" class="addOgAmnt" value="0"></td>'+
					'</tr>';
			var ordrId = $('#ordrId').val();
			$("#popup_confirm").click(ogAdd);
						
			$.ajax({
				url : '<%=contextPath%>/outgoing/outgoingAddView.do',
					data : {
						ordrId : $('#ordrId').val()
						},
					method : "post",
					dataType : "json",
					  
					success : function(data, status, jqXHR) {
						var options='';					
						var list = data.result;
						if(list.length > 0) {
							for (var i = 0; i < list.length; i++){	  
						    	  options += sprintf(a,
						    			  list[i].productId,
						    			  list[i].productId,
						    			  list[i].productNm,
						    			  numberWithCommas(list[i].amnt),
						    			  numberWithCommas(list[i].amntLo)			  							    			  
						    			  ); 
							}
						      $("#popup_title").find("span:nth-child(1)").text(list[0].ordrId);	
						      $("#popup_title").find("span:nth-child(2)").text(list[0].ptnrNm);				      
							
						} else {
							options += '<tr><td colspan="5">조회된 데이터가 없습니다.</td></tr>'; 
						}
				  
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
		
		// 출고 등록 팝업에서 등록
		function ogAdd(){	
			$("#popup_confirm").off('click');
			var ordrId = $('#ordrId').val();
						
			var ogAddAmnt = $('.addOgAmnt');
			var productId = $('.productId');
			
			var ogAddAmnts = [];
			ogAddAmnt.each(function() {
				var val = $(this).val();
				if (val == null || val == 0 || val == '') {
					alert('수량이 0 또는 입력되지 않으면 출고등록이 되지 않습니다.');
					val = 0;
				}
				ogAddAmnts.push(val);
			});
			
			var productIds = [];
			productId.each(function() {
				productIds.push($(this).val());
			})
			
			$.ajax({
				url : '<%=contextPath%>/outgoing/outgoingAdd.do',
					data : {
						'ordrId' : ordrId, 
						'ogAddAmnt' : ogAddAmnts.join(','), 
						'productId' : productIds.join(',')
						},
					method : "post",
					dataType : "json",
					success : function(data, status, jqXHR) {
						var chk = data.result;
						selectList(ordrId);
						selectList1();
						popup_close();
					},
					error : function(jqXHR, status, errorThrown) {
						alert('ERROR: 관리자문의');
					}
				});
		}

		function popup_close(){ 
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none"); 
			$("#popup_title").find("span").text("");
			$("#popup_table tbody").html("");	
			$("#ogCount").val("");
		}
		
		function popup_confirm() {
			ogAdd();	
			$("#popup_wrap").css("display", "none"); 
			$("#mask").css("display", "none"); 
			$("#popup_title").find("span").text("");
			$("#popup_table tbody").html("");	
			$("#ogCount").val("");
		}
	
	</script>
</head>
<body>
		<div>
		<jsp:include page="/WEB-INF/jsp/inc/menu_header1.jsp">
		<jsp:param name="" value=""/>
</jsp:include>
		</div>
		<br> <br><br><br><br>
		<div id="whole">
		    <div id="title" style="text-align: center">
					<H3><B>판매 내역 확인 페이지</B></H3>
			</div>
		<div id="contents">
			<div id="search">
			<form name="ordrForm" action="" method="post">
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
				<label class="w3-label">주문id</label>&nbsp;&nbsp;<input type="text" name="ordrId1" id="ordrId1">&nbsp; 
				<label class="w3-label">소매처이름</label>&nbsp;&nbsp;<input type="text" name="ptnrNm" id="ptnrNm">&nbsp;&nbsp;
				<label class="w3-label">부품명</label>&nbsp;&nbsp;<input type="text" name="productNm" id="productNm">&nbsp;&nbsp;
				<input type="button" value="검색" id="doSearch"><br>
				<!-- a href="" class="w3-btn w3-blue-grey">1주</a> 
				<a href="" class="w3-btn w3-blue-grey">1달</a> 
				<a href="" class="w3-btn w3-blue-grey">3달</a> 
				&nbsp;&nbsp;<input id="datepicker" type="text" value="2017-11-17" />~
				<input id="datepicker1" type="text" value="2017-11-17" /> -->
			</form>
			</div>
			<div id="buttons">
			<input type="button" value="선택확인" id="selectConfirm">
			</div>
		
			<table border='1'
				class="table table-striped table-bordered table-hover" id="list">
				<thead>
				<tr>
					<th><input type="checkbox" name="chkAll" id="chkAll" value="" /></th>
					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">주문시간</th>
					<th class="w3-blue-grey">소매처ID</th>
					<th class="w3-blue-grey">소매처이름</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">수량</th>
					<th class="w3-blue-grey">단가</th>
					<th class="w3-blue-grey">개당가격</th>
					<th class="w3-blue-grey">총합</th>
					<th class="w3-blue-grey">영업이익</th>
					<th class="w3-blue-grey">현재상황</th>
				</tr>
				</thead>
				<tbody>
				<%
					for (Map<String,Object> row : ordrList ){
				
						String isEnable = "disabled";
						
						if (row.get("status") != null && row.get("status").equals("1101")) {
							isEnable = "";
						}
				%>
				
				<tr class="temp">
				
					<td><input type="checkbox" name="chk" <%= isEnable %> /></td>
					<td><%=row.get("ordrId") %></td>
					<td><%=row.get("ordrDate") %></td>
					<td><%=row.get("ptnrId") %></td>
					<td><%=row.get("ptnrNm")%></td>
					<td><%=row.get("productId") %></td>
					<td><%=row.get("productNm") %></td>
					<td><%=row.get("ptnrNm2")%></td>
					<td><%=row.get("rstock") %></td>
					<td><%=row.get("amnt") %></td>
					<td><%=row.get("unitPrice") %></td>
					<td><%=row.get("salesCost") %></td>
					<td><%=row.get("total") %></td>
					<td><%=row.get("profit") %></td>
					<td><%=row.get("status")%></td>
				</tr>
				<%
					}
				%>
				</tbody>
			</table>

			
		</div>
		
	
		<div style="text-align: center">
			<H3>
				<B>출고내역</B>
			</H3>
		</div>
		<div id="contents">
		<div>
				
		<input type ="button" id="popup_open" value="출고등록">		
		<input type ="hidden" id="ordrId" name = "ordrId" value = "">
		<input type ="hidden" id="productId" name = "productId" value = "">
		
		
		</div>
		<form name="frm" action="<%=contextPath%>/ordr/ordroutgoingModify.do" method="post">
			<table border='1'
				class="table table-striped table-bordered table-hover" id="list1">
				<thead>
				<tr>

					<th class="w3-blue-grey">주문번호</th>
					<th class="w3-blue-grey">출고차수</th>
					<th class="w3-blue-grey">출고시간</th>
					<th class="w3-blue-grey">부품ID</th>
					<th class="w3-blue-grey">부품명</th>
					<th class="w3-blue-grey">제조사</th>
					<th class="w3-blue-grey">현재재고</th>
					<th class="w3-blue-grey">판매수량</th>
					<th class="w3-blue-grey">출고수량</th>
					<th class="w3-blue-grey">판매가격</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
			</form>
			</div>
		</div>
		<!-- 출고등록 popup -->
	<div id="popup_wrap">
		<div id="popup_title">		
			<h2>[<span></span>] 판매에 대한 [<span></span>]에서의 출고 등록</h2>
		</div>
		<div class="popup_content">
			<table border='1' class="table table-striped table-bordered table-hover" id="popup_table">
				<thead>
					<tr>
						<th>부품ID</th>
						<th>부품명</th>
						<th>총 판매수량</th>
						<th>남은 판매수량</th>
						<th>출고수량</th>						
					</tr>
				</thead>
				<tbody>
				</tbody>		
			</table>
			<input type = "hidden" id="ogCount" value="">			
		</div>		
		<div class="popup-cont01">      
			<button id="popup_confirm">확인</button> 
        	<button id="popup_close">닫기</button> 
  		</div> 
	</div> 
	<div id="mask"></div> 
	<form name="form" method="post" action="<%=contextPath%>/ordr/updateConfirm.do">
		<input type="hidden" name="ordrId" value="">
		<input type ="hidden" id="prdId" name = "prdId" value = "">
	</form>
	<form name="changeQtyForm" method="post" id="changeQtyForm" action="<%=contextPath%>/ordr/ordroutgoingModify.do">
		<input type="hidden" name="amnt2" id="changeQtyFormAmnt2" value="">
		<input type="hidden" name="ordrId" id="changeQtyFormOrdrId" value="">
		<input type="hidden" name="productId" id="changeQtyFormProductId" value="">
		<input type="hidden" name="count" id="changeQtyFormCount" value="">
	</form>
</body>
</html>