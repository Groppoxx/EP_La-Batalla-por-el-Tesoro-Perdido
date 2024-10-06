extends Node2D

var scenePath: String = "res://scenes/levels/level_1.tscn"

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(scenePath)


func _on_quit_pressed() -> void:
	get_tree().quit()
