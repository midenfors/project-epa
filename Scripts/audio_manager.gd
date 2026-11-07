extends Node
var player_scene = load("res://Scenes/audio_player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_sound("Start EPA.wav")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize_sound(sound_name: String) -> void:
	var player = player_scene.instantiate()
	player.stream = load("res://Assets/Audio/"+ sound_name)
	add_child(player)
