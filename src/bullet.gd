extends Area2D

@export var velocity = Vector2.ZERO

func launch(vel: Vector2, pos: Vector2):
	velocity = vel
	position = pos
	pass

func _physics_process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	rotation = velocity.angle()
	pass


func _on_body_entered(body):
	if (body.is_in_group("platform")):
		queue_free()
