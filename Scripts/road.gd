extends Node2D

var forest_scene = load("res://Scenes/forest.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var forest = forest_scene.instantiate()
	forest.position = position
	add_child(forest)
