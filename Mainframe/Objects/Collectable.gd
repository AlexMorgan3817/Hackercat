extends Node

@export var Prog:PackedScene

signal PickedUp

func trigger(MM:MainframeMover):
	var player:PlayerController = MM.PC
	if not player:
		return
	if player.AddProgram(Prog):
		emit_signal("PickedUp")

func _on_node_interacted(MM:MainframeMover):
	trigger(MM)

func _on_mainframe_mover_interacted(MM):
	trigger(MM)
