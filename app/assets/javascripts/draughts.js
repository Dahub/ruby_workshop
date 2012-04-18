var draughts_playzone_width = 500;
var playground;
var selected_case = new Array();
var possible_move_cases = new Array();
var blackImage;
var whiteImage;

function initDraughtsCanvas(pg){
    playground= pg.split('#'); 
    canvas.addEventListener('mousedown', draughtsClicAppends, false);
    blackImage = new Image();	
	blackImage.onload = function() { 
		whiteImage = new Image();	
		whiteImage.onload = function() {
			clearDraughtCanvas();
		}
		whiteImage.src = '/assets/white.png';	 
	}
    blackImage.src = '/assets/black.png';	
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
    if(selected_case.length > 0){
        for(var i = 0; i < selected_case.length;i++){
            highlightDraugthCase(context, selected_case[i],"rgba(113, 201, 252, 0.5)");
        }
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
    for(var i = 0; i<playground.length ;i++){       
        if(playground[i].substring(0,1) == 'w'){
			var coords = convertCaseNumberToCoords(i+1);
			context.drawImage(whiteImage, coords.posX+2, coords.posY+2, 45, 45);
		}
		else if(playground[i].substring(0,1) == 'b'){
			var coords = convertCaseNumberToCoords(i+1);
			context.drawImage(blackImage, coords.posX+2, coords.posY+2, 45, 45);
		}
    }    
}

function reset_selected_case(){
    selected_case = [];
    possible_move_cases = [];
}

function draughtsClicAppends(e){
    var caseNumber = getCaseNumber(e);
    showLoadingDiv();
    if(possible_move_cases && possible_move_cases.indexOf(caseNumber) > -1){ 
        var capture = '-';
        var start_case = selected_case[0];
        for(var i = 0;i < selected_case.length; i ++)
        {
            if(Math.abs(selected_case[i] - caseNumber) == 9 || 
                Math.abs(selected_case[i] - caseNumber) == 11 ){
                capture = 'x';
                start_case = selected_case[i]
            }
        }
        $.ajax({
            type: 'POST',
            async: true,
            url: "/draughts/player_move",
            data: "move=" + start_case + ',' + capture + ',' + caseNumber,
            success: function(data) {                   
                playground= data.draughts_playground_data;                  
                reset_selected_case();  
                clearDraughtCanvas();   
                hideLoadingDiv();    
            }
        });
    } 
    else if(caseNumber != 0 && playground[caseNumber - 1].substring(0,1) == 'w'){
        selected_case[0] = caseNumber;    
        var canvas = $('#canvas')[0];
	    var context = getContext(canvas);		    
	    $.ajax({
            type: 'POST',
            async: true,
            url: "/draughts/get_possibles_move",
            data: "case_number=" + selected_case[0],
            success: function(data) {
                possible_move_cases = [];
                for(var i = 0;i<data.length;i++){
                    selected_case[i] = data[i][0];
                    possible_move_cases[possible_move_cases.length] = data[i][2];
                }
                clearDraughtCanvas();   
                hideLoadingDiv();        
            }
        });     
    }
    else{        
        reset_selected_case();
        clearDraughtCanvas();
        hideLoadingDiv();
    }       
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

function showLoadingDiv(){
    $("#draughtsLoadingDiv").removeClass("draught_loading_hidden");
    $("#draughtsLoadingDiv").addClass("draught_loading"); 
}

function hideLoadingDiv(){
    $("#draughtsLoadingDiv").removeClass("draught_loading");
    $("#draughtsLoadingDiv").addClass("draught_loading_hidden"); 
}

