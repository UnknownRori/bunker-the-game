extends Node2D


func _on_core_death():
	SceneTransition.change_scene(load("res://scene/Win.tscn"))
