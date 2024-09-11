extends NetAtom

class_name Trap

@export var myMM:MainframeMover
var enabled:bool = true

signal Triggered(Target:MainframeMover)

func trigger(MM:MainframeMover):
	if not enabled or not MM.ES:
		return
	enabled = false
	Triggered.emit(MM)
