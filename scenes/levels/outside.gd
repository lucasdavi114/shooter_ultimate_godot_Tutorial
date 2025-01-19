extends LevelParent

func _on_gate_player_entrou_na_area(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "velocidade", 0, 1)


func _on_gate_player_saiu_da_area(body) -> void:
	print("Player saiu da Área!!")
	print(body)
