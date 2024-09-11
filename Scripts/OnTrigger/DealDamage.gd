extends Node

@export var damage:int = 1

func trigger(ES:EntityStatus):
	ES.TakeDamage(damage)

func tMainframe(MM:MainframeMover):
	if MM.ES is EntityStatus:
		trigger(MM.ES)

func _on_trap_triggered(MM:MainframeMover):
	tMainframe(MM)

func _on_simple_mind_attack(MM:MainframeMover, target:MainframeMover):
	tMainframe(target)
