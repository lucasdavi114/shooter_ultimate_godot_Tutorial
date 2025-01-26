extends LevelParent

func _on_gate_player_entrou_na_area() -> void:
	
	var tween = create_tween()
	
	tween.tween_property($Player, "velocidade", 0, 0.5)
	
	call_deferred("change_scene", "res://scenes/levels/inside.tscn")

func change_scene(scene_path: String) -> void:
	
	TransitionLayer.change_scene(scene_path)
	
