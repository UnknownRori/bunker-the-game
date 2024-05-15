extends AnimatedSprite2D

@export var lifetime = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	play("explode")
	$Timer.connect("timeout", queue_free)
	$Timer.wait_time = lifetime


func _on_animation_looped():
	queue_free()
