window.onload = function() {
	drawCircle("myCanvasa", "blue")
 //  var c   = document.getElementById("myCanvasa");
	// var ctx = c.getContext("2d");
	// ctx.beginPath();
	// ctx.arc(80, 80, 50, 0, 2 * Math.PI);
	// ctx.stroke();
	// ctx.fillStyle = "blue";
	// ctx.fill();
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
    		drawCircle(e.target.id, "blue")
    });
})