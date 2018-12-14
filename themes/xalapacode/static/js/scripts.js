function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function starter() {
	console.log('XalapaCode in the house');

	let logo = document.querySelectorAll('.logo img');
	el.addEventListener('contextmenu', function(event){
		event.preventDefault();
		window.location.href('/branding.html');
	})

}
