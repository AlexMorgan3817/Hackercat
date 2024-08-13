extends Node2D

class_name Program

@export var Name:String
@export var Description:String
@export var requiredPWR:int = 1

signal ProgramFailedUse(MM:MainframeMover)
signal ProgramUsed(MM:MainframeMover)

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		Destroy()

func Destroy():
	pass

func IsUsable(MM:MainframeMover):
	if MM.PC.PWR < requiredPWR:
		return false
	return true

func Inusable(MM:MainframeMover):
	emit_signal("ProgramFailedUse", MM)

func UseProgram(MM:MainframeMover):
	emit_signal("ProgramUsed", MM)

