extends CharacterBody2D

@export var speed : float = 1000
@export var steering_speed : float = 500

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	var input_throttle = Input.get_axis("Break", "Gas")
	var input_steering = Input.get_axis("Turn Left", "Turn Right")
	
	velocity.x = input_throttle * speed
	velocity.y = input_steering * steering_speed
	
	move_and_slide()
