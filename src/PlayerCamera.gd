extends Camera2D

@export var decay = 0.8
@export var max_offset = Vector2(100, 75)
@export var max_roll = 0.1

@onready var parent = get_parent()
@onready var hp = get_parent().get_node("Health")
@onready var hp_bar = get_node("hp_bar")

var trauma = 0.0
var trauma_power = 2

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

func _ready():
	randomize()

func update_ui():
	hp_bar.text = "[right]" + str(hp.hp) + "[/right]"

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

	update_ui()
