extends CharacterBody2D

@onready var lose = preload("res://scene/GameOver.tscn")

func dead_callback():
	SceneTransition.change_scene(lose)
