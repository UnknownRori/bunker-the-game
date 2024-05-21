extends Area2D

@onready var timer = $Timer
@export var damage = 10
@export var damage_timer = 0.5
var take_damage = false
var lists = []

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", set_take_damage)
	timer.wait_time = damage_timer
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if take_damage:
		take_damage = false
		for i in lists:
			var hp = i.get_node("Health")
			if hp:
				hp.damage(damage)

func set_take_damage():
	take_damage = true

func _on_body_entered(body):
	if !body.is_in_group("platform"):
		lists.append(body)


func _on_body_exited(body):
	if !body.is_in_group("platform"):
		var index = lists.find(body)
		lists.remove_at(index)
