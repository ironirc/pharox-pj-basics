Class {
	#name : 'PhxJsDebounce',
	#superclass : 'Object',
	#category : 'Phx-Pj-Core-Support',
	#package : 'Phx-Pj-Core-Support'
}

{ #category : 'as yet unclassified' }
PhxJsDebounce class >> debounce: func wait: wait immediate: immediate [
	<javascript:
		'var timeout;
	return function() {
		var context = this, args = arguments;
		var later = function() {
			timeout = null;
			if (!immediate) func.apply(context, args);
		};
		var callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(later, wait);
		if (callNow) func.apply(context, args);
	};'>
	
]
