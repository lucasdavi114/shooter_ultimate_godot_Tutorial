extends Node2D

var municao: int = 10
var granadas: int = 5

const MUNICAO_LASER: int = 10
const NUM_GRANADAS: int = 5
const VAZIO: int = 0

# Funcao para saber o estado de municao da arma, retorna true se esta vazia false se não
func arma_vazia() -> bool:
	return true if municao == VAZIO else false

# Hud da arma
func hud_arma() -> void:
	print(municao, "/", MUNICAO_LASER)

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
	municao = 10
	print("Reloading!!")
	hud_arma()

# Recarrega todas as munições
func interacao() -> void:
	granadas = NUM_GRANADAS
	municao = 10
	print("Munições e granadas abastecidas!!")
