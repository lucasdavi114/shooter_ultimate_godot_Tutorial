extends Node2D

var velocidade: int = 400

func _ready() -> void:
	$Arma.hud_arma()

func _process(delta: float) -> void:
	
	# Entrada de teclas e controle de personagem em 8 direções
	var direcao: Vector2
	
	direcao = Input.get_vector("left", "right", "up", "down")
	
	position += direcao * velocidade * delta
	
	# Controle de disparo do personagem
	if Input.is_action_just_pressed("primary_action") and $Arma.municao != $Arma.VAZIO:
		$Arma.disparo()
		$Arma.hud_arma()
		if $Arma.arma_vazia():
			print("pressione R para recarregar!!")

	# Recarga de arma
	if Input.is_action_just_pressed("reload"):
			$Arma.recarregar()
		
	# Disparo secundário da arma, no caso um lança granadas
	if Input.is_action_just_pressed("secondary_action") and $Arma.granadas != $Arma.VAZIO:
		$Arma.disparo_secundario()

	# Sem granadas
	if Input.is_action_just_pressed("secondary_action") and $Arma.granadas == $Arma.VAZIO:
		print("Sem granadas!!")
	
	# Interação para reabastecer municao primaria e secundária
	if Input.is_action_just_pressed("interact"):
		$Arma.interacao()
