var draughts_playzone_width = 500;
var playground;
var selected_case = 0;
var possible_move_cases = new Array();

function initDraughtsCanvas(pg){
    playground= pg.split('#'); 
    canvas.addEventListener('mousedown', draughtsClicAppends, false);
    clearDraughtCanvas();   
}

function clearDraughtCanvas(){
    var canvas = $('#canvas')[0];
	var context = getContext(canvas);
	context.clearRect(0, 0, canvas.width, canvas.height);
	var w = canvas.width;
	canvas.width = 1;
	canvas.width = w;
    drawAllPiece(context);	
    drawSelectedCase(context);   
    drawPossibleMove(context); 
}

function drawPossibleMove(context){
    for(var i = 0;i<possible_move_cases.length;i++){    
        highlightDraugthCase(context, possible_move_cases[i],"rgba(0, 255, 0, 0.8)");
    }
}

function drawSelectedCase(context){
    if(selected_case > 0){
        highlightDraugthCase(context, selected_case,"rgba(113, 201, 252, 0.8)");
    }
}

function highlightDraugthCase(context, caseNumber,color){
    var coords = convertCaseNumberToCoords(caseNumber);
    context.beginPath();
    context.rect(coords.posX, coords.posY, draughts_playzone_width/10, draughts_playzone_width/10);
    context.fillStyle = color;
    context.fill();
    context.lineWidth = 1;
    context.strokeStyle = "black";
    context.stroke();    
}

function drawAllPiece(context){
    var whitePieces = new Array();
    var blackPieces = new Array();
    for(var i = 0; i<playground.length ;i++){
        if(playground[i].substring(0,1) == 'b'){            
            blackPieces[blackPieces.length] = playground[i] + (i + 1);             
        }
        else if(playground[i].substring(0,1) == 'w'){
            whitePieces[whitePieces.length] = playground[i] + (i + 1);    
        }
        drawColoredPieces(context, blackPieces,'/assets/black.png');
        drawColoredPieces(context, whitePieces,'/assets/white.png');
    }    
}

function drawColoredPieces(context, pieces,imagePath){  
	var myImage = new Image();	
    myImage.onload = function() {   
        for(var i = 0;i<pieces.length;i++){         
            var coords = convertCaseNumberToCoords(pieces[i].substring(2,pieces[i].length));         
            context.drawImage(myImage, coords.posX+2, coords.posY+2, 45, 45);
        }
    }
    myImage.src = imagePath;
}

function reset_selected_case(){
    selected_case = 0;
    possible_move_cases = [];
}

function draughtsClicAppends(e){
    var caseNumber = getCaseNumber(e);
    if(possible_move_cases && possible_move_cases.indexOf(caseNumber) > -1){
        $.ajax({
            type: 'POST',
            async: false,
            url: "/draughts/player_move",
            data: "move=" + selected_case + ',-,' + caseNumber,
            success: function(data) {
                 playground= data.split('#');                  
                 reset_selected_case();
            }
        });
    } 
    else if(caseNumber != 0 && playground[caseNumber - 1].substring(0,1) != '_'){
        selected_case = caseNumber;    
        var canvas = $('#canvas')[0];
	    var context = getContext(canvas);
	    
	    $.ajax({
            type: 'POST',
            async: false,
            url: "/draughts/get_possibles_move",
            data: "case_number=" + selected_case,
            success: function(data) {
                possible_move_cases = data.slice();
            }
        });
    }
    else{        
        reset_selected_case();
    }    	
    clearDraughtCanvas();
}

function getCaseNumber(e){
    var canvas = $('#canvas')
    var mousePos = relMouseCoords(canvas,e);
    var caseWidth = draughts_playzone_width/10;
    var x = Math.ceil((mousePos.posX)/caseWidth);
    var y = Math.ceil((mousePos.posY)/caseWidth);    
    if((y%2 == 0 && x%2 != 0) || (y%2 != 0 && x%2 == 0)){
        return Math.ceil(x/2 + (y - 1) * 5);
    }    
    return 0;
}

function convertCaseNumberToCoords(caseNumber){
    var lineNumber = (Math.ceil(caseNumber/5));    
    var toRemoveToX = 0;
    if(lineNumber > 1){
        for(var i = 2;i<=lineNumber;i++){
            if(i%2 == 0){
                toRemoveToX += draughts_playzone_width * 1.1;
            }
            else{
                toRemoveToX += draughts_playzone_width * 0.9;
            }
        }
    }    
    var y = lineNumber * draughts_playzone_width/10 - draughts_playzone_width/10;
    var x = (caseNumber)*draughts_playzone_width/5 - toRemoveToX - draughts_playzone_width/10;
    return {posX:x , posY:y };
}

