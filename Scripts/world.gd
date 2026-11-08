extends Node
var road_scene = load("res://Scenes/road.tscn")
@onready var car : Car = $Car
@onready var hud = $CanvasLayer/HUD
var current_roads = {}
var key = 0

func _ready() -> void:
	add_road()
	add_road()

func _process(_delta: float) -> void:
	#check end of run state
	if car.speed == 0 and car.car_started_motion:
		hud.show_end_state()

func _on_grass_area_body_entered(body: Node2D) -> void:
	var _car : Car = body as Car
	_car.on_grass = true
	pass # Replace with function body.

func _on_grass_area_body_exited(body: Node2D) -> void:
	var _car : Car = body as Car
	_car.on_grass = false
	pass # Replace with function body.

func add_road() -> void:
	var road_parent = find_child("RoadParent")
	var road = road_scene.instantiate()
	road.position = road_parent.position
	add_child(road)
	key = key + 1
	current_roads.set(key, road);
	if key > 3:
		var free = current_roads[1]
		if free:
			free.queue_free()
		for roads in range(2, 3+1):
			current_roads[roads-1] = current_roads[roads]
		key = key - 1
	find_child("RoadCaller").position = road_parent.position
	road_parent.position = road.position + road.find_child("End").position


func _on_area_2d_body_exited(_body: Node2D) -> void:
	call_deferred("add_road")
