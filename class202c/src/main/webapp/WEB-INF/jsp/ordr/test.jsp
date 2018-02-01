<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script>
var mergeItem="";
var mergeCount=0;
var mergeRowNum=0;

$('tr','table','#selllist').each(function(row){
	if(row > 2 ) {
		var thisTr = $(this);
		var item = $(':first-child',thisTr).html();
		
		if(mergeItem != item) {
			mergeCount=1;
			mergeItem=item;
			mergeRowNum = Number(row); // 숫자 형태로
		
		} else{
			mergeCount = Number(mergeCount)+1;
			$("tr:eq("+mergeRowNum+") > td:first-child").attr("rowspan",mergeCount);
			$('td:first-child', thisTr).remove();
		}
		
	}
	
})
</script>
<body>
				<div> 
					<table id="test">
						<tr>
							<td>1</td>
							<td>2</td>
							<td>3</td>
							<td>4</td>
							<td>5</td>
						</tr>
						<tr>
							<td>1</td>
							<td>7</td>
							<td>3</td>
							<td>5</td>
							<td>6</td>
						</tr>
						<tr>
							<td>1</td>
							<td>a</td>
							<td>s</td>
							<td>e</td>
							<td>f</td>
						</tr>
						<tr>
							<td>1</td>
							<td>5y</td>
							<td>eyh</td>
							<td>we</td>
							<td>rwe</td>
						</tr>
						<tr>
							<td>1</td>
							<td>sa</td>
							<td>dfas</td>
							<td>fsa</td>
							<td>w</td>
						</tr>
						<tr>
							<td>a</td>
							<td>s</td>
							<td>d</td>
							<td>f</td>
							<td>f</td>
						</tr>

					</table>
					</div>
				</ul>
			</nav>
</body>
</html>