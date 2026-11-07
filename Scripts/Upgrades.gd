extends Resource
class_name Upgrade

@export var icon : Texture2D = load("res://icon.svg")
@export var name :String = "NONAME"
@export var description: String = "Lorem ipsum..."
@export var upgrade_cost : int = 1   # Price of the first purchase
@export var cost_increase : int = 1  # Added to the price after each purchase
@export var amount : int = 1         # Levels gained per purchase

# The file name is the id, e.g. "snus" for snus.tres.
# Global stores the level in a matching "<id>_upgrades" variable.
func get_id() -> String:
	return resource_path.get_file().get_basename()
