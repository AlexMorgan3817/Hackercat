extends Node

@export var scene:PackedScene

func _on_pressed():
	GLOB.switch_scene(self, scene)

func _on_mainframe_mover_interacted(MM):
	GLOB.switch_scene(self, scene)

func _on_if_required_amount_check_passed(MM):
	GLOB.switch_scene(self, scene)
