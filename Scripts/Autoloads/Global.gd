extends Node

var poppys : int = 0
var snus_counter : int = 3
var snus_upgrades : int = 0
var poppy_power_upgrades : int = 0
var engine_upgrades : int = 0


func increase_poppy(amount):
	poppys += amount

func get_upgrade_level(id: String) -> int:
	var level = get(id + "_upgrades")
	if level == null:
		push_error("Global has no variable '%s_upgrades'" % id)
		return 0
	return level

func add_upgrade_level(id: String, levels: int) -> void:
	set(id + "_upgrades", get_upgrade_level(id) + levels)
