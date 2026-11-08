class_name Tachometer
extends Control

const MIN_ANGLE := -110.0
const MAX_ANGLE := 110.0
const ANGLE_SPAN := MAX_ANGLE - MIN_ANGLE

@export var arrow : Sprite2D
@export var smoothing : float = 8.0 # Högre = snabbare pil

var target_degrees : float = MIN_ANGLE

func _ready() -> void:
	arrow = $Arrow
	arrow.rotation_degrees = MIN_ANGLE

# Pilen rör sig mjukt mot målvinkeln varje frame
func _process(delta: float) -> void:
	arrow.rotation_degrees = lerpf(arrow.rotation_degrees, target_degrees, 1.0 - exp(-smoothing * delta))

# Nollställer till noll på mätaren
func set_arrow_to_zero():
	target_degrees = MIN_ANGLE

# Sätter pilens målvinkel
func set_arrow_to_degrees(value):
	target_degrees = clampf(value, MIN_ANGLE, MAX_ANGLE)

# Set gauge value [0, 1]
func set_rpm(value):
	set_arrow_to_degrees(MIN_ANGLE + value * ANGLE_SPAN)
