extends Control

func _on_button_iniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/Level3D.tscn")

func _on_button_sair_pressed():
	print("Saindo do jogo...")
	get_tree().quit()
