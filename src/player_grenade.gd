extends Node2D

@export var velocity: Vector2 = Vector2.ZERO
@export var damage: float = 10
@export var gravity: float = 450

@onready var camera = get_node("/root/World/Player/PlayerCamera")
var explosion_sprite = preload("res://scene/Environment/ExplodingSprite.tscn")

func launch(vel: Vector2, pos: Vector2):
	velocity = vel + Vector2(0, -200)
	position = pos
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = rad_to_deg(velocity.angle())
	pass


func _on_collider_body_entered(body):
	if (body.is_in_group("platform")):
		explode()
	if (body.is_in_group("enemy")):
		explode()

func explode():
	var explosion = explosion_sprite.instantiate()
	explosion.position = position
	var root = get_node("/root/World")
	root.add_child(explosion)
	SoundChip.play_explosion()
	camera.add_trauma(0.2)
	var overlap = $ExplosionRadius.get_overlapping_bodies()
	for i in overlap:
		if (i.is_in_group("enemy")):
			var enemy_hp = i.get_node("Health")
			enemy_hp.damage(damage)

	queue_free()
