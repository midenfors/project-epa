extends Node

func _input(event: InputEvent) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_quit"):
			get_tree().quit()
