function Mypage_object(opts) {
	this.opts = {
		page_type : 'buylist',
		page_kind : '',
		list_url : '/src/main/webapp/WEB-INF/jsp/ordr/order-004.jsp/',
		search_start_year : null,
		search_start_month : null,
		search_start_date : null,
		search_end_year : null,
		search_end_month : null,
		search_end_date : null,
		search_start_full_date : null,
		search_end_full_date : null
	};
	this.set_opts(opts);
	this.is_init = false;
}

function selected_search_period(period) {
	$('.btn_label').each(function() {
		$(this).removeClass('on');
	});
	$('#search_period_' + period).addClass('on');

	var end_year = $('#search_end_year').val();
	var end_month = $('#search_end_month').val();
	var end_date = $('#search_end_date').val();

	var d = moment([ end_year, end_month - 1, end_date ]);

	
	switch (period) {
	case '7D':
		d.add(-6, 'days');
		break;
	case '15D':
		d.add(-15, 'days');
		break;
	case '1M':
		d.add(-1, 'months');
		break;
	case '3M':
		d.add(-3, 'months');
		break;
	}
	
	var _d = d.format('YYYY-MM-DD').split('-');

	$('#search_start_year').val(parseInt(_d[0]));
	$('#search_start_month').val(parseInt(_d[1]));
	$('#search_start_date').val(parseInt(_d[2]));
	

		
}

