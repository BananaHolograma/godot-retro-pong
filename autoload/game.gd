extends Node

enum SIDES {
	LEFT,
	RIGHT
}

var inputs: Dictionary = {
	SIDES.LEFT: ["arrow_up", "arrow_down"],
	SIDES.RIGHT: ["ui_up", "ui_down"]
}


var PLAYERS = {
	"one": {
		"playable": true,
		"inputs": inputs[SIDES.LEFT]
	},
	"two": {
		"playable": false,
		"inputs": inputs[SIDES.RIGHT]
	}
}
