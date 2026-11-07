class_name Car
extends CharacterBody2D

@export var speed : float = 1000
@export var steering_speed : float = 500

var on_grass : bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	var throttle_modifier : float = 1.0
	if on_grass: throttle_modifier *= 0.5
	
	var input_throttle = Input.get_axis("Break", "Gas") * throttle_modifier
	var input_steering = Input.get_axis("Turn Left", "Turn Right")
	
	velocity.x = input_throttle * speed
	velocity.y = input_steering * steering_speed
	
	move_and_slide()
