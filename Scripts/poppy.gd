extends Area2D

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("Player"):
			body.audio_manager.play_sfx(body.audio_manager.POPPY_BOTTLE)
		# +1 extra poppy per Poppy Power level
		Global.increase_poppy(1 + Global.poppy_power_upgrades)
		queue_free()
