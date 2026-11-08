extends CharacterBody2D
@onready var hud = $"../../../CanvasLayer/HUD"

@export var speed = 100000;

var audio_manager : AudioManager

func _ready() -> void:
	audio_manager = get_node("../../../AudioManager")

func _process(delta: float) -> void:
	velocity = Vector2(speed * delta, 0)
	move_and_slide()
	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		audio_manager.play_sfx(audio_manager.CRASCH_EPA)
		hud.show_end_state()
		queue_free()
