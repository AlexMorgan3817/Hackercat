extends Node

@export var msg:String

func _trigger():
	print(msg)

func _on_switch_interacted(MM:MainframeMover):
	_trigger()
