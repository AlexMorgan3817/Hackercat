extends Node

@export var RequiredAmount:int = 0

signal CheckPassed(MM:MainframeMover)

func trigger(MM:MainframeMover):
	if MM.PC and len(MM.PC.GetPrograms()) >= RequiredAmount:
		CheckPassed.emit(MM)

func _on_mainframe_mover_interacted(MM):
	trigger(MM)
