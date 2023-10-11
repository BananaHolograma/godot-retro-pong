class_name Player extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var viewport: Rect2 = get_viewport().get_visible_rect()
@onready var SPOT_DISTANCE := viewport.size.x / 4
@onready var BALL = get_tree().get_first_node_in_group("ball")


@export var PLAYABLE := true
@export var SPEED = 450.0
@export var side: GameSettings.SIDES
@export var inputs: Array

var direction = Vector2.ZERO


func _ready():
	global_position = Vector2(SPOT_DISTANCE, viewport.size.y / 2) if side == GameSettings.SIDES.LEFT else Vector2(viewport.size.x - SPOT_DISTANCE, viewport.size.y / 2)
	

func _physics_process(delta):
	var axis = Input.get_axis(inputs[0], inputs[1])
	direction = Vector2(0, axis)
	
	if not PLAYABLE:
		_ai_movement(delta)

	velocity = direction * SPEED
	move_and_slide()
		
	_limit_boundaries_position()


func _ai_movement(delta: float = get_physics_process_delta_time()) -> void:
	if BALL:
		var ball_position = BALL.global_position
		
		if ball_position.y >= global_position.y + (collision_shape_2d.shape.size.y / 2 + 8):
			direction = Vector2.DOWN

		elif ball_position.y <= global_position.y + (collision_shape_2d.shape.size.y / 2 - 8):
			direction = Vector2.UP


func _draw():
	var draw_origin_position = Vector2(-collision_shape_2d.shape.size.x / 2, -collision_shape_2d.shape.size.y / 2)
	draw_rect(Rect2(draw_origin_position, collision_shape_2d.shape.size), Color.BEIGE)


func _limit_boundaries_position() -> void:
	global_position.y = clamp(global_position.y, 0 + collision_shape_2d.shape.size.y / 2, viewport.size.y - collision_shape_2d.shape.size.y / 2)
