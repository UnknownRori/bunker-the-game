extends Area2D

@onready var timer = $Timer
var current_pos

var move = false
var offset = 2
var direction = 1

func _ready():
	current_pos = position
	timer.connect("timeout", set_move)
	timer.wait_time = 0.5
	timer.start()

func set_move():
	move = true

func _process(delta):
	if move:
		move = false
		direction *= -1
		
		position.y += offset * direction
		timer.start()

func _on_body_entered(body):
	if body.is_in_group("player"):
		if !body.get_node("Health").is_max():
			body.get_node("Health").restore_full()
			SoundChip.play_power_up()
			queue_free()
