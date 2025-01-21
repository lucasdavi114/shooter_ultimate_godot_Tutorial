extends LevelParent

func _on_saida_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "velocidade", 0, 1)
