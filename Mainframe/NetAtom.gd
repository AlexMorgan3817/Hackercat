extends Node2D

class_name NetAtom

@export var StartingNode:MNode

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
	if !StartingNode:
		findNode()
	$Mover.MoveToNode(StartingNode)
