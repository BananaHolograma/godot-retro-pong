extends Control

@onready var one_player_button: Button = %OnePlayerButton
@onready var two_players_button: Button = %TwoPlayersButton
@onready var quit_button: Button = %QuitButton
@onready var enable_retro_button: CheckButton = %EnableRetroButton
@onready var retro_effect: ColorRect = $RetroEffect


var game_scene := preload("res://playing_field.tscn")


func _ready():
	one_player_button.grab_focus()
	enable_retro_button.button_pressed = GameSettings.RETRO_EFFECT_SHADER
	retro_effect.visible = GameSettings.RETRO_EFFECT_SHADER
	
	RenderingServer.set_default_clear_color(Color(0.3, 0.3, 0.3, 1))

func _on_quit_button_pressed():
	get_tree().quit()


func _on_one_player_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_two_players_button_pressed():
	GameSettings.PLAYERS["two"]["playable"] = true
	get_tree().change_scene_to_packed(game_scene)


func _on_enable_retro_button_pressed():
	GameSettings.RETRO_EFFECT_SHADER = enable_retro_button.button_pressed
	retro_effect.visible = GameSettings.RETRO_EFFECT_SHADER
