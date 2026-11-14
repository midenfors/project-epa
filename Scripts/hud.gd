extends Control

@export var speedometer : Speedometer
@export var tachometer : Tachometer
@export var pause : Control
@export var poppy_label : Label
@onready var end_screen: Control = $EndScreen

@onready var distance_label: Label = $Dashboard/DistanceLabel

@onready var joystick : VirtualJoystick = $VirtualJoystick

func _ready() -> void:
	speedometer = $Dashboard/Gauges/Speedometer
	tachometer = $Dashboard/Gauges/Tachometer
	pause = $PauseScreen
	poppy_label = $Dashboard/PoppyCounter/HBoxContainer/PoppyCountLabel
	
	# Hide joystick on dekstop
	if not OS.has_feature("android") or OS.has_feature("ios"):
		joystick.hide()
	
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
	update_distance_label()

func update_distance_label():
	distance_label.text = "KM driven: " + str(int(Global.distance) / 3960)

func show_upgrades() -> void:
	$Dashboard/UpgradeMenu.show()

func hide_upgrades() -> void:
	$Dashboard/UpgradeMenu.hide()
	
func show_end_state() -> void:
	end_screen.update_text()
	$EndScreen.show()
	get_tree().paused = true

func hide_end_state() -> void:
	$EndScreen.hide()
	get_tree().paused = false

func _on_upgrade_button_pressed() -> void:
	show_upgrades()
	$Dashboard/UpgradeButton.hide()


func _on_close_upgr_button_pressed() -> void:
	hide_upgrades()
	$Dashboard/UpgradeButton.show()
	get_tree().reload_current_scene()

func _on_cheat_button_pressed() -> void:
	Global.increase_poppy(50)

func _on_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func show_win_screen() -> void:
	$WinScreen.show()
