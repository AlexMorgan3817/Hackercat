extends Node

@export var Target:MNode

func _trigger(n:MNode):
	n.Passable = !n.Passable

func _on_switch_interacted(_MM:MainframeMover):
	if Target:
		_trigger(Target)
