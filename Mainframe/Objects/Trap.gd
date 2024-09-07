extends Node2D

class_name Trap

@export var myMM:MainframeMover

signal Triggered(Target:MainframeMover)

func trigger(MM:MainframeMover):
	if not MM.ES:
		return
	Triggered.emit(MM)
