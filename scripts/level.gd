extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projeteis/laser.tscn")
var granada_scene: PackedScene = preload("res://scenes/projeteis/granada.tscn")


func _on_player_laser(posicao_saida_laser, direction) -> void:
	var laser: Area2D = laser_scene.instantiate()
	
	# 1. Atualizar a posição do laser
	laser.position = posicao_saida_laser
	
	laser.rotation_degrees = rad_to_deg(direction.angle())
	laser.direcao = direction
	
	# Instancia o laser dentro de um Node2D, InstanciasDeProjeteis.
	$InstanciasDeProjeteis.add_child(laser)
	$UI.update_hud_laser_munition()

func _on_player_granada(posicao_saida_granada, direction) -> void:
	var granada: RigidBody2D = granada_scene.instantiate()
	
	granada.position = posicao_saida_granada
	
	granada.linear_velocity = direction * granada.speed
	
	$InstanciasDeProjeteis.add_child(granada)
	$UI.update_hud_granade_munition()

func _on_house_player_entrou(_body: CharacterBody2D) -> void:
	
	var tween = get_tree().create_tween()
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)

	

func _on_house_player_saiu(_body: CharacterBody2D) -> void:
	var tween = get_tree().create_tween()
	
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6, 0.6), 1)


func _on_player_update_stats() -> void:
	$UI.update_hud_laser_munition()
	$UI.update_hud_granade_munition()
