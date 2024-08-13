extends Node

@export var Prog:Program


func _on_program_program_used(MM:MainframeMover):
	MM.PC.CostPWR(Prog.requiredPWR)
	print(MM.PC.PWR)
