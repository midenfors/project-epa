extends Node

var poppy_scene = load("res://Scenes/poppy.tscn")
var box_scene = load("res://Scenes/large_box.tscn")
var rng = RandomNumberGenerator.new()
var poppy_amount = 6
var box_amount = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(poppy_amount):
		var poppy = poppy_scene.instantiate()
		poppy.position = Vector2(float(i) / poppy_amount * 3960, rng.randf_range(-100, 200)) + get_parent().position
		add_child(poppy)
	


func box_terrain():
	for i in range(box_amount):
		var box = box_scene.instantiate()
		box.position = Vector2(rng.randf()*3960, rng.randf_range(-150, 250)) + get_parent().position
		add_child(box)
