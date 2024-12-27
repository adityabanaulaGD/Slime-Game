extends State

class_name FollowState

@export var detect_range := 100.0
@export var attack_range := 50.0

@onready var player = $/root/Game/player

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	
	var direction = Vector2.ZERO
	var distance = detect_range
	
	if player != null:
		direction = enemy.global_position.direction_to(player.global_position)
		distance = enemy.global_position.distance_to(player.global_position)
	
	animation_tree["parameters/run/blend_position"] = direction

	if distance <= attack_range:
		Transitioned.emit(self, "attack")
	elif distance <= detect_range:	
		enemy.velocity = direction * move_speed
	if distance > detect_range:
		Transitioned.emit(self, "idle")
