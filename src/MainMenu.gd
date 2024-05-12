extends Control

enum {
	START_GAME,
	EXIT
}

@onready var select = $Select
@onready var state := START_GAME

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_input()
	update_ui()
	pass
	
func update_ui():
	const x := 75
	match state:
		START_GAME:
			select.position = Vector2(x, 124)
		EXIT:
			select.position = Vector2(x, 142)

func update_input():
	if Input.is_action_just_pressed("down"):
		match state:
			START_GAME:
				state = EXIT
			EXIT:
				state = START_GAME
	if Input.is_action_just_pressed("up"):
		match state:
			START_GAME:
				state = EXIT
			EXIT:
				state = START_GAME
	
	if Input.is_action_just_pressed("Start"):
		match state:
			START_GAME:
				get_tree().change_scene_to_file("res://scene/world.tscn")
			EXIT:
				get_tree().quit()