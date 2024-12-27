extends Node2D

@onready var sfx = $AudioStreamPlayer2D

func _on_back_pressed() -> void:
	sfx.play()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
