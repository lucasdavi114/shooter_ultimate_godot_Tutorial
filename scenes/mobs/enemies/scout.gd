extends CharacterBody2D

var player_nearby: bool = false
var shoot: bool = true
var marker: bool = true

var health: int = 30
var vulnerable: bool = true

signal laser(pos, direction)

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTime.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		if shoot:
			var laserSpawn = $LaserSpawnPositions.get_child(marker)
			var pos: Vector2 = laserSpawn.global_position
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			shoot = false
			$Timers/LaserCoolDown.start()
			marker = not marker


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_timer_timeout() -> void:
	shoot = true


func _on_hit_time_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
