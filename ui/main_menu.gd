extends Control

@onready var one_player_button: Button = %OnePlayerButton
@onready var two_players_button: Button = %TwoPlayersButton
@onready var quit_button: Button = %QuitButton


var game_scene := preload("res://playing_field.tscn")


func _ready():
	one_player_button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()


func _on_one_player_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_two_players_button_pressed():
	GameSettings.PLAYERS["two"]["playable"] = true
	get_tree().change_scene_to_packed(game_scene)
