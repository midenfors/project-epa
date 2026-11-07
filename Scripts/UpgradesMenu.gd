extends Control

var upgrade_container_scene = load("res://Scenes/UI/upgrade_container.tscn") as PackedScene
@onready var upgrades_container = $MarginContainer/ScrollContainer/VBoxContainer

var upgrade_list = [
"res://Resources/Upgrades/snus.tres", 
"res://Resources/Upgrades/poppy_power.tres", 
"res://Resources/Upgrades/engine.tres"

]

func _ready() -> void:
	var children = upgrades_container.get_children()
	for child in children:
		child.queue_free()

	for path in upgrade_list:
		var container = upgrade_container_scene.instantiate()
		container.upgrade = load(path) as Upgrade  # assign as upgrade
		upgrades_container.add_child(container)
