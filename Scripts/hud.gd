extends Control

@export var speedometer : Speedometer
@export var tachometer : Tachometer
@export var pause : Control
@export var poppy_label : Label

func _ready() -> void:
	speedometer = $Dashboard/Gauges/Speedometer
	tachometer = $Dashboard/Gauges/Tachometer
	pause = $PauseScreen
	poppy_label = $Dashboard/PoppyCounter/PoppyCountLabel
	
	update_poppy_label()
	
	if Global.force_upgrade_menu:
		$Dashboard/UpgradeMenu.visible = true
		Global.force_upgrade_menu = false
	else:
		$Dashboard/UpgradeMenu.visible = false
	

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Upgrades"):
		if not $Dashboard/UpgradeMenu.visible:
			show_upgrades()
		else:
			hide_upgrades()
			get_tree().reload_current_scene()

func update_poppy_label() -> void:
	poppy_label.text = ": " + str(Global.poppys)

func _process(_delta: float) -> void:
	update_poppy_label()

func show_upgrades() -> void:
	$Dashboard/UpgradeMenu.show()

func hide_upgrades() -> void:
	$Dashboard/UpgradeMenu.hide()
	
func show_end_state() -> void:
	$EndScreen.show()
	get_tree().paused = true

func hide_end_state() -> void:
	$EndScreen.hide()
	get_tree().paused = false
