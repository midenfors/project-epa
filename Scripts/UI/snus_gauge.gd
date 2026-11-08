class_name Snus_Gauge
extends Control

var snusdosa_tex : Texture2D = preload("res://Assets/Art/Snusdossa.png")
var snus_sprites = []

func _ready() -> void:
	update_snus_amount()

# Rebuilds the snus stack: base snus + 1 per Snus Storage level.
func update_snus_amount():
	for sprite in snus_sprites:
		sprite.queue_free()
	snus_sprites.clear()

	var _max : int = Global.snus_counter + Global.snus_upgrades
	var v_offset : float = 40
	var h_offset : float = 80
	var max_stack_height = 5
	for i in range(_max, 0, -1):
		var sprite := Sprite2D.new()
		sprite.texture = snusdosa_tex
		sprite.position = $SnusMarker2D.position + Vector2(h_offset * ((i - _max)/max_stack_height), v_offset * ((i - _max)%max_stack_height))
		add_child(sprite)
		snus_sprites += [sprite]

func consume_snus():
	if snus_sprites.size() > 0:
		var sprite: Sprite2D = snus_sprites.pop_back()
		sprite.queue_free()

func num_snus_remaining():
	return snus_sprites.size()
