extends CharacterBody2D

var municao: int = 25
var granadas: int = 5

var velocidade: int = 400
var pode_atirar: bool = true
var pode_lancar_granada: bool = true

const MUNICAO_LASER: int = 25
const NUM_GRANADAS: int = 5
const VAZIO: int = 0

signal laser(posicao_saida_laser: Vector2, direction)
signal granada(posicao_saida_granada: Vector2, direction)

func _ready() -> void:
	hud_arma()

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
	if Input.is_action_pressed("primary_action") and municao != VAZIO and pode_atirar:
		# Seleciona um Marker2D para a saida da bala
		var marcador_selecionado = $SaidaProjeteis.get_children()
		
		var posicao_saida_laser = marcador_selecionado[randi() % marcador_selecionado.size()]
		$GPUParticles2D.emitting = true
		disparo()
		hud_arma()
		
		pode_atirar = false
		
		$TimerLaser.start()
		
		
		# Emite o laser com a posicao de saida dele
		laser.emit(posicao_saida_laser.global_position, direction)
		
		if arma_vazia():
			print("pressione R para recarregar!!")

	# Recarga de arma
	if Input.is_action_just_pressed("reload"):
			recarregar()
			
	# Disparo secundário da arma, no caso um lança granadas
	if Input.is_action_pressed("secondary_action") and granadas != VAZIO and pode_lancar_granada:
		var marcador_granada = $SaidaProjeteis.get_children()[1]
		
		var posicao_saida_granada = marcador_granada
		disparo_secundario()
		pode_lancar_granada = false
		$TimerGranadas.start()
		
		
		granada.emit(posicao_saida_granada.global_position, direction)
	# Sem granadas
	if Input.is_action_just_pressed("secondary_action") and granadas == VAZIO:
		print("Sem granadas!!")
		
	# Interação para reabastecer municao primaria e secundária
	if Input.is_action_just_pressed("interact"):
		interacao()

func hud_arma() -> void:
	print(municao, "/", MUNICAO_LASER)

# Funcao para saber o estado de municao da arma, retorna true se esta vazia false se não
func arma_vazia() -> bool:
	return true if municao == VAZIO else false

# Hud da arma


# Funcao para disparo ao apertar o botao esquerdo do mouse, decrementa em 1 a municao
func disparo() -> void:
	print("Disparo")
	municao -= 1

# Funcao para o disparo secundário da arma, decrementa em 1 a munição secundária
func disparo_secundario() -> void:
	print("Fire in a hole!!")
	granadas -= 1
	print("Granadas: ", granadas)

# Recarrega a munição primária da arma
func recarregar() -> void:
	municao = MUNICAO_LASER
	print("Reloading!!")
	hud_arma()

# Recarrega todas as munições
func interacao() -> void:
	granadas = NUM_GRANADAS
	municao = MUNICAO_LASER
	print("Munições e granadas abastecidas!!")


func _on_timer_timeout() -> void:
	pode_atirar = true
	

func _on_timer_granadas_timeout() -> void:
	pode_lancar_granada = true
