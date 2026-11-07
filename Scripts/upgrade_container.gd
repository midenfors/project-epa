extends Control

@export var upgrade : Upgrade

func _ready() -> void:
	if upgrade:
		$HBoxContainer/TextureRect.texture = upgrade.icon
		$HBoxContainer/VBoxContainer/Title.text = upgrade.name
		$HBoxContainer/VBoxContainer/Description.text = upgrade.description
