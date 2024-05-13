extends Control

enum {
	START_GAME,
	EXIT
}

@onready var select = $Select
@onready var sound = SoundChip
@onready var state := START_GAME
@onready var bgm = preload("res://assets/bgm/bgm.wav")
@onready var scene_world = preload("res://scene/world.tscn")

func _ready():
	SoundChip.play_music(bgm)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_input()
	update_ui()
	pass
	
func update_ui():
	const x := 75
	match state:
		START_GAME:
			select.position = Vector2(x, 159)
		EXIT:
			select.position = Vector2(x, 177)

func update_input():
	if Input.is_action_just_pressed("down"):
		match state:
			START_GAME:
				sound.play_select()
				state = EXIT
			EXIT:
				sound.play_select()
				state = START_GAME
	if Input.is_action_just_pressed("up"):
		match state:
			START_GAME:
				sound.play_select()
				state = EXIT
			EXIT:
				sound.play_select()
				state = START_GAME
	
	if Input.is_action_just_pressed("Start"):
		match state:
			START_GAME:
				SceneTransition.change_scene(scene_world)
			EXIT:
				get_tree().quit()
