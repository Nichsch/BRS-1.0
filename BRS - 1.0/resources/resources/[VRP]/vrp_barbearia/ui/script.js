$(document).ready(function(){
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursor = $('#cursorPointer');
	var cursorX = documentWidth/2;
	var cursorY = documentHeight/2;

	function triggerClick(x,y){
		var element = $(document.elementFromPoint(x,y));
		element.focus().click();
		return true;
	}

	window.addEventListener('message',function(event){
		document.getElementById("hairModel").value = event.data.hairModel;
		document.getElementById("firstHairColor").value = event.data.firstHairColor;
		document.getElementById("secondHairColor").value = event.data.secondHairColor;
		document.getElementById("makeupModel").value = event.data.makeupModel;
		document.getElementById("lipstickModel").value = event.data.lipstickModel;
		document.getElementById("lipstickColor").value = event.data.lipstickColor;
		document.getElementById("eyebrowsModel").value = event.data.eyebrowsModel;
		document.getElementById("eyebrowsColor").value = event.data.eyebrowsColor;
		document.getElementById("beardModel").value = event.data.beardModel;
		document.getElementById("beardColor").value = event.data.beardColor;
		document.getElementById("blushModel").value = event.data.blushModel;
		document.getElementById("blushColor").value = event.data.blushColor;		

		if(event.data.openBarbershop == true){
			$(".openBarbershop").show();

			$('.input .label-value').each(function(){
				var max = $(this).attr('data-legend'), val = $(this).next().find('input').val();
				$(this).parent().find('.label-value').text(val+'/'+max);
			});
		}

		if(event.data.openBarbershop == false){
			$(".openBarbershop").hide();
		}

		if (event.data.type == "click") {
			triggerClick(cursorX-1,cursorY-1);
		}
	});

	$('input').change(function(){
		$.post('http://vrp_barbearia/updateSkin',JSON.stringify({
			value: false,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),
			lipstickModel: $('.lipstick').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel : $('.eyebrow').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),
			beardModel : $('.beard').val(),
			beardColor: $('.beardcolor').val(),
			blushModel: $('.blush').val(),
			blushColor: $('.blushcolor').val()
		}));
	});

	$('.arrow').on('click',function(e){
		e.preventDefault();
		$.post('http://vrp_barbearia/updateSkin',JSON.stringify({
			value: false,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),

			lipstickModel: $('.lipstick').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel : $('.eyebrow').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),

			beardModel : $('.beard').val(),
			beardColor: $('.beardcolor').val(),

			blushModel: $('.blush').val(),
			blushColor: $('.blushcolor').val()
		}));
	});

	$('.yes').on('click',function(e){
		e.preventDefault();
		$.post('http://vrp_barbearia/updateSkin',JSON.stringify({
			value: true,
			hairModel: $('.hair').val(),
			firstHairColor: $('.haircolor').val(),
			secondHairColor: $('.haircolor2').val(),
			makeupModel: $('.makeup').val(),

			lipstickModel: $('.lipstick').val(),
			lipstickColor: $('.lipstickcolor').val(),
			eyebrowsModel : $('.eyebrow').val(),
			eyebrowsColor: $('.eyebrowcolor').val(),

			beardModel : $('.beard').val(),
			beardColor: $('.beardcolor').val(),

			blushModel: $('.blush').val(),
			blushColor: $('.blushcolor').val()
		}));
	});
});