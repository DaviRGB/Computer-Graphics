extends SpotLight3D

func _input(event):
	# Detecta clique do botão esquerdo do mouse
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Gera uma cor aleatória (Red, Green, Blue)
		light_color = Color(randf(), randf(), randf())
		print("Nova cor da luz: ", light_color)
