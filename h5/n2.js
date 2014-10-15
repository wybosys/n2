var n2 = new function() {

	this.core = new function() {	
		return this;
	}();
	
	function Signals(own) {
		this._own = own;
		this._store = new Object();
		if (typeof(own._initsignals) != "undefined") {
			own._initsignals(); 
		}
		Signals.prototype.emit = function(sig, result) {
			alert(sig);	
		};
		return this;
	}
	this.signals = new Signals(this);
	
	this.app = new function() {
		this.signals = new Signals(this);
		var kSignalLoaded = "::n2::app::loaded";
	};
	
	(function() {
		// init n2
		if (document.getElementsByTagName("n2").length == 0) {
			return;
		}

		// hook window
		window.onload = function() {
			
		};
	})();
		
	return this;
}();
