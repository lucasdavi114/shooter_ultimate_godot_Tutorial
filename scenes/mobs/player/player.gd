extends CharacterBody2D

var velocidade: int = 400
var pode_atirar: bool = true
var pode_lancar_granada: bool = true

signal laser
signal granada

func _ready() -> void:
	$Arma.hud_arma()

func _process(_delta: float) -> void:
	
	# Entrada de teclas e controle de personagem em 8 direções
	var direcao: Vector2
	
	direcao = Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade 
	move_and_slide()
	
	# Controle de disparo do personagem
	if Input.is_action_pressed("primary_action") and $Arma.municao != $Arma.VAZIO and pode_atirar:
		$Arma.disparo()
		$Arma.hud_arma()
		laser.emit()
		pode_atirar = false
		$TimerLaser.start()
		
		if $Arma.arma_vazia():
			print("pressione R para recarregar!!")

	# Recarga de arma
	if Input.is_action_just_pressed("reload"):
			$Arma.recarregar()
			
	# Disparo secundário da arma, no caso um lança granadas
	if Input.is_action_pressed("secondary_action") and $Arma.granadas != $Arma.VAZIO and pode_lancar_granada:
		$Arma.disparo_secundario()
		granada.emit()
		pode_lancar_granada = false
		$TimerGranadas.start()
		
	# Sem granadas
	if Input.is_action_just_pressed("secondary_action") and $Arma.granadas == $Arma.VAZIO:
		print("Sem granadas!!")
		
	# Interação para reabastecer municao primaria e secundária
	if Input.is_action_just_pressed("interact"):
		$Arma.interacao()


func _on_timer_timeout() -> void:
	pode_atirar = true
	

func _on_timer_granadas_timeout() -> void:
	pode_lancar_granada = true
