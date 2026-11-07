class_name Car
extends CharacterBody2D


# Upgradable
@export var num_speed_boosts : int = 5 		# Number of snus in the bucket
@export var speed_boost : float = 10.0		# Car Booster Upgrade
@export var deceleration : float = -1.0		# Car Engine Upgrade

var steering_speed : float = 3
var speed : float = 0

var on_grass : bool = false
var grass_deceleration_modifier = 4

var speedometer : Speedometer

func _ready() -> void:
	speedometer = get_node("../CanvasLayer/HUD/Speedometer")
	
	
func _physics_process(_delta: float) -> void:
	# var input_throttle = Input.get_axis("Break", "Gas") * throttle_modifier
	if Input.is_action_just_pressed("Boost"):
		if num_speed_boosts > 0:
			num_speed_boosts -= 1
			speed += speed_boost
	var input_throttle = clamp(speed , 0, 10000)
	
	var dec_modifer = 1
	if on_grass:
		dec_modifer *= grass_deceleration_modifier
		if $CPUParticles2D.emitting == false:
			$CPUParticles2D.restart()
	else:
		if $CPUParticles2D.emitting == true:
			$CPUParticles2D.emitting = false
	speed += deceleration * dec_modifer * _delta
	if speed < 0:
		speed = 0
		
	var input_steering = Input.get_axis("Turn Left", "Turn Right") * speed * steering_speed
	
	if input_throttle > 0:
		speedometer.set_speed(speed * 2)
	else:
		speedometer.set_arrow_to_zero()
	
	velocity.x = input_throttle * speed
	velocity.y = input_steering * steering_speed
	
	move_and_slide()
