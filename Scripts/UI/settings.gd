extends Control

const MAIN_MENU := "res://Scenes/UI/main_menu.tscn"

@onready var volume_slider: HSlider = %VolumeSlider
@onready var fullscreen_check: CheckButton = %FullscreenCheck


func _ready() -> void:
	# Show the current values so settings stick when coming back to this screen.
	volume_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0)) * 100.0
	fullscreen_check.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

	volume_slider.value_changed.connect(_on_volume_changed)
	fullscreen_check.toggled.connect(_on_fullscreen_toggled)
	%Back.pressed.connect(_on_back_pressed)


func _on_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value / 100.0))
	AudioServer.set_bus_mute(0, value <= 0.0)


func _on_fullscreen_toggled(on: bool) -> void:
	if on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_MENU)
