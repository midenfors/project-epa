extends Area2D

@export var speed_reduce = 500;

var audio_manager : AudioManager

func _ready() -> void:
	audio_manager = get_node("../../../AudioManager")
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var car : Car = body as Car
		audio_manager.play_sfx(audio_manager.CRASCH_EPA)
		body.speed = clamp((body.speed - speed_reduce * car.obstacle_slowdown_modifier), 0, Global.speed_limmit)
		if body.speed == 0:
			body.speed = 20
		queue_free()
