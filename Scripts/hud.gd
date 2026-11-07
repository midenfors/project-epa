extends Control

@export var speedometer : Speedometer
@export var pause : Control
@export var poppy_label : Label

func _ready() -> void:
	speedometer = $Speedometer
	pause = $PauseScreen
	poppy_label = $Dashboard/PoppyCountLabel
	
	update_poppy_label()

func update_poppy_label() -> void:
	poppy_label.text = "Poppys: " + str(Global.poppys)

func _process(delta: float) -> void:
	update_poppy_label()
