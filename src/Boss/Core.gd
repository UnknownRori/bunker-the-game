extends StaticBody2D

@export var cooldown_shoot = 1
@export var missile = preload("res://scene/Enemy/missile_enemy.tscn")
@onready var root = get_node("/root/World")

@onready var cooldown = $Cooldown
var can_shoot = false
var should_shoot = false
var target = null


func _ready():
	cooldown.connect("timeout", set_cooldown_set)
	cooldown.wait_time = cooldown_shoot

func set_cooldown_set():
	should_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shoot()

func shoot():
	if !can_shoot:
		return
	
	if !should_shoot:
		return
	
	should_shoot = false
	cooldown.start()
	var missile_instance = missile.instantiate()
	missile_instance.launch(Vector2(0, 50), global_position, target)
	root.add_child(missile_instance)
	

func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		target = body
