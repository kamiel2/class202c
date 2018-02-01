// common.js 

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

function maker(a) {
	if (a.length == 1) {
		var b = '0' + a;
	} else {
		var b = a;
	}
	return b;
}