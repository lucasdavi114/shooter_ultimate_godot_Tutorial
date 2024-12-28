extends Node2D

var velocidade: int = 400
var municao: int = 10
var municao_total: int = MUNICAO_LASER + 10
var granadas: int = 5

const MUNICAO_LASER: int = 40
const NUM_GRANADAS: int = 5
const VAZIO: int = 0

func _process(delta: float) -> void:
	
	var tiros_disparados = 0
	# Entrada de teclas e controle de personagem em 8 direções
	var direcao: Vector2
	
	direcao = Input.get_vector("left", "right", "up", "down")
	
	position += direcao * velocidade * delta
	
	#print(direcao)
	
	# Controle de disparo do personagem
	if Input.is_action_just_pressed("primary_action") and municao != VAZIO:
		print("Disparo")
		municao -= 1
		tiros_disparados += 1
		print(municao,"/", municao_total)
		if municao <= VAZIO:
			print("pressione R para recarregar!!")
	if Input.is_action_just_pressed("reload") and municao_total > VAZIO:
			municao_total -= tiros_disparados
			municao = 10
			tiros_disparados = 0
			print("Reloading!!")
		
	if Input.is_action_just_pressed("secondary_action") and granadas != VAZIO:
		print("Fire in a hole!!")
		granadas -= 1
		print("Grandas: ", granadas)
	if Input.is_action_just_pressed("secondary_action") and granadas == VAZIO:
		print("Sem granadas!!")
	
	if Input.is_action_just_pressed("interact"):
		granadas = NUM_GRANADAS
		municao = 10
		municao_total = MUNICAO_LASER + 10
		print("Munições e granadas abastecidas!!")
