extends Node

enum SIDES {
	LEFT,
	RIGHT
}

@export var inputs: Dictionary = {
	SIDES.LEFT: ["arrow_up", "arrow_down"],
	SIDES.RIGHT: ["ui_up", "ui_down"]
}


@export var PLAYERS = {
	"one": {
		"playable": true,
		"inputs": inputs[SIDES.LEFT]
	},
	"two": {
		"playable": false,
		"inputs": inputs[SIDES.RIGHT]
	}
}

@export var RETRO_EFFECT_SHADER := true
