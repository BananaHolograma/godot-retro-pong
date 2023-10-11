class_name Ball extends CharacterBody2D

signal boundary_limit

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var viewport: Rect2 = get_viewport().get_visible_rect()
@onready var ball_collision: AudioStreamPlayer2D = $BallCollision
@onready var ball_outside: AudioStreamPlayer2D = $BallOutside


var INITIAL_SPEED := 12.5
var COLLISION_SPEED_MULTIPLIER := 1.05
var direction := Vector2.LEFT

var current_speed = INITIAL_SPEED


func _ready():
	boundary_limit.connect(on_boundary_limit_reached)


func _physics_process(delta):
	var collision = move_and_collide(velocity * current_speed * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * COLLISION_SPEED_MULTIPLIER
		ball_collision.play()
	out_of_boundaries_detector()

	
func _draw():
	var draw_origin_position = Vector2(-collision_shape_2d.shape.size.x / 2, -collision_shape_2d.shape.size.y / 2)
	draw_rect(Rect2(draw_origin_position, collision_shape_2d.shape.size), Color.BEIGE)


func spawn() -> void:
	global_position = Vector2(viewport.size.x / 2 , randi_range(collision_shape_2d.shape.size.y, viewport.size.y - collision_shape_2d.shape.size.y))
	
	var random_direction: Vector2 = [Vector2.RIGHT, Vector2.LEFT][randi_range(0 ,1)]
	random_direction.y = [-0.8, 0.8][randi_range(0 ,1)]
	
	velocity = random_direction * INITIAL_SPEED
	
	show()


func out_of_boundaries_detector() -> void:
	if visible and (global_position.x < 0 or global_position.x > viewport.size.x):
		boundary_limit.emit(1 if global_position.x < 0 else 2)


func on_boundary_limit_reached(_side: int) -> void:
	ball_outside.play()
	hide()
	await (get_tree().create_timer(1.0)).timeout
	spawn()
