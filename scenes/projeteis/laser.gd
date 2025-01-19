extends Area2D

@export var velocidade: int = 1500
var direcao: Vector2 = Vector2.UP

func _ready() -> void:
	$TempoVida.start()

func _process(delta: float) -> void:
	
	position += direcao * velocidade * delta
	
func _on_body_entered(body: Node2D) -> void:
	print(body)
	if "hit" in body:
		body.hit()
	queue_free()

func _on_tempo_vida_timeout() -> void:
	queue_free()
