extends StaticBody2D

@export var closed = false

func _ready():
	if closed:
		close()
	else:
		open()

func close():
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	$Sprite.play("active")

func open():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	$Sprite.play("off")
