extends Node

@onready var parent: Object = get_parent()
@onready var controllable: Node = get_parent().get_node("Controllable")
@onready var movement: Node = get_parent().get_node("Movement")
@onready var player_camera: Camera2D = get_parent().get_node("PlayerCamera")
@onready var sound_chip: Node = SoundChip
@onready var basic_timer: Timer = $BasicTimer
@onready var special_timer: Timer = $SpecialTimer

@onready var root = get_node("/root/World")

@export var basic_firerate = 0.5
@export var basic_bullet_speed = 250
@export var basic_bullet_damage = 10
@export var basic_dispersion = 0.2

@export var special_firerate = 0.5
@export var special_bullet_speed = 250
@export var special_bullet_damage = 10
@export var special_dispersion = 0.2

@export var direction = Vector2.ZERO
var can_fire_basic = true
var can_fire_special = true

@export var shoot_basic = false
@export var shoot_special = false
@export var basic = preload("res://scene/Player/player_bullet.tscn")
@export var special = preload("res://scene/Player/player_grenade.tscn")

func _ready():
	basic_timer.connect("timeout", set_fire_basic)
	basic_timer.wait_time = basic_firerate
	
	special_timer.connect("timeout", set_fire_special)
	special_timer.wait_time = special_firerate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var is_up = false
	if controllable:
		if controllable.SWAP:
			if controllable.MOVE_DIR.y > 0:
				is_up = true
	
	attack_basic(is_up)
	attack_special()
	pass

func set_fire_basic():
	can_fire_basic = true
	
func set_fire_special():
	can_fire_special = true

func attack_basic(is_up):
	var shoot = shoot_basic
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
		player_camera.add_trauma(0.1)
	
	var bullet = basic.instantiate()
	bullet.position = parent.position
	bullet.damage = basic_bullet_damage
	var velocity = Vector2.ZERO

	if is_up:
		velocity = Vector2(movement.direction_face, -basic_bullet_speed)
	else:
		velocity = Vector2(movement.direction_face * basic_bullet_speed, 0.)
	bullet.launch(Vector2(velocity.x  + parent.velocity.x , velocity.y), parent.position)
	root.add_child(bullet)
	sound_chip.play_shoot()
	shoot_basic = false
	
func attack_special():
	var shoot = shoot_special
	if (controllable):
		if !controllable.SWAP:
			if controllable.ACTION_B:
				shoot = true
	
	# I don't know why false && false equals to true
	if !can_fire_special:
		return
	if !shoot:
		return

	can_fire_special = false
	special_timer.start()
	
	if (player_camera):
		player_camera.add_trauma(0.1)
	
	var special = special.instantiate()
	special.position = parent.position
	special.damage = special_bullet_damage
	var velocity = Vector2(movement.direction_face * special_bullet_speed, 0.)
	sound_chip.play_shoot()
	special.launch(Vector2(velocity.x  + parent.velocity.x , velocity.y), parent.position)
	root.add_child(special)
	shoot_special = false
