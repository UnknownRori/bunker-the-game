extends Control

@onready var menu = preload("res://scene/MainMenu.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Start"):
		SceneTransition.change_scene(menu)
