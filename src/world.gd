extends Node2D

@onready var sound = $SoundChip
@onready var bgm = preload("res://assets/bgm/bgm.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	sound.play_music(bgm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
