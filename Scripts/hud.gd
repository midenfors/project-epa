extends Control

@export var speedometer : Speedometer
@export var pause : Control
@export var poppy_label : Label

func _ready() -> void:
	speedometer = $Speedometer
	pause = $PauseScreen
	poppy_label = $Dashboard/PoppyCountLabel
	
	update_poppy_label()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Upgrades"):
		if not $Dashboard/UpgradeMenu.visible:
			show_upgrades()
		else:
			hide_upgrades()

func update_poppy_label() -> void:
	poppy_label.text = ": " + str(Global.poppys)

func _process(_delta: float) -> void:
	update_poppy_label()

func show_upgrades() -> void:
	$Dashboard/UpgradeMenu.show()

func hide_upgrades() -> void:
	$Dashboard/UpgradeMenu.hide()
