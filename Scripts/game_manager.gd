extends Node

@export var pause_screen : Node2D
@export var over_screen : Node2D
@export var kills_label : Label

@onready var sfx = $AudioStreamPlayer2D

const spawnPoint_h : Vector2 = Vector2(-600, 800)
const spawnPoint_v : Vector2 = Vector2(-400, 500)

@export var spawn_timer := 5

var num_of_enemy := 10
var spawn_time
var total_kills := 0

func can_spawn_heart():
	var random_number = randf_range(5, 15) * 0.1
	if random_number >= 1:
		return true
	return false

func count_kills():
	total_kills += 1


func game_over():
	over_screen.visible = true
	kills_label.text = "Score : " + str(total_kills)

func set_random_spawnpoint():
	var random_x = randf_range(spawnPoint_h.x,spawnPoint_h.y)
	var random_y = randf_range(spawnPoint_v.x, spawnPoint_v.y)
	var random_spawn = Vector2(random_x, random_y)
	return random_spawn 

func spawn_heart():
	const HEART = preload("res://health_pickup.tscn")
	var spawn_point = set_random_spawnpoint()
	var new_heart = HEART.instantiate()
	new_heart.global_position = spawn_point
	owner.add_child.call_deferred(new_heart)

func spawn_enemies(no_of_enemy):
	const SLIME = preload("res://Scenes/slime.tscn")
	for i in range(no_of_enemy):
		var spawn_point = set_random_spawnpoint()
		var new_slime = SLIME.instantiate()
		new_slime.global_position = spawn_point
		owner.add_child.call_deferred(new_slime)


func _ready() -> void:
	spawn_time = spawn_timer


func _process(delta: float) -> void: 
	
	spawn_time -= delta
	
	if spawn_time <= 0 :
		# Spawn Enemies
		spawn_enemies(num_of_enemy)
		num_of_enemy += 1 if num_of_enemy < 45 else 0
		spawn_timer -= 1
		spawn_time = spawn_timer if spawn_timer >= 10 else 10
		# Every time enemies are spawned I will check if heart can be spawned as well
		if can_spawn_heart():
			spawn_heart() 

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("esc"):
		pause_screen.visible = true
		Engine.time_scale = 0

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	sfx.play(0)

func _on_resume_pressed() -> void:
	pause_screen.visible = false
	Engine.time_scale = 1
	sfx.play(0)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	sfx.play(0)
