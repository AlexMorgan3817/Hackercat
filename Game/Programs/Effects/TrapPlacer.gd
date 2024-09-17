extends Node

@export var TrapScene:PackedScene

func trigger(MM:MainframeMover):
	assert(TrapScene)
	var k:Trap = TrapScene.instantiate()
	k.myMM.CurrentNode = MM.CurrentNode
	MM.CurrentNode.get_parent().add_child(k)
	k.myMM.ForceMoveToNode(MM.CurrentNode)
	MM.CurrentNode.MovedIn.connect(k.trigger)

func _on_program_program_used(MM:MainframeMover):
	trigger(MM)
