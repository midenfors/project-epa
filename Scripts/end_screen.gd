extends Control

func _on_tow_home_btn_pressed() -> void:
	get_tree().paused = false
	hide()
	get_tree().reload_current_scene()
