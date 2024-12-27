extends State

class_name IdleState

@export var detect_range : float = 100.0

var move_direction : Vector2
var wander_time : float
@onready var player = $/root/Game/player


func randomize_wander():
	move_direction = Vector2(randf_range(-2, 2), randf_range(-2, 2))
	wander_time = randf_range(1,4)

func enter():
	randomize_wander()

func exit():
	pass

func update(_delta: float):
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()
	
func physics_update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	animation_tree["parameters/run/blend_position"] = move_direction
	
	var distance = 0
	
	if player != null:
		distance = enemy.global_position.distance_to(player.global_position)
	
	if distance <= detect_range:
		Transitioned.emit(self, "follow")
