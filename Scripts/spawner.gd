extends Node

var poppy_scene = load("res://Scenes/poppy.tscn")
var obstacle_scenes = load("res://Scenes/box.tscn")
var rng = RandomNumberGenerator.new()
var poppy_amount = 6
var obstacle_amount = 20
#floor(rng.randf()*(6-3)+4) * 108-540

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#poppy spawner
	for i in range(poppy_amount):
		var poppy = poppy_scene.instantiate()
		poppy.position = Vector2(float(i) / poppy_amount * 3960, rng.randf_range(-100, 200)) + get_parent().position
		add_child(poppy)
	#obstacle spawner
	for i in range(obstacle_amount):
		var obstacle = obstacle_scenes.instantiate()
		obstacle.position = Vector2(rng.randf()*3960, floor(rng.randf()*(9-0)+1) * 1080-540) + get_parent().position
		add_child(obstacle)
	#special spawner
