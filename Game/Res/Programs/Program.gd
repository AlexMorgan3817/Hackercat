class_name Program extends Resource

@export var Name:String
@export var Description:String
@export var requiredPWR:int = 1
@export var BaseIcon:Texture

signal ProgramFailedUse(deck:Deck)
signal ProgramUsed(deck:Deck)

func IsUsable(deck:Deck):
	if deck.PWR < requiredPWR:
		return false
	return true

func Inusable(deck:Deck):
	ProgramFailedUse.emit(deck)

func UseProgram(deck:Deck):
	if not IsUsable(deck):
		return Inusable(deck)
	ProgramUsed.emit(deck)
