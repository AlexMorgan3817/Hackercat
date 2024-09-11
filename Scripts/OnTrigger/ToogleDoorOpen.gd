extends Node

@export var targets:Array[DoorEntity]

func trigger(MM):
	for target in targets:
		target.MyDoor.toogle(MM)

func _on_switch_interacted(MM):
	trigger(MM)

func _on_mainframe_mover_interacted(MM):
	trigger(MM)
