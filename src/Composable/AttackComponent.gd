extends Node

@onready var parent = get_parent()
@onready var controllable = get_parent().get_node("Controllable")
@onready var movement = get_parent().get_node("Movement")
@onready var player_camera = get_parent().get_node("PlayerCamera")
@onready var basic_timer = $BasicTimer
@onready var special_timer = $SpecialTimer

@onready var root = get_node("/root/World")

@export var basic_firerate = 0.5
@export var bullet_speed = 250

@export var direction = Vector2.ZERO
var can_fire_basic = true

@export var basic = preload("res://scene/Player/player_bullet.tscn")

func _ready():
	basic_timer.connect("timeout", set_fire_basic)
	basic_timer.wait_time = basic_firerate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	attack_basic()
	attack_special()
	pass

func set_fire_basic():
	can_fire_basic = true

func attack_basic():
	var shoot = false
	if (controllable):
		if (controllable.ACTION_A):
			shoot = true
	
	# I don't know why false && false equals to true
	if !can_fire_basic:
		return
	if !shoot:
		return

	can_fire_basic = false
	basic_timer.start()
	
	if (player_camera):
		player_camera.add_trauma(0.2)
	
	var bullet = basic.instantiate()
	bullet.position = parent.position
	var velocity = Vector2(movement.direction_face * bullet_speed, 0.)
	bullet.launch(velocity, parent.position)
	root.add_child(bullet)
	
func attack_special():
	pass
