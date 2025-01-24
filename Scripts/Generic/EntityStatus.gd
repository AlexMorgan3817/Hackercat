extends Node

class_name EntityStatus

@export var MaxHits:int = 4
@export var CurrentHits:int = 4
@export var Armor:int = 0
@export var IsTakingDamage:bool = true

signal HealthChanged(ES:EntityStatus, currentHits:int)
signal TookDamage(ES:EntityStatus, currentHits:int)
signal Healed(ES:EntityStatus, currentHits:int)
signal Death(ES:EntityStatus)

static func GetEntityStatus(character:Node):
	var cchildren = character.get_children()
	for c in cchildren:
		if c is EntityStatus:
			return c

func AmIAlive():
	if(CurrentHits <= 0):
		return false
	return true

func _setHealth(value:int):
	if CurrentHits - value < 0:
		Healed.emit(self, value)
	elif CurrentHits - value > 0:
		TookDamage.emit(self, value)
	else:
		return
	CurrentHits = value
	HealthChanged.emit(self, CurrentHits)
	if not AmIAlive():
		Death.emit(self)

func TakeDamage(value:int):
	if not IsTakingDamage:
		return
	if value <= 0 or CurrentHits == 0:
		return 0
	var result = CurrentHits - max(0, value - Armor)
	if result < 0:
		return
	_setHealth(result)

func RestoreHealth(value:int):
	if value <= 0 or CurrentHits == MaxHits:
		return 0
	_setHealth(min(CurrentHits + value, MaxHits))
