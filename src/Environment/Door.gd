extends StaticBody2D


func close():
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	$Sprite.play("active")

func open():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	$Sprite.play("off")
