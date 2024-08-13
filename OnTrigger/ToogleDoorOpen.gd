extends Node

@export var target:Door

func trigger(MM):
	target.toogle(MM)

func _on_switch_interacted(MM):
	trigger(MM)

func _on_mainframe_mover_interacted(MM):
	trigger(MM)
