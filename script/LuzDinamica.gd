extends SpotLight3D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		light_color = Color(randf(), randf(), randf())
		print("Nova cor da luz: ", light_color)
