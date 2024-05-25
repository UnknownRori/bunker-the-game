extends Node

@onready var jump = preload("res://assets/sfx/jump.wav")
@onready var shoot = preload("res://assets/sfx/shoot.wav")
@onready var select = preload("res://assets/sfx/select.wav")
@onready var explosion = preload("res://assets/sfx/explosion.wav")
@onready var power_up = preload("res://assets/sfx/power_up.wav")
@onready var hit = preload("res://assets/sfx/hit.wav")
@onready var throw = preload("res://assets/sfx/throw.wav")
@onready var door_sound = preload("res://assets/sfx/door_open_close.wav")

var saw_channel
var noise_channel
var music_channel

func play_jump():
	if !$SawChannel.playing:
		$SawChannel.stop()
	$SawChannel.stream = jump
	$SawChannel.play()
	
func play_door_sound():
	if !$SawChannel.playing:
		$SawChannel.stop()
	$SawChannel.stream = door_sound
	$SawChannel.play()
	
func play_power_up():
	if !$SawChannel.playing:
		$SawChannel.stop()
	$SawChannel.stream = power_up
	$SawChannel.play()

func play_shoot():
	if !$NoiseChannel.playing:
		$NoiseChannel.stop()
	$NoiseChannel.stream = shoot
	$NoiseChannel.play()
	
func play_hit():
	if !$SawChannel.playing:
		$SawChannel.stop()
	$SawChannel.stream = hit
	$SawChannel.play()
	
func play_throw():
	if !$SawChannel.playing:
		$SawChannel.stop()
	$SawChannel.stream = throw
	$SawChannel.play()
	
func play_explosion():
	if !$NoiseChannel.playing:
		$NoiseChannel.stop()
	$NoiseChannel.stream = explosion
	$NoiseChannel.play()

func play_select():
	if !$SawChannel.playing:
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

