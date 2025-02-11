extends Node

signal stats_change

var player_hit_sound: AudioStreamPlayer2D
var player_vulnerable: bool = true

var municao = 25:
	set(value):
		municao = value
		stats_change.emit()
var granadas = 5:
	set(value):
		granadas = value
		stats_change.emit()
var health = 100:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				health = value
				player_vulnerable = false
				player_invulnerable_timer()
				player_hit_sound.play()
		stats_change.emit()

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

var player_position: Vector2

func _ready() -> void:
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
