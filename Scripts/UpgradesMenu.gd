extends Control

const UPGRADES_DIR = "res://Resources/Upgrades/"

var EngineMilestones = [2, 5, 10]

var upgrade_container_scene = load("res://Scenes/UI/upgrade_container.tscn") as PackedScene
@onready var upgrades_container = $MarginContainer/ScrollContainer/VBoxContainer

func _ready() -> void:
	for child in upgrades_container.get_children():
		child.queue_free()

	for upgrade in load_upgrades():
		var container = upgrade_container_scene.instantiate()
		container.upgrade = upgrade
		upgrades_container.add_child(container)

# Every .tres file in the upgrades folder becomes a row, sorted by file name.
# list_directory also works in exported builds, unlike DirAccess.
func load_upgrades() -> Array[Upgrade]:
	var upgrades: Array[Upgrade] = []
	var files := Array(ResourceLoader.list_directory(UPGRADES_DIR))
	files.sort()
	for file in files:
		if file.ends_with(".tres"):
			var upgrade := load(UPGRADES_DIR + file) as Upgrade
			if upgrade:
				upgrades.append(upgrade)
	return upgrades
