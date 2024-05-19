extends Control

@onready var menu = preload("res://scene/MainMenu.tscn")
@onready var music = preload("res://assets/bgm/game_over.wav")

func _ready():
	DiscordPresence.set_detail("Game Over")
	SoundChip.play_music(music)

func _process(delta):
	if Input.is_action_just_pressed("Start"):
		SceneTransition.change_scene(menu)
