extends Node

@export var Target:MNode
@export var CurrentColor:int = 0
@export var Colors:Array[Color]

func _trigger():
	Target.set_modulate(Colors[CurrentColor])
	CurrentColor = (CurrentColor + 1) % len(Colors)


func _on_switch_interacted(_MM:MainframeMover):
	_trigger()
