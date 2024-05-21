extends Control

@onready var win_bgm = preload("res://assets/bgm/win.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer2.play("credits")
	DiscordPresence.set_detail("In Credits")
	SoundChip.play_music(win_bgm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Start"):
		SceneTransition.change_scene(load("res://scene/MainMenu.tscn"))
