extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projeteis/laser.tscn")
var granada_scene: PackedScene = preload("res://scenes/projeteis/granada.tscn")

func _on_gate_player_entrou_na_area(body) -> void:
	if body == $Player:
		print("Player entrou na Área!!")


func _on_gate_player_saiu_da_area(body) -> void:
	if body == $Player:
		print("Player saiu da Área!!")


func _on_player_laser(posicao_saida_laser, direction) -> void:
	var laser: Area2D = laser_scene.instantiate()
	
	# 1. Atualizar a posição do laser
	laser.position = posicao_saida_laser
	
	laser.rotation_degrees = rad_to_deg(direction.angle())
	laser.direcao = direction
	
	# Instancia o laser dentro de um Node2D, InstanciasDeProjeteis.
	$InstanciasDeProjeteis.add_child(laser)
	

func _on_player_granada(posicao_saida_granada, direction) -> void:
	var granada: RigidBody2D = granada_scene.instantiate()
	
	granada.position = posicao_saida_granada
	
	granada.linear_velocity = direction * granada.speed
	
	$InstanciasDeProjeteis.add_child(granada)
