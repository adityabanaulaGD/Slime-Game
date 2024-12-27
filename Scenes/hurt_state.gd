extends State

class_name HurtState

func enter():
	animation_tree["parameters/conditions/hurt"] = true

func exit():
	animation_tree["parameters/conditions/hurt"] = false

func update(_delta: float):
	if animation_player.animation_finished:
		Transitioned.emit(self, "follow")
