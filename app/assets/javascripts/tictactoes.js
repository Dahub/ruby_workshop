var playzone_width = 390;
var playground;
var playerSymbol;

function initCanvas(pg, ps){
    playground= pg;
    playerSymbol = ps;
	clearCanvas(); // clear existing canvas			
	canvas.addEventListener('mousemove',highlightCase,false);	
	canvas.addEventListener('mouseout',clearCanvas,false);
	canvas.addEventListener('click', clicAppends, false);
}

function getCanvas(){
	return document.getElementById('canvas');	
}

function highlightCase(e){
	var canvas = $('#canvas');
	var caseX = getCaseX(canvas,e);
	var caseY = getCaseY(canvas,e);
	drawHighligtCase(caseX,caseY);
}

function transformToCase(e){
    var coords = relMouseCoords($(canvas), e);
    var x;
    var y;
    if(coords.posX <= playzone_width/3){
        x = '1';
    }
    else if(coords.posX > playzone_width/3 && coords.posX < playzone_width/1.5){
        x= '2';
    }
    else{
        x = '3';
    }
    if(coords.posY <= playzone_width/3){
        y = 'c';
    }
    else if (coords.posY > playzone_width/3 && coords.posY < playzone_width/1.5){
        y = 'b';
    }
    else{
        y = 'a';
    }
    
    return {caseX:x , caseY:y };    
}

function clicAppends(e){    
    var caseCoords = transformToCase(e);    
    var moveString = caseCoords.caseY + caseCoords.caseX + playerSymbol;
    $("#loadingDiv").removeClass("tictactoe_loading_hidden");
    $("#loadingDiv").addClass("tictactoe_loading"); 
	$.post("/tictactoes/ask_move",{ move: moveString}, function(data){
	    playground = data;
        clearCanvas();
        $("#loadingDiv").addClass("tictactoe_loading_hidden");
        $("#loadingDiv").removeClass("tictactoe_loading"); 
        $.post("/tictactoes/ask_party_state", function(data){
            if(data != "none"){
                showEndGame(data);
            }
        });
    });
}

function showEndGame(partyState){
    $("#partyEnd").removeClass("tictactoe_end_party_hidden");
    $("#partyEnd").addClass("tictactoe_end_party");     
    var text = "Draw";
    if(partyState == "player"){
        text = "Player win";
    }
    else if(partyState == "ia"){
        text = "IA win";
    }
    $("#partyEnd").html(text);
}

function getCaseX(canvas,e){
    var posX =e.pageX - canvas.offset().left;
    return getCasePos(posX);
}

function getCaseY(canvas,e){
    var posY =e.pageY - canvas.offset().top;
    return getCasePos(posY);
}

function drawHighligtCase(caseX,caseY){
	var canvas = getCanvas();
	var context = getContext(canvas);
	
	clearCanvas();
	
	context.beginPath();
	context.rect(caseX, caseY, playzone_width/3, playzone_width/3);
	context.fillStyle = "rgba(68, 36, 41, 0.5)"; 
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

function drawCrossAndRound(){
    var canvas = getCanvas();
	var context = getContext(canvas);	
	var cases = playground.split('#');
	for(var index=0;index<cases.length;index++)
	{
	    drawSymbol(cases[index],canvas,context);	
	}
}

function drawSymbol(myCase,canvas,context){ 
    var x = getXpixel(myCase.charAt(1));
    var y = getYpixel(myCase.charAt(0));
    if(myCase.charAt(2) == 'x')    
    {
        drawCross(myCase,canvas,context,x,y);
    }
    else if (myCase.charAt(2) == 'o')
    {
        drawRound(myCase,canvas,context,x,y);
    }
}

function drawCross(myCase,canvas,context,x,y){
    var rectLength = playzone_width/4;
    var padding = (playzone_width/3 - rectLength)/2;
    context.beginPath();
    context.lineWidth="5";
    context.moveTo(padding + x, padding + y);
	context.lineTo(padding + x + rectLength, padding + y + rectLength);
	context.moveTo(padding + x + rectLength, padding + y);
	context.lineTo(padding + x , padding + y + rectLength);
    context.stroke();
}

function drawRound(myCase,canvas,context,x,y){
    var ray = playzone_width/8;
    var padding = (playzone_width/3 - 2*ray)/2;
    context.beginPath();
    context.lineWidth="5";    
    context.arc(ray + x + padding, ray + y + padding, ray, 0, 2 * Math.PI);
    context.stroke();
}

function getXpixel(number){
    if(number == '2'){
        return playzone_width/3;
    }
    else if(number == '3'){
        return (playzone_width/3) * 2;
    }
    else{
        return 0;
    }
}

function getYpixel(letter){
    if(letter == 'b'){
        return playzone_width/3;
    }
    else if(letter == 'a'){
        return (playzone_width/3) * 2;
    }
    else{
        return 0;
    }
}

function clearCanvas() {
	var canvas = getCanvas();
	var context = getContext(canvas);
	context.clearRect(0, 0, canvas.width, canvas.height);
	var w = canvas.width;
	canvas.width = 1;
	canvas.width = w;
	context.fillStyle = '#dedede';		  	
	context.fillRect(0, 0, playzone_width, playzone_width);			
	drawPlaygroundLines(context);	
	drawCrossAndRound();
}
