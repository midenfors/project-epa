extends Path2D

var poppy_scene = load("res://Scenes/poppy.tscn")
var poppy_amount = 6
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(poppy_amount):
		var poppy = poppy_scene.instantiate()
		var spawn_location = $PoppyPosition
		spawn_location.progress_ratio = rng.randf()
		poppy.position = spawn_location.position
		add_child(poppy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
