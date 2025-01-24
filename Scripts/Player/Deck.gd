class_name Deck extends Node

@export var PC:PlayerController

@export var MaxPWR:int = 20
@export var PWR:int = 20
var Programs:Array[Program]
var ProgramLimit:int = 4
var Program_idx:int = 0

signal PWRChanged(PC:PlayerController, PWR:int)

signal ProgramPreUse(deck:Deck)
signal ProgramUsed(deck:Deck)

func _ready():
	if !PC:
		PC = get_parent()

func Ready(pc:PlayerController):
	PC = pc
	PWRChanged.emit(self, PWR)

func InitPWR(val:int):
	if val <= 0:
		push_error("Кто-то решил инициализировать (InitPWR) Deck c отрицательными PWR.")
	if val > MaxPWR:
		MaxPWR = val
	PWR = val
	PWRChanged.emit(self, PWR)

func CostPWR(i:int):
	if PWR < i: return false
	PWR -= i
	PWRChanged.emit(self, PWR)
	return true

func DeleteProgram(index:int):
	var j = 0
	for i in Programs:
		if j == index:
			i.RemoveProgram()
			return true
		j += 1
	return false

func AddProgram(p:Program) -> bool:
	if len(Programs) >= ProgramLimit:
		return false
	Programs.append(p)
	return true

func GetCurrentProgram() -> Program:
	return Programs[Program_idx]
func GetPrograms() -> Array[Program]:
	var dot = []
	for i in Programs:
		if i:
			dot.append(i)
	return dot

func UseProgram():
	ProgramPreUse.emit(self)
	GetCurrentProgram().UseProgram(self)
	ProgramUsed.emit(self)
