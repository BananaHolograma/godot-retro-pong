extends Node2D

@onready var viewport: Rect2 = get_viewport().get_visible_rect()

@onready var top_boundary: CollisionShape2D = %TopBoundary
@onready var bottom_boundary: CollisionShape2D = %BottomBoundary

@onready var player_one_score_label: Label = %PlayerOneScore
@onready var player_two_score_label: Label = %PlayerTwoScore

@onready var ball = $Ball as Ball

var player_one
var player_two
var player_one_score := 0
var player_two_score := 0

var player_scene := preload("res://player/player.tscn")


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	_add_players()
	_prepare_scoreboard()
	_build_boundaries()
	
	ball.boundary_limit.connect(on_ball_boundary_limit)
	ball.spawn()


func _draw():
	draw_dashed_line(Vector2(viewport.size.x / 2, 0), Vector2(viewport.size.x / 2 , viewport.size.y), Color.BEIGE, 3.0, 10.0)
	
	
func _add_players() -> void:
	for position in GameSettings.PLAYERS.keys():
		var player_instance = player_scene.instantiate() as Player
		player_instance.PLAYABLE = GameSettings.PLAYERS[position].playable
		player_instance.side = GameSettings.SIDES.LEFT if position == "one" else  GameSettings.SIDES.RIGHT
		player_instance.inputs = GameSettings.PLAYERS[position].inputs 
		add_child(player_instance)
	
	
func _prepare_scoreboard() -> void:
	player_one_score_label.global_position = Vector2(viewport.size.x / 3, 0)
	player_two_score_label.global_position = Vector2(viewport.size.x - viewport.size.x / 3, 0)
	
	player_one_score_label.text = str(player_one_score)
	player_two_score_label.text = str(player_two_score)


func _build_boundaries() -> void:
	top_boundary.global_position = Vector2(viewport.size.x / 2, 0)
	top_boundary.shape.size.x = viewport.size.x
	top_boundary.shape.size.y = 5.0
	
	bottom_boundary.global_position = Vector2(viewport.size.x / 2, viewport.size.y)
	bottom_boundary.shape.size.x = viewport.size.x
	bottom_boundary.shape.size.y = 5.0
	

func on_ball_boundary_limit(side: int) -> void:
	if side == 1:
		player_one_score += 1
		player_one_score_label.text =  str(player_one_score)
	else:
		player_two_score += 1
		player_two_score_label.text =  str(player_two_score)
