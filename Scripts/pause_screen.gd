extends Control

@export var paused : bool = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause_screen()

func _on_resume_btn_pressed() -> void:
	toggle_pause_screen()

func _on_menu_btn_pressed() -> void:
	toggle_pause_screen()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func toggle_pause_screen():
	if visible:
		hide()
		unpause()
	else:
		show()
		pause()

func pause():
	paused = true
	get_tree().paused = true
func unpause():
	paused = false
	get_tree().paused = false
