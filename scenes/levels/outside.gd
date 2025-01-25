extends LevelParent

@export var inside_level_scene: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_player_entrou_na_area() -> void:
	
	var tween = create_tween()
	
	tween.tween_property($Player, "velocidade", 0, 0.5)
	
	call_deferred("change_scene", inside_level_scene)

func change_scene(scene_path: PackedScene) -> void:
	
	get_tree().change_scene_to_packed(scene_path)
	
