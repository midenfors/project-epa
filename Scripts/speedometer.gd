extends Control

@onready var arrow = $Arrow

func _ready() -> void:
	set_arrow_to_zero()

func set_arrow_to_zero():
	arrow.rotation_degrees = -110
