extends Node

@onready var parent: StaticBody2D = get_parent()
@onready var attack: Node = get_parent().get_node("AttackComponent")
@onready var player_detection: Area2D = get_parent().get_node("PlayerDetection")

var track_ready = false

func _process(delta):
	shoot_player()
	
func track_player():
	pass

func shoot_player():
	pass

func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		track_player()
