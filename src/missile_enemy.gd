extends Area2D

@export var speed = 350
@export var damage: float = 10
@export var steer_force = 50.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

@onready var camera = get_node("/root/World/Player/PlayerCamera")
@onready var explosion_sprite = preload("res://scene/Environment/ExplodingSprite.tscn")

func launch(_vel: Vector2, _transform: Vector2, _target: Object):
	target = _target
	global_position = _transform
	velocity = _vel

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamp(Vector2(-speed, -speed), Vector2(speed, speed))
	rotation = velocity.angle()
	position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("platform"):
		explode()
	if body.is_in_group("player"):
		explode()

func explode():
	var explosion = explosion_sprite.instantiate()
	explosion.position = position
	var root = get_node("/root/World")
	root.add_child(explosion)
	SoundChip.play_explosion()
	camera.add_trauma(0.2)
	queue_free()
	
	var overlap = $ExplosionRadius.get_overlapping_bodies()
	for i in overlap:
		if (i.is_in_group("player")):
			var player_hp = i.get_node("Health")
			player_hp.damage(damage)
