extends CharacterBody2D

class_name DynamiteMob

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var player = %player

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if velocity.length() > 0:
		animation_player.play("run")
	
	#if velocity.x >= 0:
		#sprite.flip_h = false
	#else:
		#sprite.flip_h = true
