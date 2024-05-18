extends Node

@export var MOVE_DIR = Vector2.ZERO
@export var ACTION_A = false
@export var ACTION_B = false
@export var START    = false
@export var SELECT   = false
@export var SWAP	 = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("Select"):
		SWAP = !SWAP
	
	if SWAP:
		if Input.is_action_pressed("up", 1.):
			input_dir.y = 1
	else:
		if Input.is_action_just_pressed("up", 1.):
			input_dir.y = 1
		
	ACTION_A =Input.is_action_just_pressed("A", 1.)
	ACTION_B =Input.is_action_just_pressed("B", 1.)
	START =Input.is_action_just_pressed("Start", 1.)
	SELECT =Input.is_action_just_pressed("Select", 1.)
	
	input_dir = input_dir.normalized()
	MOVE_DIR = input_dir
