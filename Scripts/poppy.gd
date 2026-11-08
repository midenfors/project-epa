extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# +1 extra poppy per Poppy Power level
		Global.increase_poppy(1 + Global.poppy_power_upgrades)
		queue_free()
