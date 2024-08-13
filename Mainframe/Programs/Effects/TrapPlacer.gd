extends Node

@export var TrapScene:PackedScene

func UseProgram(MM:MainframeMover):
	assert(TrapScene)
	var k:Trap = TrapScene.instantiate()
	k.myMM.CurrentNode = MM.CurrentNode
	PlaySound.get_global_node(MM.CurrentNode).add_child(k)
	k.myMM.MoveToNode(MM.CurrentNode)
	MM.CurrentNode.connect("MovedIn", k.trigger)

func _on_program_program_used(MM:MainframeMover):
	UseProgram(MM)
