$(document).ready(function(){
	window.addEventListener("message",function(event){
    var id = event.data.css+event.data.diferencial;
		var html = "<br><div id='"+id+"' class="+event.data.css+">"+event.data.mensagem+"</div>";

    $(html).appendTo("#notifications");
    

    setTimeout(function(){
      $("#notifications").animate({ maxWidth: "550px" }, 500 );
      $("#"+id+"").animate({ fontSize: "14px" }, 400 );
    }, 100);

    setTimeout(function(){
      $("#"+id+"").animate({ fontSize: "0px", height: "30px" }, 500 );
      $("#"+id+"").fadeOut(400);
    }, event.data.tempo);

    setTimeout(function(){
      $("#"+id+"").remove();
    }, event.data.tempo + 2500);
	})
});