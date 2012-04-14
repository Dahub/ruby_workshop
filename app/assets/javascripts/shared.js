function relMouseCoords(canvas, event){
    var x, y;
    canoffset = canvas.offset();
    x = event.clientX + document.body.scrollLeft + document.documentElement.scrollLeft - Math.floor(canoffset.left);
    y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop - Math.floor(canoffset.top) + 1;
    return {posX:x,posY:y};
}

function getContext(canvas){	
	if (canvas && canvas.getContext) {
		var context = canvas.getContext('2d');
		if (context) {	
			return context;
		}
	}
}
