extends LevelParent

func _on_saida_body_entered(_body: Node2D) -> void:
	
	var tween = create_tween()
	
	tween.tween_property($Player, "velocidade", 0, 0.5)
	
	call_deferred("change_scene", "res://scenes/levels/outside.tscn")
	

func change_scene(scene_path: String) -> void:
	
	get_tree().change_scene_to_file(scene_path)
	
