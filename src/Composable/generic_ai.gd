extends Node
@onready var parent = get_parent()
@onready var movement = get_parent().get_node("Movement")
@onready var attack = get_parent().get_node("AttackComponent")

enum {
	SIMPLE_WANDER,
	SHOOTING,
	CHASING,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
