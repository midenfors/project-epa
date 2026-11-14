extends Control

const LIGHT_ON := preload("res://Assets/Art/UpgradeLight_BG_On.png")
const LIGHT_OFF := preload("res://Assets/Art/UpgradeLight_BG_Off.png")
const LIGHT_TOP := preload("res://Assets/Art/UpgradeLight_Top.png")

@export var upgrade : Upgrade

@onready var cost_label: Label = %CostAmount
@onready var buy_button: Button = %BuyButton
@onready var lights: HBoxContainer = %Lights

func _ready() -> void:
	if not upgrade:
		return
	%Icon.texture = upgrade.icon
	%Title.text = upgrade.name
	%Description.text = upgrade.description
	buy_button.pressed.connect(_on_buy_pressed)
	_make_lights()
	_refresh()

func _process(_delta: float) -> void:
	# Poppys can change at any time, so keep the button state current.
	if upgrade and is_visible_in_tree():
		_refresh()

# One light per level, with the top overlay drawn over it.
func _make_lights() -> void:
	for i in upgrade.max_level:
		var light := TextureRect.new()
		light.texture = LIGHT_OFF
		var top := TextureRect.new()
		top.texture = LIGHT_TOP
		light.add_child(top)
		lights.add_child(light)

func _refresh() -> void:
	cost_label.text = "MAX" if upgrade.is_maxed() else str(upgrade.get_cost())
	buy_button.disabled = not upgrade.can_buy()
	var level := upgrade.get_level()
	for i in lights.get_child_count():
		lights.get_child(i).texture = LIGHT_ON if i < level else LIGHT_OFF

func _on_buy_pressed() -> void:
	upgrade.buy()
	var car : Car = get_node("../../../../Car")
	car.update_visuals()
	_refresh()
	Global.force_upgrade_menu = true
	
