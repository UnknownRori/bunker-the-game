extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

enum STATE {IDLE,WALKING,SHOOT}
@export var state: STATE = STATE.IDLE

func _ready():
	play("idle")

func set_state(new_state: STATE):
	await animation_looped
	state = new_state

func _process(delta):
	match state:
		STATE.IDLE:
			play("idle")
		STATE.WALKING:
			play("walking")
		STATE.SHOOT:
			play("shoot")

func play_damage():
	match state:
		STATE.IDLE: 
			animation_player.play("damage")
			
