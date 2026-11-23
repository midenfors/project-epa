extends Button
@export var button = "res://Scenes/world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(button)

const SETTINGS = preload("uid://cds3j2kei57o7")
	
func _on_settings_pressed() -> void:
	var settings_node = SETTINGS.instantiate()
	get_tree().get_root().add_child(settings_node)


func _on_quit_pressed() -> void:
	get_tree().quit()
