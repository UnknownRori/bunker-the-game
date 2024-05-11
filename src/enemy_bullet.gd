extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var damage: float = 10

func launch(vel: Vector2, pos: Vector2):
	velocity = vel
	position = pos
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = rad_to_deg(velocity.angle())
	pass


func _on_body_entered(body):
	if (body.is_in_group("platform")):
		queue_free()
	if (body.is_in_group("player")):
		var enemy_hp = body.get_node("Health")
		enemy_hp.damage(damage)
		queue_free()
