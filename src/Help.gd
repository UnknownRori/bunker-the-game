extends Control

func _ready():
	DiscordPresence.set_detail("In Help Menu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Start"):
		SceneTransition.change_scene(load("res://scene/MainMenu.tscn"))
