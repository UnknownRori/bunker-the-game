extends Node2D

@export var offset = Vector2(0, 320)
@export var duration = 5.
# TODO : Make this truly one way and add
@export var one_way = true 

var tween

var running = false

@export var one_shoot_signal = false
var signal_send_start = false
var signal_send_done = false

signal elevator_start
signal elevator_done

func _ready():
	tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS).set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", offset, duration)
	tween.tween_callback(_finish_tween)
	tween.stop()

func _start_tween():
	running = true
	if one_shoot_signal:
		if !signal_send_start:
			emit_signal("elevator_start")
			signal_send_start = true
	else:
		emit_signal("elevator_start")
	tween.play()

func _finish_tween():
	running = false
	if one_shoot_signal:
		if !signal_send_done:
			emit_signal("elevator_done")
			signal_send_done = true
	else:
		emit_signal("elevator_done")
	tween.stop()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		_start_tween()
