extends StaticBody2D

@export var closed = false

func _ready():
	if closed:
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		$Sprite.play("active")
	else:
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		$Sprite.play("off")

func close():
	SoundChip.play_door_sound()
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	$Sprite.play("active")

func open():
	SoundChip.play_door_sound()
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	$Sprite.play("off")
