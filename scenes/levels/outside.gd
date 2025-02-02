extends LevelParent

func _on_gate_player_entrou_na_area() -> void:
	
	var tween = create_tween()
	
	tween.tween_property($Player, "velocidade", 0, 0.5)
	
	call_deferred("change_scene", "res://scenes/levels/inside.tscn")

func change_scene(scene_path: String) -> void:
	
	TransitionLayer.change_scene(scene_path)

func _on_house_player_entrou() -> void:
	
	var tween = get_tree().create_tween()
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)

	

func _on_house_player_saiu() -> void:
	var tween = get_tree().create_tween()
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)
