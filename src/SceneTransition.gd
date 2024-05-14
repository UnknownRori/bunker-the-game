extends CanvasLayer

func change_scene(scene: PackedScene):
	$AnimationPlayer.play_backwards("SceneTransition")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(scene)
	$AnimationPlayer.play("SceneTransition")
	get_tree().paused = true
	await $AnimationPlayer.animation_finished
	get_tree().paused = false

