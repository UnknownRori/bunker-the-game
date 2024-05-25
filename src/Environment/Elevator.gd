extends Node2D

@export var offset = Vector2(0, 320)
@export var duration = 5.
# TODO : Make this truly one way and add
@export var one_way = true 

var tween

var running = false

signal elevator_start
signal elevator_done

func _ready():
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_parallel(false)
	#tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", offset, duration)
	tween.tween_callback(_finish_tween)
	tween.stop()

func _start_tween():
	running = true
	emit_signal("elevator_start")
	tween.play()

func _finish_tween():
	print("test")
	running = false
	emit_signal("elevator_done")
	tween.stop()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_start_tween()
