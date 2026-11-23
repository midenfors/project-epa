extends Control

const MAIN_MENU := "res://Scenes/UI/main_menu.tscn"

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFX_Slider
@onready var fullscreen_check: CheckButton = %FullscreenCheck

func _ready() -> void:
	# Show the current values so settings stick when coming back to this screen.
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))) * 100.0
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))) * 100.0
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))) * 100.0
	fullscreen_check.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	
	master_slider.value_changed.connect(_on_master_vol_changed)
	music_slider.value_changed.connect(_on_music_vol_changed)
	sfx_slider.value_changed.connect(_on_sfx_vol_changed)
	
	fullscreen_check.toggled.connect(_on_fullscreen_toggled)
	%Back.pressed.connect(_on_back_pressed)


func _on_master_vol_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value / 100.0))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), value <= 0.0)
	
func _on_music_vol_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value / 100.0))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), value <= 0.0)

func _on_sfx_vol_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value / 100.0))
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), value <= 0.0)


func _on_fullscreen_toggled(on: bool) -> void:
	if on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_pressed() -> void:
	self.queue_free()
