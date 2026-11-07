class_name Car
extends CharacterBody2D

var audio_manager : AudioManager

@export var snus_gauge : Snus_Gauge

@export var engine_level: int = 0
@export var boost_level: int = 0
@export var snus_level: int = 0

# Upgradable
@export var num_speed_boosts : int = 3      # Number of snus in the bucket
@export var speed_boost : float = 150.0     # Car Booster Upgrade
@export var deceleration : float = -30      # Car Engine Upgrade

var boost_delay = 1000
var time_last_boost : float = -999
var boost_charge_duration : float = 0
var time_boost_charge_start : float = 0
var boost_time_target = 500

var steering_speed : float = PI/16
var speed : float = 0

var car_started_motion = false
var on_grass : bool = false
var grass_deceleration_modifier = 4
var grass_particle_speed_limit = 12

var speedometer : Speedometer

func _ready() -> void:
	audio_manager = get_node("../AudioManager")
	speedometer = get_node("../CanvasLayer/HUD/Speedometer")
	audio_manager.play_sfx(audio_manager.MOTORLJUD__1__EPA)
	
func _physics_process(_delta: float) -> void:
	num_speed_boosts = snus_gauge.num_snus_remaining()
	# var input_throttle = Input.get_axis("Break", "Gas") * throttle_modifier
	var time_now = Time.get_ticks_msec()
	if Input.is_action_just_pressed("Boost"):
		audio_manager.play_sfx(audio_manager.ÖPPNA_SNUS)
		time_boost_charge_start = time_now
	if Input.is_action_just_released("Boost"):
		car_started_motion = true
		var boost_crit : bool = false
		if abs(time_now - time_boost_charge_start - boost_time_target) < 50:
			boost_crit = true 
		if num_speed_boosts > 0 and time_now - time_last_boost > boost_delay:
			time_last_boost = time_now
			num_speed_boosts -= 1
			snus_gauge.consume_snus()
			if boost_crit:
				speed += speed_boost * 2
			else:
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
