extends CharacterBody2D

@onready var lose = preload("res://scene/GameOver.tscn")
@onready var controllable = $Controllable

func dead_callback():
	SceneTransition.change_scene(lose)


func _on_boss_area_done_camera():
	controllable.accept_input = true


func _on_boss_area_start_camera():
	controllable.accept_input = false
