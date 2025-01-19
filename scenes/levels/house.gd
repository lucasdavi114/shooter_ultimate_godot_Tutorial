extends Area2D

signal player_entrou(body: CharacterBody2D)

signal player_saiu(body: CharacterBody2D)

func _on_body_entered(body: Node2D) -> void:
	player_entrou.emit(body)


func _on_body_exited(body: Node2D) -> void:
	player_saiu.emit(body)
