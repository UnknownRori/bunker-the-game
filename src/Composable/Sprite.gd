extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

@export var state := IDLE

enum {
	IDLE
}

func _ready():
	play("idle")

func play_damage():
	match state:
		IDLE: 
			animation_player.play("damage")
			
