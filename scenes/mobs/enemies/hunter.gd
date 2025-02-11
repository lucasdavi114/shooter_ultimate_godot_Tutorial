extends CharacterBody2D

var active: bool = false
var speed: int = 200
var can_attack: bool = false
var vulnerable: bool = true
var health: int = 80

func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	$NavigationAgent2D.target_position = Globals.player_position

func _physics_process(_delta: float) -> void:
	if active:
		var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		var look_angle = direction.angle()
		rotation = look_angle + PI / 2


# Areas2d Signals
func _on_attack_area_body_entered(_body: Node2D) -> void:
	can_attack = true
	$AnimationPlayer.play("Attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	can_attack = false
	$AnimationPlayer.play("Walk")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimationPlayer.play("Walk")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false

# Timers
func _on_attack_timer_timeout() -> void:
	can_attack = false

func _on_hit_timer_timeout() -> void:
	vulnerable = true

func _on_navigation_timer_timeout() -> void:
	if active:
		$NavigationAgent2D.target_position = Globals.player_position

func attack():
	if can_attack:
		Globals.health -= 20

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		$AudioStreamPlayer2D.play()
		
	if health <= 0:
		queue_free()
