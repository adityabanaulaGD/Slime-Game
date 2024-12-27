extends Node

class_name HealthComponent

@export var health : int
@onready var hp_label = $HP
@onready var hp_bar = $ProgressBar

var max_health : int

func _ready() -> void:
	max_health = health
	hp_label.text = str(health) + " / " + str(max_health)
	hp_bar.max_value = max_health

func heal():
	health += 1
	hp_label.text = str(health) + " / " + str(max_health)
	hp_bar.value -= 1

func hurt(damage):
	health -= damage
	hp_label.text = str(health) + " / " + str(max_health)
	hp_bar.value += 1
	if health <= 0 :
		get_parent().died = true
