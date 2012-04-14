var draughts_playzone_width = 500;
var playground;

function initDraughtsCanvas(pg){
    playground= pg.split('#');
    clearDraughtCanvas();    
    canvas.addEventListener('click', draughtsClicAppends, false);
}

function clearDraughtCanvas(){
    var canvas = $('#canvas')[0];
	var context = getContext(canvas);
	context.clearRect(0, 0, canvas.width, canvas.height);
	var w = canvas.width;
	canvas.width = 1;
	canvas.width = w;
    drawAllPiece();	
}

function drawAllPiece(){
    for(var i = 0; i<playground.length ;i++){
        if(playground[i].substring(0,1) != '_'){
            drawOnePiece(playground[i], i);            
        }
    }
}

function draughtsClicAppends(e){
    var caseNumber = getCaseNumber(e);
}

function getCaseNumber(e){
    var canvas = $('#canvas')
    var mousePos = relMouseCoords(canvas,e);
    var caseWidth = draughts_playzone_width/10;
    var x = Math.ceil((mousePos.posX)/caseWidth);
    var y = Math.ceil((mousePos.posY)/caseWidth)-1;    
    if((y%2 == 0 && x%2 == 0) || (y%2 != 0 && x%2 != 0)){
        return Math.ceil((x + y * 10)/2);
    }    
    return 0;
}

function convertCaseNumberToCoords(caseNumber){
    var lineNumber = (Math.ceil(caseNumber/5));
    
    var toRemoveToX = 0;
    if(lineNumber > 1){
        for(var i = 2;i<=lineNumber;i++){
            if(i%2 == 0){
                toRemoveToX += 550;
            }
            else{
                toRemoveToX += 450;
            }
        }
    }
    
    var y = lineNumber * 50 - 50;
    var x = (caseNumber)*100 - toRemoveToX - 50;

    return {posX:x , posY:y };
}

function drawOnePiece(position, caseNumber){
    var coords = convertCaseNumberToCoords(caseNumber + 1);
    
    var canvas = $('#canvas')[0];
	var context = getContext(canvas);
	
	var myImage = new Image();	
    myImage.onload = function() {            
        context.drawImage(myImage, coords.posX, coords.posY, 50, 50);
    }
    if(position.substring(0,1) == 'b'){
        myImage.src = '/assets/black.png';
    }
    else if(position.substring(0,1) == 'w') {
        myImage.src = '/assets/white.png';
    }
}
