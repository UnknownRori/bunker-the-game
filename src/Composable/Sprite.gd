extends AnimatedSprite2D

@export var state = IDLE

enum {
	IDLE
}

func play_damage():
	match state:
		IDLE: 
			play("idle_damage")
			await get_tree().create_timer(0.1).timeout
			play("idle")
			
