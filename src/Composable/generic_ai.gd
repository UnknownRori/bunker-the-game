extends Node

@onready var parent: Object = get_parent()
@onready var movement: Node = get_parent().get_node("Movement")
@onready var attack: Node = get_parent().get_node("AttackComponent")

@onready var front_wall_detector: RayCast2D = get_parent().get_node("FrontWallDetection")
@onready var front_floor_detector: RayCast2D = get_parent().get_node("FrontFloorDetection")
@onready var front_detector: RayCast2D = get_parent().get_node("Front")

@onready var facing = 1
@onready var continue_move = false
@onready var should_turn = false

@export_range(0., 1.) var wander_multiplier = 0.3

enum {
	SIMPLE_WANDER,
	SHOOTING,
	CHASING,
}

var state := SIMPLE_WANDER

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		SIMPLE_WANDER:
			# Change state to attack player if it exist on the raycast
			if front_detector.is_colliding() and front_detector.get_collider().is_in_group("player"):
				state = SHOOTING

			var front_floor_exist := false
			var front_blocked := false
			

			if front_wall_detector.is_colliding():
				if !front_wall_detector.get_collider().is_in_group("player"):
					front_blocked = true
			if front_floor_detector.is_colliding():
				if front_floor_detector.get_collider().is_in_group("platform"):
					front_floor_exist = true
			
			# If the it blocked then rotate
			# if the floor is doesnt exist rotate
			if !front_blocked:
				if front_floor_exist:
					continue_move = true
				else:
					continue_move = false
			else:
				continue_move = false
			
			if !continue_move:
				facing = -facing
				_flip_detector()

			movement.direction.x = facing * wander_multiplier
		SHOOTING:
			if front_detector.is_colliding() && front_detector.get_collider():
				if !front_detector.get_collider().is_in_group("player"):
					state = SIMPLE_WANDER
			else:
				state = SIMPLE_WANDER
			
			attack.shoot_basic = true

func _flip_detector():
	front_wall_detector.scale.x = -front_wall_detector.scale.x
	front_floor_detector.position.x = -front_floor_detector.position.x
	front_detector.scale.x = -front_detector.scale.x
	
