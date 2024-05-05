extends Node2D

@export var velocity = Vector2.ZERO

func launch(vel: Vector2, pos: Vector2):
	velocity = vel
	position = pos
	pass

func _physics_process(delta):
	position += velocity * delta
	print(velocity)
	pass
