extends Node

@export var hp = 100
@export var max_hp = 100

@onready var controllable = get_parent().get_node("Controllable")

func damage(value) -> bool:
	hp -= value
	return is_dead()

func is_dead() -> bool:
	return hp < 0

func _process(delta):
	pass
