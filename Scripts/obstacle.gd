extends Area2D

@export var speed_reduce = 500;

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		body.speed = clamp((body.speed - speed_reduce), 0, 10000)
		if body.speed == 0:
			body.speed = 20
		queue_free()
