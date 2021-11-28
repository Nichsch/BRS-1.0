$(document).ready(function(){
	let actionContainer = $("#actionmenu");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				actionContainer.fadeIn(500);
			break;

			case "hideMenu":
				actionContainer.fadeOut(500);
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_radio/invClose");
		}
	};
});

$(document).on("click",".ativar",function(){
	let freq = Number($('#freq').val());
	if(freq > 0) {
		$.post("http://vrp_radio/activeFrequency",JSON.stringify({ freq }));
	}
})

$(document).on("click",".desativar",function(){
	$.post("http://vrp_radio/inativeFrequency");
})