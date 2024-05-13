extends Node2D

@export var offset = Vector2(0, -320)
@export var duration = 1.
var tween

func _ready():
	start_tween()

func start_tween():
	tween = get_tree().create_tween().bind_node(self).set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops()
	tween.tween_property($AnimatableBody2d, "position", offset, duration / 2)
	tween.tween_property($AnimatableBody2d, "position", Vector2.ZERO, duration / 2)
