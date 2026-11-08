extends Node

var poppy_scene = load("res://Scenes/poppy.tscn")
var box_scene = load("res://Scenes/large_box.tscn")
var sign_scene = load("res://Scenes/sign.tscn")
var mud_scene = load("res://Scenes/mud.tscn")

var rng = RandomNumberGenerator.new()
var poppy_amount = 6
var box_amount = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(poppy_amount):
		var poppy = poppy_scene.instantiate()
		poppy.position = Vector2(float(i) / poppy_amount * 3960, rng.randf_range(-100, 200)) + get_parent().position
		add_child(poppy)
	

func milestone(km_left: int):
	var sign = sign_scene.instantiate()
	sign.position = Vector2(1800, -250) + get_parent().position
	sign.get_node(str(km_left) + "km").set_visible(true)
	add_child(sign)
	

func box_terrain():
	for i in range(box_amount):
		var box = box_scene.instantiate()
		box.position = Vector2(float(i) / box_amount * 3960, rng.randf_range(-150, 250)) + get_parent().position
		add_child(box)
		
func mud_terrain():
	var mud = mud_scene.instantiate()
	mud.position = Vector2(0.5 * 3960, 50) + get_parent().position
	add_child(mud)

func driver():
	var a
