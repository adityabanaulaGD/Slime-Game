extends Area2D

func shoot_projectile():
	const BULLET = preload("res://Scenes/projectile.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootPoint.global_position
	new_bullet.global_rotation = %ShootPoint.global_rotation
	%ShootPoint.add_child(new_bullet) 


func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position()) 
	
