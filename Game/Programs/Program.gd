class_name Program extends Resource

@export var Name:String
@export var Description:String
@export var requiredPWR:int = 1
@export var BaseIcon:Texture

var ScreenObject:ProgramFrame

signal ProgramFailedUse(MM:MainframeMover)
signal ProgramUsed(MM:MainframeMover)

func IsUsable(MM:MainframeMover):
	if MM.PC.PWR < requiredPWR:
		return false
	return true

func Inusable(MM:MainframeMover):
	ProgramFailedUse.emit(MM)

func UseProgram(MM:MainframeMover):
	ProgramUsed.emit(MM)
