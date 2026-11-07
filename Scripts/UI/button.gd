extends Button
@export var button = "res://Scenes/world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	get_tree().change_scene_to_file(button)
