extends Control

@export var speedometer : Speedometer
@export var pause : Control

func _ready() -> void:
	speedometer = $Speedometer
	pause = $PauseScreen
