extends LevelParent

func _on_gate_player_entrou_na_area(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "velocidade", 0, 1)
