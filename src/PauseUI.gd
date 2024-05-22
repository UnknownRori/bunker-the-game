extends CanvasLayer

enum {
	CONTINUE,
	EXIT,
}

@onready var select = $Control/Select
var state := CONTINUE

var pause = false

func _ready():
	SoundChip.play_music(load("res://assets/bgm/main_menu.wav"))
	DiscordPresence.set_detail("In Main Menu")

func _process(delta):
	if pause:
		update_input()
		update_ui()
	else:
		handle_pause()
	pass

func handle_pause():
	if Input.is_action_just_pressed("Start"):
		pause = true
		visible = true
		get_tree().paused = true
	
func update_ui():
	const x := 87
	match state:
		CONTINUE:
			select.position = Vector2(x, 104)
		EXIT:
			select.position = Vector2(x, 118)

func update_input():
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up"):
		SoundChip.play_select()
	if Input.is_action_just_pressed("down"):
		match state:
			CONTINUE:
				state = EXIT
			EXIT:
				state = CONTINUE
	if Input.is_action_just_pressed("up"):
		match state:
			CONTINUE:
				state = EXIT
			EXIT:
				state = CONTINUE
	
	if Input.is_action_just_pressed("Start"):
		match state:
			CONTINUE:
				pause = false
				visible = false
				get_tree().paused = false
			EXIT:
				SceneTransition.change_scene(load("res://scene/MainMenu.tscn"))
