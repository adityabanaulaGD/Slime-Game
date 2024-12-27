## Virtual base class for all states.
## Extend this class and override its methods to implement a state.
class_name State extends Node

@export var animation_player : AnimationPlayer
@export var enemy : CharacterBody2D 
@export var move_speed : float
@export var animation_tree : AnimationTree

var player_detected : bool

signal Transitioned

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
