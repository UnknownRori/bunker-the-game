extends Node

@onready var jump = preload("res://assets/sfx/jump.wav")
@onready var shoot = preload("res://assets/sfx/shoot.wav")
@onready var select = preload("res://assets/sfx/select.wav")
@onready var explosion = preload("res://assets/sfx/explosion.wav")
@onready var power_up = preload("res://assets/sfx/power_up.wav")

var saw_channel
var noise_channel
var music_channel

func play_jump():
	$SawChannel.stream = jump
	$SawChannel.play()
	
func play_power_up():
	$SawChannel.stream = power_up
	$SawChannel.play()

func play_shoot():
	$NoiseChannel.stream = shoot
	$NoiseChannel.play()
	
func play_explosion():
	$NoiseChannel.stream = explosion
	$NoiseChannel.play()

func play_select():
	$SawChannel.stream = select
	$SawChannel.play()

func play_music(music):
	if !music_channel == music:
		$MusicChannel.stream = music
		$MusicChannel.play()
		music_channel = music

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

