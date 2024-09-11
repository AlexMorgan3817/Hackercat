extends Node


func trigger(MM:MainframeMover):
	MM.Host.queue_free()


func _on_trap_triggered(MM:MainframeMover):
	trigger(MM)
