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

signal ProgramSwitched(deck:Deck, prog:Program, silent:bool)

func _ready():
	if !PC: PC = get_parent()

func Ready(NA:NetAtom):
	PWRChanged.emit(self, PWR)
	ProgramSwitched.emit(self, GetCurrentProgram(), true)

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
	if len(Programs) == 1:
		SetCurrent(0, 1)
	return true

func GetCurrentProgram() -> Program:
	if Programs.size() == 0:
		return null
	return Programs[Program_idx]

func GetPrograms() -> Array:
	var dot = []
	for i in Programs:
		if i:
			dot.append(i)
	return dot

func UseProgram():
	ProgramPreUse.emit(self)
	var p:Program = GetCurrentProgram()
	if p:
		p.UseProgram(self)
	ProgramUsed.emit(self)

func SetCurrent(v, silent = false):
	if v > len(Programs):
		return false
	Program_idx = v
	ProgramSwitched.emit(self, Programs[v], silent)
	return Programs[v]

func AdjustProgram(v):
	var res = Program_idx + v
	var l = Programs.size()
	if res < 0:
		res = l + res
	if res > l-1:
		res -= l
	print(res)
	return SetCurrent(res)

func NextProgram(): return AdjustProgram(1)

func PrevProgram(): return AdjustProgram(-1)
