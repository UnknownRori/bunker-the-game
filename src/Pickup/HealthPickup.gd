extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.get_node("Health").is_max():
			body.get_node("Health").restore_full()
			SoundChip.play_power_up()
			queue_free()
