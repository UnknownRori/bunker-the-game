extends AnimatedSprite2D

@onready var animation_player = get_node("AnimationPlayer")

@export var state := IDLE

enum {
	IDLE
}

func play_damage():
	match state:
		IDLE: 
			animation_player.play("damage")
			
