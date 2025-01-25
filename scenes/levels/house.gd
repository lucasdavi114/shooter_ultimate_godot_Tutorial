extends Area2D

signal player_entrou()

signal player_saiu()

func _on_body_entered(_body: Node2D) -> void:
	player_entrou.emit()


func _on_body_exited(_body: Node2D) -> void:
	player_saiu.emit()
