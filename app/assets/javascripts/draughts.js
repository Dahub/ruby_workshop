var playground;
var whiteImage;
var blackImage;
var queenWhiteImage;
var queenBlackImage;
var draughts_playzone_width = 500;
var draughts_case_width = draughts_playzone_width/10;

function initDraughtsCanvas(){
    canvas.addEventListener('mousedown', draughtsClicAppends, false);
    
    my_images = imagesStack;
    my_images.onComplete = function(){
        for(var i = 0;i<my_images.images.length;i++){
            if(my_images.images[i].src.indexOf("/white.png") > -1){
                whiteImage = my_images.images[i];
            }
            else if(my_images.images[i].src.indexOf("/black.png") > -1){
                blackImage = my_images.images[i];
            }
            else if(my_images.images[i].src.indexOf("/queen_white.png") > -1){
                queenWhiteImage = my_images.images[i];
            }
            else if(my_images.images[i].src.indexOf("/queen_black.png") > -1){
                queenBlackImage = my_images.images[i]
            }
        }
        loadPlayground();
    }

    my_images.queue_images(['/assets/white.png',
                            '/assets/black.png',
                            '/assets/queen_white.png',
                            '/assets/queen_black.png']);
    my_images.process_queue(); 
}

function loadPlayground(){
   $.ajax({
        type: 'POST',
        async: true,
        url: "/draughts/get_playground",
        success: function(data) {            
            playground = eval(data);   
            drawDraughtsCanvas();
        }
    }); 
}

function drawDraughtsCanvas(){
    var canvas = $('#canvas')[0];
	var context = getContext(canvas);
	context.clearRect(0, 0, canvas.width, canvas.height);
	var w = canvas.width;
	canvas.width = 1;
	canvas.width = w;
    drawAllPiece(context);	
    hightlightPreselectedCases(context);
    hightlightSelectedCase(context);
    hightlightPossiblesMoves(context);
}

function drawAllPiece(context){             
    for(var i = 0; i<playground.table.length ;i++){   
        var coords = convertCaseNumberToCoords(i+1);    
        if(playground.table[i] == 'w'){			
			context.drawImage(whiteImage, coords.posX, coords.posY, draughts_case_width, draughts_case_width);
		}
		else if(playground.table[i] == 'b'){
			context.drawImage(blackImage, coords.posX, coords.posY, draughts_case_width, draughts_case_width);
		}
		else if(playground.table[i] == 'W'){
		    context.drawImage(queenWhiteImage, coords.posX, coords.posY, draughts_case_width, draughts_case_width);
		}
		else if(playground.table[i] == 'B'){
    		context.drawImage(queenBlackImage, coords.posX, coords.posY, draughts_case_width, draughts_case_width);
		}
    }    
}

function hightlightPreselectedCases(context){
    for(var i = 0;i<playground.preselected_cases.length;i++){
        highlightDraugthCase(context, playground.preselected_cases[i],"rgba(133, 232, 83, 0.4)");
    }
}

function hightlightSelectedCase(context){
    if(playground.selected_case != 0){
        highlightDraugthCase(context, playground.selected_case,"rgba(2, 137, 194, 0.8)");
    }
}

function hightlightPossiblesMoves(context){
    for(var i = 0;i<playground.possibles_moves.length;i++){
        highlightDraugthCase(context, playground.possibles_moves[i],"rgba(0, 255, 0, 0.7)");
    }
}

function draughtsClicAppends(e){
    var caseNumber = getCaseNumber(e);
    if(isInArray(playground.preselected_cases, caseNumber) == true){
        showLoadingDiv();       
        $.ajax({
        type: 'POST',
        async: true,
        url: "/draughts/get_possibles_move",
        data: "case_number=" + caseNumber,
        success: function(data) {           
                playground = eval(data);   
                drawDraughtsCanvas();   
                hideLoadingDiv();        
            }
        });     
    }
    else if(isInArray(playground.possibles_moves, caseNumber) == true){  
        showLoadingDiv();        
        $.ajax({
        type: 'POST',
        async: true,
        url: "/draughts/player_move",
        data: "move=" + buildmove(caseNumber),
        success: function(data) {  
                playground = eval(data);   
                drawDraughtsCanvas();   
                hideLoadingDiv();    
                if(data.game_state != 'none'){  
                    showDraughtEndGame(data.game_state);  
                }    
            }
        });
    }
    else{
        playground.selected_case = '';
        playground.possibles_moves = [];
    }
    drawDraughtsCanvas();
}

function buildmove(caseNumber){
    var middleChar = '?';
    return playground.selected_case + ',' + middleChar + ',' + caseNumber;
}

function isInArray(array, value){    
    for(var i = 0;i<array.length;i++){  
        if(array[i] == value){            
            return true;
        }
    }
    return false;
}


function getCaseNumber(e){
    var canvas = $('#canvas')
    var mousePos = relMouseCoords(canvas,e);
    var x = Math.ceil((mousePos.posX)/draughts_case_width);
    var y = Math.ceil((mousePos.posY)/draughts_case_width);    
    if((y%2 == 0 && x%2 != 0) || (y%2 != 0 && x%2 == 0)){
        return Math.ceil(x/2 + (y - 1) * 5);
    }    
    return 0;
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

function showDraughtEndGame(partyState){
    $("#partyEnd").removeClass("draught_end_party_hidden");
    $("#partyEnd").addClass("draught_end_party");     
    var text = "Draw";
    if(partyState == "player"){
        text = "Player win";
    }
    else if(partyState == "ai"){
        text = "AI win";
    }
    $("#partyEnd").html(text);
}
