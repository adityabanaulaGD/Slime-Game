extends CharacterBody2D

@onready var dead_sfx = $AudioStreamPlayer2D
@onready var health = $HealthComponent
@onready var animation_tree = $AnimationTree
@onready var player = $/root/Game/player
@onready var game_manager = $/root/Game/GameManager
@onready var explosion = $explosion
@onready var sprite = $SlimeSprite

var died := false


func take_damage():
	health.hurt(1)
	animation_tree["parameters/conditions/hurt"] = true
	animation_tree["parameters/conditions/died"] = died

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	var direction = 0
	
	if player != null:
		direction = global_position.direction_to(player.global_position)
		
	animation_tree["parameters/hurt/blend_position"] = direction
	
	if died:
		dead_sfx.play(0)
		sprite.visible = false
		explosion.visible = true
		if game_manager.has_method("count_kills"):
			game_manager.count_kills()
		await get_tree().create_timer(0.05).timeout
		queue_free()
