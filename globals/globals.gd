extends Node

signal stats_change

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
		health = value
		stats_change.emit()

var player_position: Vector2
