extends CharacterBody2D



@export var max_velocidade: int = 400
var velocidade: int = max_velocidade
var pode_atirar: bool = true
var pode_lancar_granada: bool = true



signal laser(posicao_saida_laser: Vector2, direction)
signal granada(posicao_saida_granada: Vector2, direction)
signal update_stats()

func _process(_delta: float) -> void:
	
	# Entrada de teclas e controle de personagem em 8 direções
	var direcao: Vector2
	var direction = get_global_mouse_position()
		
	direction = (direction - position).normalized()
	direcao = Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade 
	move_and_slide()
	
	look_at(get_global_mouse_position())
	
	# Controle de disparo do personagem
	if Input.is_action_pressed("primary_action") and pode_atirar and Globals.municao > 0:
		Globals.municao -= 1
		# Seleciona um Marker2D para a saida da bala
		var marcador_selecionado = $SaidaProjeteis.get_children()
		
		var posicao_saida_laser = marcador_selecionado[randi() % marcador_selecionado.size()]
		$GPUParticles2D.emitting = true
		
		pode_atirar = false
		
		$TimerLaser.start()
		
		# Emite o laser com a posicao de saida dele
		laser.emit(posicao_saida_laser.global_position, direction)
		
	# Disparo secundário da arma, no caso um lança granadas
	if Input.is_action_pressed("secondary_action") and pode_lancar_granada and Globals.granadas > 0:
		Globals.granadas -= 1
		var marcador_granada = $SaidaProjeteis.get_children()[1]
		
		var posicao_saida_granada = marcador_granada
		disparo_secundario()
		pode_lancar_granada = false
		$TimerGranadas.start()
		
		
		granada.emit(posicao_saida_granada.global_position, direction)

# Funcao para o disparo secundário da arma, decrementa em 1 a munição secundária
func disparo_secundario() -> void:
	print("Fire in a hole!!")

func _on_timer_timeout() -> void:
	pode_atirar = true
	

func _on_timer_granadas_timeout() -> void:
	pode_lancar_granada = true

func add_item(type: String):
	if type == 'Grenade':
		Globals.granadas += 1
		
	if type == 'Laser':
		Globals.municao += 5 
		
	if type == 'Health':
		print("Vida cheia!")
	
	update_stats.emit()
