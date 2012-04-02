var playzone_width = 390;
var playground = new array ['a1_','a2_','a3_','b1_','b2_','b3_','c1_','c2_','c3_'];

function initCanvas(){	
	clearCanvas(); // clear existing canvas			
	canvas.onmousemove = highlightCase;	
	canvas.onmouseout= clearCanvas;
}

function getCanvas(){
	return document.getElementById('canvas');	
}

function getContext(canvas){				
	if (canvas && canvas.getContext) {
		var context = canvas.getContext('2d');
		if (context) {	
			return context;
		}
	}
}

function highlightCase(e){
	var canvas = $('#canvas');
	var posX =e.pageX - canvas.offset().left;
	var posY =e.pageY - canvas.offset().top;	
	var caseX = getCasePos(posX);
	var caseY = getCasePos(posY);	
	drawHighligtCase(caseX,caseY);
}

function drawHighligtCase(caseX,caseY){
	var canvas = getCanvas();
	var context = getContext(canvas);
	
	clearCanvas();
	
	context.beginPath();
	context.rect(caseX, caseY, playzone_width/3, playzone_width/3);
	context.fillStyle = "#bebede";
    context.fill();
    context.lineWidth = 1;
    context.strokeStyle = "black";
    context.stroke();
}

function getCasePos(pos){
	if(pos < playzone_width/3){
		myCase = 0;
	}
	else if (pos > playzone_width/3 && pos <2*(playzone_width/3)){
		myCase = playzone_width/3;
	}
	else if (pos > 2*(playzone_width/3)){
		myCase = 2*(playzone_width/3);
	}
	return myCase;
}

function drawPlaygroundLines(context){
	context.beginPath();
	context.moveTo(playzone_width/3, 10);
	context.lineTo(playzone_width/3, playzone_width-10);
	context.moveTo(2*playzone_width/3, 10);
	context.lineTo(2*playzone_width/3, playzone_width-10);
	context.moveTo(10, playzone_width/3);
	context.lineTo(playzone_width-10, playzone_width/3);
	context.moveTo(10, 2*playzone_width/3);
	context.lineTo(playzone_width-10, 2*playzone_width/3);
	context.stroke();
	context.closePath();
}

function drawCrossAndRound(context){
	
}

function clearCanvas() {
	var canvas = getCanvas();
	var context = getContext(canvas);
	context.clearRect(0, 0, canvas.width, canvas.height);
	var w = canvas.width;
	canvas.width = 1;
	canvas.width = w;
	context.fillStyle = '#dedebe';		  	
	context.fillRect(0, 0, playzone_width, playzone_width);			
	drawPlaygroundLines(context);	
	drawCrossAndRound(context);
}
