extends Control

@export var upgrade : Upgrade

@onready var cost_label: Label = $HBoxContainer/VBoxContainer2/CostAmount
@onready var buy_button: Button = $HBoxContainer/Button

func _ready() -> void:
	if not upgrade:
		return
	$HBoxContainer/TextureRect.texture = upgrade.icon
	$HBoxContainer/VBoxContainer/Title.text = upgrade.name
	$HBoxContainer/VBoxContainer/Description.text = upgrade.description
	buy_button.pressed.connect(_on_buy_pressed)
	_refresh()

func _process(_delta: float) -> void:
	# Poppys can change at any time, so keep the button state current.
	if upgrade and is_visible_in_tree():
		_refresh()

func current_cost() -> int:
	return upgrade.upgrade_cost + upgrade.cost_increase * Global.get_upgrade_level(upgrade.get_id())

func _refresh() -> void:
	cost_label.text = str(current_cost())
	buy_button.disabled = Global.poppys < current_cost()

func _on_buy_pressed() -> void:
	var cost := current_cost()
	if Global.poppys < cost:
		return
	Global.poppys -= cost
	Global.add_upgrade_level(upgrade.get_id(), upgrade.amount)
	_refresh()
