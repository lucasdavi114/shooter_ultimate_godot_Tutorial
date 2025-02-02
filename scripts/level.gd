extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projeteis/laser.tscn")
var granada_scene: PackedScene = preload("res://scenes/projeteis/granada.tscn")
var items_scene: PackedScene = preload("res://scenes/items/items.tscn")

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser", _on_scout_laser)


func _on_container_opened(pos, direction):
	var item = items_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child", item)

func _on_player_laser(posicao_saida_laser, direction) -> void:
	create_Laser(posicao_saida_laser, direction)
	
	

func create_Laser(pos, direction):
	var laser: Area2D = laser_scene.instantiate()
	
	# 1. Atualizar a posição do laser
	laser.position = pos
	
	laser.rotation_degrees = rad_to_deg(direction.angle())
	laser.direcao = direction
	
	# Instancia o laser dentro de um Node2D, InstanciasDeProjeteis.
	$InstanciasDeProjeteis.add_child(laser)
func _on_scout_laser(pos, direction):
	create_Laser(pos, direction)
	
func _on_player_granada(posicao_saida_granada, direction) -> void:
	var granada: RigidBody2D = granada_scene.instantiate()
	
	granada.position = posicao_saida_granada
	
	granada.linear_velocity = direction * granada.speed
	
	$InstanciasDeProjeteis.add_child(granada)
