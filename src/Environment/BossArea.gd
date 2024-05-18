extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		DiscordPresence.set_detail("Is Boss Fight")

