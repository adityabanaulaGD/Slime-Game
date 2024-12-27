extends State

class_name attack_state

@export var detect_range := 100.0
@export var attack_range := 50.0
@export var attack_cd : float = 5.0

var can_attack := false
var attack_power
var atk_cd

@onready var player = $/root/Game/player

func _ready() -> void:
	attack_power = get_parent().get_parent().get_child(1).attack_power

func attack():
	if player.has_method("take_damage"):
		player.take_damage(attack_power)

func enter():
	atk_cd = 0

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	
	atk_cd -= _delta
	
	if atk_cd <= 0:
		attack()
	
	atk_cd = attack_cd
	
	var distance = attack_range
	
	if player != null:
		distance = enemy.global_position.distance_to(player.global_position)
	
	if distance > attack_range:
		Transitioned.emit(self, "follow")
