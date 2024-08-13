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

func CanMoveTo(n:MNode):
	return n.ArePassing(self)

func MoveToNode(n:MNode):
	assert(n is MNode)
	Host.set_global_position(n.get_global_position())
	CurrentNode.emit_signal("MovedOut", self)
	CurrentNode.Content.erase(self)

	CurrentNode = n
	n.Content.append(self)
	n.emit_signal("MovedIn", self)
	emit_signal("Moved", n)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(CurrentNode, "Mainframe mover can't work without initial CurrentNode value")
	MoveToNode(CurrentNode)
