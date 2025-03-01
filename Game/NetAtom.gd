class_name NetAtom extends Node2D
@export var StartingNode:MNode
@export var Mover:MainframeMover

func _ready():
	if !Mover:
		Mover = $Mover
	if !StartingNode:
		findNode()
	if StartingNode:
		Mover.ForceMoveToNode(StartingNode, true)

func findNode():
	var p = get_parent()
	var prev:MNode = null
	for i in p.get_children():
		if i == self:
			StartingNode = prev
			break
		if i is MNode:
			prev = i
