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
	arrow.rotation_degrees = clamp(value, -110, 110)

func set_speed(value):
	var angle = -110 + value
	set_arrow_to_degrees(-110 + value)
