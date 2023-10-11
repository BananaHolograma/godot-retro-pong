extends CanvasLayer


func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = !visible
		visible = !visible

		
func _on_back_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")
