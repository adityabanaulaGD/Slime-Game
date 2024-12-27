extends CharacterBody2D

const SPEED = 30
var health = 3

@onready var animation_tree = $AnimationTree
@onready var sprite = $SlimeSprite

@onready var player = get_node("/root/Game/player")

func take_damage():
	health -= 1
	animation_tree["parameters/conditions/hurt"] = true
	if health <= 0:
		animation_tree["parameters/conditions/died"] = true
		await animation_tree.animation_finished
		queue_free()
		


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)

	velocity = direction * SPEED 

	move_and_slide()

	animation_tree["parameters/run/blend_position"] = direction
	animation_tree["parameters/hurt/blend_position"] = direction
