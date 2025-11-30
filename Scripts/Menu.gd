extends Control

# Função do botão INICIAR
func _on_button_iniciar_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level3D.tscn")

# Função do botão SAIR
func _on_button_sair_pressed():
	print("Saindo do jogo...") # Para você ver no console que funcionou
	get_tree().quit()
