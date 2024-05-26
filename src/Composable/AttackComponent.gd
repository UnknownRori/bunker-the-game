extends Node

@onready var parent: Object = get_parent()
@onready var controllable: Node = get_parent().get_node("Controllable")
@onready var sprite: AnimatedSprite2D = get_parent().get_node("Sprite")
@onready var barrel: Marker2D = get_parent().get_node("Barrel")
@onready var movement: Node = get_parent().get_node("Movement")
@onready var player_camera: Camera2D = get_parent().get_node("PlayerCamera")
@onready var inventory: Node = get_parent().get_node("Inventory")
@onready var sound_chip: Node = SoundChip
@onready var basic_timer: Timer = $BasicTimer
@onready var special_timer: Timer = $SpecialTimer

@onready var root = get_node("/root/World")

@export var should_smoke = false
@export var should_muzzle_flash = false

@export var basic_firerate = 0.5
@export var basic_bullet_speed = 250
@export var basic_bullet_damage = 10
@export var basic_dispersion = 0.2

@export var special_firerate = 0.5
@export var special_bullet_speed = 250
@export var special_bullet_damage = 10
@export var special_dispersion = 0.2

@export var direction = Vector2.ZERO
@export var raw_direction = false
var can_fire_basic = true
var can_fire_special = true

@export var shoot_basic = false
@export var shoot_special = false

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
				direction.y = controllable.MOVE_DIR.y
	if movement:
		direction.x = movement.direction_face
	
	attack_basic(is_up)
	attack_special()
	is_up = false
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
		if sprite:
			sprite.set_state(sprite.STATE.IDLE)
		return
	if inventory.basic_has == 0:
		return
	if inventory.basic_has == 0:
		return
	else:
		inventory.basic_has -= 1

	can_fire_basic = false
	basic_timer.start()
	
	if (player_camera):
		player_camera.add_trauma(0.1)
	if sprite:
		if is_up:
			sprite.state = sprite.STATE.UP
		else:
			sprite.state = sprite.STATE.SHOOT

	var bullet = inventory.basic.instantiate()
	bullet.position = parent.position
	bullet.damage = basic_bullet_damage
	var velocity = Vector2.ZERO

	if raw_direction:
		velocity = direction * basic_bullet_speed
	else:
		if is_up:
			velocity = direction * Vector2(0, -basic_bullet_speed)
		else:
			velocity = direction * Vector2(basic_bullet_speed, 0.)
	if "velocity" in parent:
		velocity.x += parent.velocity.x
	if barrel:
		var offset = 0
		if direction.x < 0:
			if movement:
				offset = direction.x * barrel.position.x
		bullet.launch(velocity, Vector2(offset + barrel.global_position.x, barrel.global_position.y))
		if should_smoke:
			var smoker = get_parent().get_node("Smoke")
			if !is_up:
				if direction.x < 0:
					smoker.position.x = -8
					smoker.position.y = 0
				if direction.x > 0:
					smoker.position.x = 8
					smoker.position.y = 0
			else:
					smoker.position.x = 3
					smoker.position.y = -5
			smoker.play("default")
		if should_muzzle_flash:
			var smoker = get_parent().get_node("MuzzleFlash")
			if !is_up:
				smoker.position.y = 0
				smoker.rotation = 0	
				if direction.x < 0:
					smoker.position.x = -8
					smoker.scale.x = -1
				if direction.x > 0:
					smoker.position.x = 8
					smoker.scale.x = 1
			else:
					if direction.x > 0:
						smoker.position.x = 3
					else:
						smoker.position.x = -3
					smoker.position.y = -5
					smoker.scale.x = 1
					smoker.rotation = deg_to_rad(-90)
			smoker.play("default")
	else:
		bullet.launch(velocity, parent.global_position)
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
	if inventory.special_has == 0:
		return
	else:
		inventory.special_has -= 1

	can_fire_special = false
	special_timer.start()
	
	if (player_camera):
		player_camera.add_trauma(0.1)
	
	var special = inventory.special.instantiate()
	special.position = parent.position
	special.damage = special_bullet_damage
	var velocity = Vector2(movement.direction_face * special_bullet_speed, 0.)
	# TODO : Make this depend on inventory
	sound_chip.play_throw()
	if barrel:
		special.launch(Vector2(velocity.x  + parent.velocity.x , velocity.y), direction.x * barrel.position + parent.position)
	else:
		special.launch(Vector2(velocity.x  + parent.velocity.x , velocity.y), parent.position)
	root.add_child(special)
	shoot_special = false
