extends Node

@export var scene:PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(scene)

func _on_mainframe_mover_interacted(MM):
	get_tree().change_scene_to_packed(scene)

func _on_if_required_amount_check_passed(MM):
	get_tree().change_scene_to_packed(scene)
