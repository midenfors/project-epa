extends Node

func _ready() -> void:
	pass 

func _on_grass_area_body_entered(body: Node2D) -> void:
	var car : Car = body as Car
	car.on_grass = true
	pass # Replace with function body.

func _on_grass_area_body_exited(body: Node2D) -> void:
	var car : Car = body as Car
	car.on_grass = false
	pass # Replace with function body.
