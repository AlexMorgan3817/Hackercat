extends Node

@export var Target:Timer

func trigger():
	Target.start()


func _on_trap_triggered(_Target):
	trigger()
