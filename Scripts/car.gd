class_name Car
extends CharacterBody2D

var audio_manager : AudioManager

@export var turn_smoothing : float = 8.0 # Högre = snabbare

var engine_upgrade : int = 0
var wheels_upgrade : int = 0
var booster_upgrade : int = 0

@export var faux : bool = false

# Upgradable
@export var num_speed_boosts : int = 3      # Number of snus in the bucket
@export var speed_boost : float = 150.0     # Car Booster Upgrade
@export var deceleration : float = -30      # Car Engine Upgrade
@export var engine_decel_reduction : float = 0.05  # Each engine level cuts deceleration by 5%

var current_boost_has_triggered : bool = false
var boost_delay = 1200
var time_last_boost : float = -999
var time_boost_charge_start : float = 0
var boost_duration_target = 600
var boost_duration_cutoff = boost_duration_target * 1.8
var boost_crit_window = 300

var steering_speed : float = PI/16
var speed : float = 0

var car_started_motion = false
var on_grass : bool = false
var terrain_deceleration_modifier = 4
var grass_particle_speed_limit = 12
var break_deceleration_modifier = 15

var speedometer : Speedometer
var tachometer : Tachometer
var snus_gauge : Snus_Gauge
var steering_wheel : Node2D

func _ready() -> void:
	if not faux:
		audio_manager = get_node("../AudioManager")
		speedometer = get_node("../CanvasLayer/HUD/Dashboard/Gauges/Speedometer")
		tachometer = get_node("../CanvasLayer/HUD/Dashboard/Gauges/Tachometer")
		snus_gauge = get_node("../CanvasLayer/HUD/Dashboard/SnusGauge")
		steering_wheel = get_node("../CanvasLayer/HUD/Dashboard/Ratt")
		audio_manager.play_sfx(audio_manager.MOTORLJUD__1__EPA)
	
	engine_upgrade = Global.engine_upgrades
	$Engines/CarEngine1.visible = false
	$Engines/CarEngine2.visible = false
	$Engines/CarEngine3.visible = false
	match engine_upgrade:
		3, 4:
			$Engines/CarEngine1.visible = true
		5, 6, 7:
			$Engines/CarEngine2.visible = true
		8, 9, 10:
			$Engines/CarEngine3.visible = true
		_:
			pass
	
	booster_upgrade = Global.booster_upgrades
	$BottomBosters/CarBoost1.visible = false
	$TopBoosters/CarBoost2.visible = false
	$TopBoosters/CarBoost3.visible = false
	match booster_upgrade:
		3, 4:
			$BottomBosters/CarBoost1.visible = true
		5, 6, 7:
			$TopBoosters/CarBoost2.visible = true
		8, 9, 10:
			$TopBoosters/CarBoost3.visible = true
		_:
			pass
	speed_boost += (speed_boost * 0.3 * Global.booster_upgrades)
	
	wheels_upgrade = Global.wheels_upgrades
	$Wheels/T1.visible = false
	$Wheels/T2.visible = false
	$Wheels/T2.visible = false
	match wheels_upgrade:
		1:
			$Wheels/T2.visible = true
			terrain_deceleration_modifier *= 0.5
		2:
			$Wheels/T3.visible = true
			terrain_deceleration_modifier *= 0
		_:
			$Wheels/T1.visible = true
			pass
	
# Deceleration after engine upgrades (level 10 = half the slowdown).
func get_deceleration() -> float:
	var factor := maxf(0.0, 1.0 - engine_decel_reduction * Global.engine_upgrades)
	return deceleration * factor

func _physics_process(_delta: float) -> void:
	if not faux:
		num_speed_boosts = snus_gauge.num_snus_remaining()

		var time_now = Time.get_ticks_msec()
		var boost_duration = 0
		
		if Input.is_action_just_pressed("Boost"):
			if num_speed_boosts > 0:
				audio_manager.play_sfx(audio_manager.ÖPPNA_SNUS)
				time_boost_charge_start = time_now
				current_boost_has_triggered = false
		var can_trigger_boost = num_speed_boosts > 0 and not current_boost_has_triggered
		
		if can_trigger_boost and Input.is_action_pressed("Boost"):
			boost_duration = time_now - time_boost_charge_start
		if can_trigger_boost and (Input.is_action_just_released("Boost") or boost_duration > boost_duration_cutoff):
			car_started_motion = true
			var boost_crit : bool = false
			
			if abs(boost_duration - boost_duration_target) < boost_crit_window/2.0:
				boost_crit = true
			if num_speed_boosts > 0 and time_now - time_last_boost > boost_delay:
				time_last_boost = time_now
				num_speed_boosts -= 1
				snus_gauge.consume_snus()
				current_boost_has_triggered = true
				if boost_crit:
					speed += speed_boost * 2
				else:
					speed += speed_boost
				
		speed = clamp(speed, 0, 10000)
		
		var dec_modifier = 1
		if on_grass:
			dec_modifier *= terrain_deceleration_modifier
			if $CPUParticles2D.emitting == false:
				if speed > grass_particle_speed_limit:
					$CPUParticles2D.restart()
			else:
				if speed <= grass_particle_speed_limit:
					$CPUParticles2D.emitting = false
		else:
			if $CPUParticles2D.emitting == true:
				$CPUParticles2D.emitting = false
		if Input.is_action_pressed("Break"):
			dec_modifier *= break_deceleration_modifier
		speed += get_deceleration() * dec_modifier * _delta
		if speed < 0:
			speed = 0
		velocity = Vector2(speed, 0)
		var steering_angle = steering_speed * Input.get_axis("Turn Left", "Turn Right")
		velocity = velocity.rotated(steering_angle)
		
		# Visual turning feedback
		rotation = lerpf(rotation, PI/2 + steering_angle, 1.0 - exp(-turn_smoothing * _delta))
		steering_wheel.rotation = lerpf(steering_wheel.rotation, steering_angle * 5, 1.0 - exp(-turn_smoothing * _delta))
		
		tachometer.set_rpm(boost_duration / boost_duration_cutoff)
		if speed > 0:
			speedometer.set_speed(speed * 0.1)
		else:
			speedometer.set_arrow_to_zero()
		
		move_and_slide()


func play_poppy_audio():
	audio_manager.play_sfx(audio_manager.POPPY_BOTTLE)
