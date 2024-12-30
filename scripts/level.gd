extends Node2D

func _on_gate_player_entrou_na_area(body: Node2D) -> void:
	if body == $Player:
		print("Player entrou na Área!!")


func _on_gate_player_saiu_da_area(body: Node2D) -> void:
	if body == $Player:
		print("Player saiu da Área!!")


func _on_player_laser() -> void:
	print("Laser saindo de um sinal na cena Level!!")


func _on_player_granada() -> void:
	print("Granada saindo de um sinal na cena Level!!")
