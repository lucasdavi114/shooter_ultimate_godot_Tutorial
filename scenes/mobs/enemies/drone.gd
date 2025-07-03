extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true

var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1
var health: int = 50

var explosion_active: bool = false
var explosion_range: int = 400

func _ready() -> void:
	$Explosion.hide()

func _process(delta: float) -> void:
	
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		
		velocity = speed * direction * speed_multiplier
	
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			change_explosion_state()
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_range
			if "hit" in target and in_range:
				target.hit()

func stop_movement():
	speed_multiplier = 0

func hit() -> void:
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
		$DroneSprite.material.set_shader_parameter("progress", 1)
		$Sounds/HitSound.play()
	if health <= 0:
		$AnimationPlayer.play("explosion")
		change_explosion_state()
		

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween. tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$DroneSprite.material.set_shader_parameter("progress", 0)

func change_explosion_state() -> void:
	explosion_active = !explosion_active
