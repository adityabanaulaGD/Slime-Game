extends CharacterBody2D

const SPEED = 150
const WEAPONCD = 0.5

var weapon_cooldown = -1

var died := false

@onready var hurt_sfx = $AudioStreamPlayer2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var weapon = $Weapon
@onready var health_component = $HealthComponent
@onready var game_manager = %GameManager

func add_health():
	health_component.heal()

func take_damage(damage):
	health_component.hurt(damage)
	hurt_sfx.play()

func update_animation_parameters():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idle"] = true
		animation_tree["parameters/conditions/is_running"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_running"] = true

func _process(_delta: float) -> void:
	update_animation_parameters()

func _physics_process(_delta: float) -> void:
	
	var mouse : Vector2 = get_local_mouse_position().normalized()
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") and weapon_cooldown < 0:
		weapon.shoot_projectile()
		weapon_cooldown = WEAPONCD
	
	weapon_cooldown -= _delta
	
	animation_tree["parameters/idle/blend_position"] = mouse
	animation_tree["parameters/run/blend_position"] = mouse
	
	if died:
		game_manager.game_over()
		queue_free()
