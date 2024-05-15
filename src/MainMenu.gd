extends Control

enum {
	START_GAME,
	HELP,
	EXIT,
}

@onready var select = $Select
@onready var sound = SoundChip
@onready var state := START_GAME

func _ready():
	SoundChip.play_music(load("res://assets/bgm/bgm.wav"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_input()
	update_ui()
	pass
	
func update_ui():
	const x := 95
	match state:
		START_GAME:
			select.position = Vector2(x, 154)
		HELP:
			select.position = Vector2(x, 167)
		EXIT:
			select.position = Vector2(x, 182)

func update_input():
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up"):
		sound.play_select()
	if Input.is_action_just_pressed("down"):
		match state:
			START_GAME:
				state = HELP
			HELP:
				state = EXIT
			EXIT:
				state = START_GAME
	if Input.is_action_just_pressed("up"):
		match state:
			START_GAME:
				state = EXIT
			HELP:
				state = START_GAME
			EXIT:
				state = HELP
	
	if Input.is_action_just_pressed("Start"):
		match state:
			START_GAME:
				SceneTransition.change_scene(load("res://scene/world.tscn"))
			HELP:
				SceneTransition.change_scene(load("res://scene/Help.tscn"))
			EXIT:
				get_tree().quit()
