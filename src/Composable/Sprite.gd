extends AnimatedSprite2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

enum STATE {IDLE,WALKING,SHOOT,UP, DEAD}
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
		STATE.UP:
			play("up")
		STATE.DEAD:
			play("dead")

func play_damage():
	animation_player.play("damage")
