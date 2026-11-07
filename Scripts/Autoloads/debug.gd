extends Node


func _input(_event: InputEvent) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_quit"):
			get_tree().quit()
	
	if Input.is_key_label_pressed(KEY_0):
		Global.snus_counter += 1
	if Input.is_key_label_pressed(KEY_PLUS):
		Global.poppys += 1
	
