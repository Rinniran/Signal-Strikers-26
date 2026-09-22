extends Control

func _unhandled_input(event: InputEvent) -> void:
	#gonna be lazy abt this for now
	if Input.is_action_just_pressed("ui_accept"): get_tree().change_scene_to_file("res://Scene/UI/SplitscreenDisplay.tscn")
