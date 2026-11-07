class_name Snus_Gauge
extends Control

var snusdosa_tex : Texture2D = preload("res://Assets/Art/Snusdossa.png")
const global_script = preload("res://Scripts/Autoloads/Global.gd")
var global_inst = global_script.new()
var snus_sprites = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var max = global_inst.snus_counter
	var offset : float = 30
	for i in range(max, 0, -1):
		var sprite := Sprite2D.new()
		sprite.texture = snusdosa_tex
		sprite.position = $SnusMarker2D.position + Vector2(0, offset) * (i - max)
		add_child(sprite)
		snus_sprites += [sprite]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func consume_snus():
	if snus_sprites.size() > 0:
		var sprite: Sprite2D = snus_sprites.pop_back()
		sprite.queue_free()

func num_snus_remaining():
	return snus_sprites.size()
