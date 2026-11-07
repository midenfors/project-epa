extends Control
class_name Speedometer

@export var arrow : Sprite2D

func _ready() -> void:
	arrow = $Arrow
	set_arrow_to_zero()

# Nollställer till noll på mätaren
func set_arrow_to_zero():
	arrow.rotation_degrees = -110

# Sätter pilens rotering gradvis
func set_arrow_to_degrees(value):
	arrow.rotation_degrees = value
