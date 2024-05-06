extends Node

@onready var jump = preload("res://assets/sfx/jump.wav")
@onready var shoot = preload("res://assets/sfx/shoot.wav")

var saw_channel
var noise_channel

func play_jump():
	$SawChannel.stream = jump
	$SawChannel.play()

func play_shoot():
	$NoiseChannel.stream = shoot
	$NoiseChannel.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

