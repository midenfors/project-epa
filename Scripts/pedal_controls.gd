extends Control

func _ready() -> void:
	# Only the visible part of each pedal reacts to taps, not the transparent corners.
	for button: TextureButton in [$AccelerateButton, $BrakeButton]:
		button.texture_click_mask = make_click_mask(button.texture_normal)

func make_click_mask(texture: Texture2D) -> BitMap:
	var mask := BitMap.new()
	mask.create_from_image_alpha(texture.get_image())
	return mask

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Boost"):
		$AccelerateButton.button_pressed = true
	elif Input.is_action_just_released("Boost"):
		$AccelerateButton.button_pressed = false
		
func _on_accelerate_button_pressed() -> void:
	pass
	

func _on_brake_button_pressed() -> void:
	pass

func _on_accelerate_button_button_down() -> void:
	Input.action_press("Boost")


func _on_accelerate_button_button_up() -> void:
	Input.action_release("Boost")


func _on_brake_button_button_down() -> void:
	Input.action_press("Break")


func _on_brake_button_button_up() -> void:
	Input.action_release("Break")
