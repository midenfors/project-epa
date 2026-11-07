class_name Car
extends CharacterBody2D


# Upgradable
@export var num_speed_boosts : int = 2 		# Number of snus in the bucket
@export var speed_boost : float = 100.0		# Car Booster Upgrade
@export var deceleration : float = -10		# Car Engine Upgrade

var steering_speed : float = PI/10
var speed : float = 0

var on_grass : bool = false
var grass_deceleration_modifier = 4
var grass_particle_speed_limit = 12

var speedometer : Speedometer

func _ready() -> void:
	speedometer = get_node("../CanvasLayer/HUD/Speedometer")
	
	
func _physics_process(_delta: float) -> void:
	# var input_throttle = Input.get_axis("Break", "Gas") * throttle_modifier
	if Input.is_action_just_pressed("Boost"):
		if num_speed_boosts > 0:
			num_speed_boosts -= 1
			speed += speed_boost
	speed = clamp(speed, 0, 10000)
	
	var dec_modifer = 1
	if on_grass:
		dec_modifer *= grass_deceleration_modifier
		if $CPUParticles2D.emitting == false:
			if speed > grass_particle_speed_limit:
				$CPUParticles2D.restart()
		else:
			if speed <= grass_particle_speed_limit:
				$CPUParticles2D.emitting = false
	else:
		if $CPUParticles2D.emitting == true:
			$CPUParticles2D.emitting = false
	speed += deceleration * dec_modifer * _delta
	if speed < 0:
		speed = 0
	velocity = Vector2(speed, 0)
	var steering_angle = steering_speed * Input.get_axis("Turn Left", "Turn Right")
	velocity = velocity.rotated(steering_angle)
	rotation = PI/2 + steering_angle
		
	#var input_steering = Input.get_axis("Turn Left", "Turn Right") * speed * steering_speed
	#var horizontal_speed = 
	
	if speed > 0:
		speedometer.set_speed(speed * 0.1)
	else:
		speedometer.set_arrow_to_zero()
	
	# velocity.x = input_throttle * speed
	# velocity.y = input_steering * steering_speed
	
	move_and_slide()
