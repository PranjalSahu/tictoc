var current = 0
var size = 3
var squaresize = 8
var alreadydrawn = []

window.onload = function() {
};

function drawCircle(divid, color) {
  var c   = document.getElementById(divid);
	var ctx = c.getContext("2d");
	ctx.beginPath();
	ctx.arc(80, 80, 50, 0, 2 * Math.PI);
	ctx.stroke();
	ctx.fillStyle = color;
	ctx.fill();
}

$(function() {
    $("body").click(function(e) {
    	  if (alreadydrawn.includes(e.target.id))
    	  	return;
    	  if (current%2 == 0) {
    			drawCircle(e.target.id, "blue")
    		}
    		else {
    			drawCircle(e.target.id, "red")
    		}
    		alreadydrawn.push(e.target.id)
    		current = current + 1
    });
})