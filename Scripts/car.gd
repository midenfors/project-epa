class_name Car
extends CharacterBody2D

@export var speed : float = 250
@export var steering_speed : float = 200

var on_grass : bool = false

var speedometer : Speedometer

func _ready() -> void:
	speedometer = get_node("../CanvasLayer/HUD/Speedometer")
	
	
func _physics_process(_delta: float) -> void:
	
	var throttle_modifier : float = 1.0
	if on_grass:
		throttle_modifier *= 0.5
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
	
	var input_throttle = Input.get_axis("Break", "Gas") * throttle_modifier
	var input_steering = Input.get_axis("Turn Left", "Turn Right")
	
	if input_throttle > 0:
		speedometer.set_arrow_to_degrees(-75)
	else:
		speedometer.set_arrow_to_zero()
	
	velocity.x = input_throttle * speed
	velocity.y = input_steering * steering_speed
	
	move_and_slide()
