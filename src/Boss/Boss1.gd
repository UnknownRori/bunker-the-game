extends Node2D

@export var number_of_turret = 2
@onready var left_left_turret = $LeftBaseTurret/LeftTurret/TurretComponent
@onready var left_right_turret = $LeftBaseTurret/RightTurret/TurretComponent
@onready var right_left_turret = $RightBaseTurret/LeftTurret/TurretComponent
@onready var right_right_turret = $RightBaseTurret/RightTurret/TurretComponent

func _on_core_death():
	SceneTransition.change_scene(load("res://scene/Win.tscn"))


func _on_turret_death():
	number_of_turret -= 1
	SoundChip.play_explosion()
	if number_of_turret <= 0:
		$Core.add_to_group("enemy")
		$Core.cooldown.start()
		$Core.can_shoot = true


func _on_boss_area_done_camera():
	left_left_turret.shoot = true
	left_right_turret.shoot = true
	right_left_turret.shoot = true
	right_right_turret.shoot = true


func _on_turret_barrel_death():
	SoundChip.play_explosion()
