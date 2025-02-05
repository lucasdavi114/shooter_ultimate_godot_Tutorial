extends CharacterBody2D

var active: bool = false
var speed: int = 200

func _ready() -> void:
	await get_tree().create_timer(0.01).timeout
	$NavigationAgent2D.target_position = Globals.player_position
	

func _physics_process(_delta: float) -> void:
	
	var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	

func _on_navigation_timer_timeout() -> void:
	if active:
		$NavigationAgent2D.target_position = Globals.player_position
		look_at(Globals.player_position)


func _on_attack_area_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_attack_area_body_exited(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true


func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
