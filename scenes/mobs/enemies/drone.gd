extends CharacterBody2D

var velocidade : int = 200

func _process(_delta: float) -> void:
	
	var direcao = Vector2.RIGHT
	
	velocity = velocidade * direcao
	
	move_and_slide()

func hit() -> void:
	print("hit")
