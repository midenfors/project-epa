extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var car : Car = body as Car
	car.in_mud = true

func _on_body_exited(body: Node2D) -> void:
	var car : Car = body as Car
	car.in_mud = false
