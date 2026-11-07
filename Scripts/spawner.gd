extends Node

var poppy_scene = load("res://Scenes/poppy.tscn")
var obstacle_scene = load("res://Scenes/box.tscn")
var rng = RandomNumberGenerator.new()
var poppy_amount = 6
var obstacle_amount = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#poppy spawner
	for i in range(poppy_amount):
		var poppy = poppy_scene.instantiate()
		poppy.position = Vector2(floor(rng.randf()*(6-3)+4) * 1080-540, rng.randf()*3960) + get_parent().position
		add_child(poppy)
	#obstacle spawner
	for i in range(obstacle_amount):
		var obstacle = obstacle_scene.instantiate()
		obstacle.position = Vector2(floor(rng.randf()*(9-0)+1) * 1080-540, rng.randf()*3960) + get_parent().position
		add_child(obstacle)
	#special spawner
