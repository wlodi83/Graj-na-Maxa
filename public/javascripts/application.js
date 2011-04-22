// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('a[data-popup]').live('click', function(e) {
   window.open($(this).href);
   e.preventDefault();
};
window.onload = function() {
	var lis = document.getElementById('cssdropdown').getElementsByTagName('li');
	for(i = 0; i < lis.length; i++)
	{
		var li = lis[i];
		if (li.className == 'headlink')
		{
			li.onmouseover = function() { this.getElementsByTagName('ul').item(0).style.display = 'block'; }
			li.onmouseout = function() { this.getElementsByTagName('ul').item(0).style.display = 'none'; }
		}
	}
};
