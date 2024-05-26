extends CharacterBody2D

@onready var player_detector = $PlayerDetector
@onready var sprite = $Sprite
@onready var explosion_radius = $ExplosionRadius
@onready var timer = $Timer

@export var damage = 10
@export var explosion_delay = 1.5
@export var max_speed = 150
@export var acceleration = 50

var bombing = false
var ready_explode = false

var target = null

var explosion_sprite = preload("res://scene/Environment/ExplodingSprite.tscn")
@onready var camera = get_node("/root/World/Player/PlayerCamera")

enum STATE {
	IDLE,
	CHASE,
	EXPLODING,
}

var state: STATE = STATE.IDLE

func _ready():
	timer.connect("timeout", timer_timeout)
	timer.wait_time = explosion_delay

func timer_timeout():
	ready_explode = true
	
func init_explosion_timer():
	timer.start()
	bombing = true
	
func _process(delta):
	match state:
		STATE.IDLE:
			if target:
				state = STATE.CHASE
			move_and_slide()
		STATE.CHASE:
			var target2 = target
			if target2:
				state = STATE.IDLE
				
			var dir = (target2.position - position).normalized()
			velocity += dir * (acceleration * delta)
			move_and_slide()
		STATE.EXPLODING:
			var dir = (target.position - position).normalized()
			velocity += dir * (acceleration * delta)
			move_and_slide()

	if bombing:
		sprite.play_damage()

	if ready_explode:
		var explosion = explosion_sprite.instantiate()
		explosion.position = global_position
		get_node("/root/World").add_child(explosion)
		SoundChip.play_explosion()
		if camera:
			camera.add_trauma(0.2)
			
		var overlap = $ExplosionRadius.get_overlapping_bodies()
		for i in overlap:
			if (i.is_in_group("player")):
				var player = i.get_node("Health")
				player.damage(damage)
		queue_free()
	pass

func _on_explosion_radius_body_entered(body):
	if body.is_in_group("player"):
		init_explosion_timer()


func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		target = body


func _on_player_detector_body_exited(body):
	if state != STATE.EXPLODING:
		if body.is_in_group("player"):
			target = null
