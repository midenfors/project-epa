extends Control

func _ready() -> void:
	update_text()

func update_text():
	$MarginContainer/VBoxContainer/Stats.text = "Poppys: " + str(Global.poppys)+ "\nKilometers driven: " + str(int(Global.distance) / 3960)

func _on_tow_home_btn_pressed() -> void:
	get_tree().paused = false
	hide()
	get_tree().reload_current_scene()
