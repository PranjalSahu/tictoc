var current = 0
var size = 4
var squaresize = 8
var alreadydrawn = []
var board = {}

for(i=0;i<size;++i){
	board[i]    = {}
	for(j=0;j<size;++j){
		board[i][j] = "-";
	}
}


window.onload = function() {
};

function drawCircle(divid, color) {
  var c   = document.getElementById(divid);
	var ctx = c.getContext("2d");
	if (color == 'blue'){
		ctx.font="120px Georgia";
		ctx.fillText("X",40,120);	
	}else{
		ctx.beginPath();
		ctx.arc(80, 80, 50, 0, 2 * Math.PI);
		ctx.fillStyle = color;
		ctx.strokeStyle = color;
		ctx.lineWidth  = 20
		ctx.stroke();
		//ctx.fill();
	}
}

function get_board_data() {
	arr = []
	for(i=0;i<size;++i){
		for(j=0;j<size;++j){
			arr.push(board[i][j]);
		}
	}
	return arr.join(",")
}

function get_moves(){
	url    = "http://localhost:5000/handle_move?current_state="
	params  = get_board_data()
	var xhReq = new XMLHttpRequest();
 	xhReq.open("GET", url+params, false);
 	xhReq.send(null);
 	var serverResponse = xhReq.responseText;
	return JSON.parse(serverResponse)
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

    		num = parseInt(e.target.id.slice(8, 15))
    		row = parseInt(num/size)
    		board[row][num-row*size] = "0"
    		alreadydrawn.push(e.target.id)
    		current = current + 1

    		var move = get_moves()

    		if (move["status"] == "Won") {
    			alert("WON")
    		}
    		else if(move["status"] == "Draw"){
    			alert("DRAW")
    		}
    		else {
					res = move["delta"]
    			board[res[0]][res[1]] = "1"
    			str = (res[0]*size+res[1]).toString()
    			
    			color = "blue"
    			if (current%2 == 0) {
    				color = "blue"
    			}
    			else {
    				color = "red"
    			}

    			drawCircle("myCanvas"+str, color)
    			current = current+1
    		}

    });
})