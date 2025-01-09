extends Area2D

@export var velocidade: int = 1500
var direcao: Vector2 = Vector2.UP

func _process(delta: float) -> void:
	
	position += direcao * velocidade * delta
	
