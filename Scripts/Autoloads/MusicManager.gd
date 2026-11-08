extends Node

const EPA_DUNK_FULL__EQ_ = preload("uid://d078k4s65ljrp")
const EPA_DUNK_LOOP__EQ_ = preload("uid://b752yo2aybctd")

@export var music : AudioStreamPlayer

func _ready() -> void:
	music = AudioStreamPlayer.new()
	add_child(music)
	music.finished.connect(finished_intro)
	music.stream = EPA_DUNK_FULL__EQ_
	music.play()

func finished_intro():
	music.stop()
	music.stream = EPA_DUNK_LOOP__EQ_
	music.play()
