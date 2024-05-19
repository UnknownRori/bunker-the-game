extends Node

@onready var parent: StaticBody2D = get_parent()
@onready var attack: Node = get_parent().get_node("AttackComponent")
@onready var rotation_marker: Marker2D = get_parent().get_node("RotationMarker")
@onready var player_detection: Area2D = get_parent().get_node("PlayerDetection")

@export var shoot: bool = true

var target: CharacterBody2D = null
# Set it ready to shoot
var track_ready = false

func _process(delta):
	shoot_player()
	
func track_player():
	var dir
	if rotation_marker:
		dir = (target.position - rotation_marker.global_position).normalized()
	else:
		dir = (target.position - parent.global_position).normalized()
		
	var rotation = dir.angle()
	parent.rotation = rotation
	
	track_ready = true
	
	return dir

func shoot_player():
	if !target:
		return
	
	var dir = track_player()
	
	if !track_ready:
		return
	if !shoot:
		return
	
	attack.direction = dir
	attack.raw_direction = true
	attack.shoot_basic = true


func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		target = body
		


func _on_player_detection_body_exited(body):
	if body == target:
		track_ready = false
		target = null
