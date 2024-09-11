extends Node

@export var sound:AudioStream
@export var Host:Node2D
@export var volume:float = 0

func trigger():
	PlaySound.playsound(Host, sound, volume)

func _on_trap_triggered(_MM:MainframeMover):     trigger()
func _on_collectable_picked_up():                trigger()
func _on_lance_program_used(_MM:MainframeMover): trigger()
func _on_trapper_program_used(_MM):              trigger()
func _on_switch_interacted(MM):                  trigger()
func _on_simple_mind_attack(MM, target):         trigger()
func _on_entity_status_took_damage(ES, currentHits):trigger()
func _on_mainframe_mover_interacted(MM):         trigger()
func _on_entity_status_death(ES):                trigger()
