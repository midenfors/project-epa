extends Resource
class_name Upgrade

@export var id: StringName # ID name. Leave empty to use the file name (snus.tres -> "snus")
@export var name :String = "NONAME" # Display Name
@export var description: String = "Lorem ipsum..." # Description for the upgrade
@export var base_cost : int = 1   # Price of the first purchase
@export var cost_increase : float = 1.5  # Price is multiplied by this after each purchase
@export var amount : int = 1         # Levels gained per purchase
@export var max_level : int = 10     # Max level for the upgrade
@export var icon : Texture2D = load("res://Assets/godot_icon.svg") # The icon for the upgrade (sets godot icon for defualt)

# Get id of upgrade
func get_id() -> String:
	if id != &"":
		return id
	return resource_path.get_file().get_basename()

# Returns level amount
func get_level() -> int:
	return Global.get_upgrade_level(get_id())

# Check if amount is maxed out
func is_maxed() -> bool:
	return get_level() >= max_level

# Price of the next purchase.
func get_cost() -> int:
	return roundi(base_cost * pow(cost_increase, get_level()))

# Check if you can buy next level
func can_buy(poppys: int = Global.poppys) -> bool:
	return not is_maxed() and poppys >= get_cost()

# Pays for and applies one purchase. Returns false if it couldn't be bought.
func buy() -> bool:
	if not can_buy():
		return false
	Global.poppys -= get_cost()
	Global.add_upgrade_level(get_id(), mini(amount, max_level - get_level()))
	return true
