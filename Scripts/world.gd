extends Node2D

@onready var car = $Car;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	car.velocity = -100 * car.global_transform.y
	car.move_and_slide()
	pass
