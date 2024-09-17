extends Node2D

class_name NetAtom

@export var StartingNode:MNode
@export var Mover:MainframeMover

func findNode():
	var p = get_parent()
	print("Parent: ", p, "; IAM: ", self)
	var prev:MNode = null
	for i in p.get_children():
		print("\t" + str(prev) + "\t" + str(i))
		if i == self:
			StartingNode = prev
			break
		if i is MNode:
			prev = i
func _ready():
	if !Mover:
		Mover = $Mover
	if !StartingNode:
		findNode()
	if StartingNode:
		Mover.ForceMoveToNode(StartingNode)
