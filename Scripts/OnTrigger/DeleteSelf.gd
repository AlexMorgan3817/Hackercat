extends Node

@export var target:Node

func trigger():
	target.queue_free()


func _on_trap_triggered(_MM:MainframeMover):
	trigger()


func _on_entity_status_death(_ES:EntityStatus):
	trigger()


func _on_delete_after_timeout():
	trigger()
