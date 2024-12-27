extends Node2D

@onready var sfx = $AudioStreamPlayer2D

func on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func on_quit_pressed():
	get_tree().quit()


func _on_play_pressed() -> void:
	on_play_pressed()
	print("play pressed")
	sfx.play(0)

func _on_quit_pressed() -> void:
	on_quit_pressed()
	print("quit pressed")
	sfx.play(0)


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/controls_menu.tscn")
	sfx.play(0)
