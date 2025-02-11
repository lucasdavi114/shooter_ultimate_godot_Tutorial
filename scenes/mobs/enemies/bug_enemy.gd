extends CharacterBody2D

var player_area_atack: bool = false
var player_nearby: bool = false

var health: int = 20
var speed: int = 300
var vulnerable: bool = true

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/VulnerableTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
		$AudioStreamPlayer2D.play()
	if health <= 0:
		speed = 0
		await get_tree().create_timer(0.5).timeout
		queue_free()

func _process(_delta: float) -> void:
	var direction = (Globals.player_position - position).normalized()
	
	velocity = direction * speed
	if player_nearby:
		move_and_slide()
		look_at(Globals.player_position)

func iniciaAnimacao(animacao: String):
	$AnimatedSprite2D.play(animacao)

func _on_vulnerable_timer_timeout() -> void:
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_nearby = true
	iniciaAnimacao("walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_nearby = false
	$AnimatedSprite2D.stop()

func _on_atack_area_body_entered(_body: Node2D) -> void:
	player_area_atack = true
	iniciaAnimacao("attack")
	$Timers/AttackTimer.start()
	
func _on_atack_area_body_exited(_body: Node2D) -> void:
	player_area_atack = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if player_area_atack:
		Globals.health -= 10
		$Timers/AttackTimer.start()

func _on_attack_timer_timeout() -> void:
	iniciaAnimacao("attack")
