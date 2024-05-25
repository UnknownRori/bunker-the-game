extends Node2D

@export var number_of_turret = 2
@onready var left_left_turret = $LeftBaseTurret/LeftTurret/TurretComponent
@onready var left_right_turret = $LeftBaseTurret/RightTurret/TurretComponent
@onready var right_left_turret = $RightBaseTurret/LeftTurret/TurretComponent
@onready var right_right_turret = $RightBaseTurret/RightTurret/TurretComponent

signal boss_died
@export var explosion_count = 10

func _on_core_death():
	emit_signal("boss_died")

	$CoreExplosion.emitting = true
	for i in range(explosion_count):
		SoundChip.play_explosion()
		await get_tree().create_timer(0.2).timeout

	SceneTransition.change_scene(load("res://scene/Win.tscn"))


func _on_turret_death():
	number_of_turret -= 1
	SoundChip.play_explosion()

	if number_of_turret <= 0:
		$Core.add_to_group("enemy")
		$Core.cooldown.start()
		$Core.should_shoot = true
		$Core.can_shoot = true


func _on_boss_area_done_camera():
	left_left_turret.shoot = true
	left_right_turret.shoot = true
	right_left_turret.shoot = true
	right_right_turret.shoot = true


func _on_turret_barrel_death():
	SoundChip.play_explosion()
