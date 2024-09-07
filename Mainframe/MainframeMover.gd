extends Node

class_name MainframeMover

@export var Host:Node2D
@export var CurrentNode:MNode
@export var Dense:bool

@export var PC:PlayerController = null
@export var ES:EntityStatus = null


signal Moved(N:MNode)
signal Bumped(MMCollided:MainframeMover)
signal Interacted(MM:MainframeMover)

func _ready():
	if !Host:
		Host = get_parent()
	#assert(CurrentNode, "Mainframe mover can't work without initial CurrentNode value")
	#MoveToNode(CurrentNode)

func CanMoveTo(n:MNode):
	return n.ArePassing(self)

func MoveToNode(n:MNode):
	assert(n is MNode)
	Host.set_global_position(n.get_global_position())
	if CurrentNode:
		CurrentNode.MovedOut.emit(self)
		CurrentNode.Content.erase(self)

	CurrentNode = n
	n.Content.append(self)
	n.MovedIn.emit(self)
	Moved.emit(n)
