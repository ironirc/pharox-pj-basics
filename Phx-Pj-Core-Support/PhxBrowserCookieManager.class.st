Class {
	#name : 'PhxBrowserCookieManager',
	#superclass : 'PjDomController',
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'as yet unclassified' }
PhxBrowserCookieManager class >> getCookie: cname [

	<javascript: 'var name = cname + "=";
  var ca = document.cookie.split(";");
  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == " ") {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";'>
	self error: 'only possible on browser'
]

{ #category : 'as yet unclassified' }
PhxBrowserCookieManager class >> setCookie: cookieName value: cvalue expiryMs: expiryMs [
	<javascript:
		'var d = new Date();
  d.setTime(d.getTime() + (expiryMs));
  var expires = "expires="+d.toUTCString();
  document.cookie = cookieName + "=" + cvalue + ";" + expires + ";path=/";'>
	self error: 'only possible on browser'
	
]
