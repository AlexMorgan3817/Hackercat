extends Node

class_name MainframeMover

@export var Host:Node2D
@export var CurrentNode:MNode
@export var Dense:bool

@export var PC:PlayerController = null
@export var ES:EntityStatus = null

@export var enabled:bool = true

var PreMovetime:float = 0.7

var current_move_timer:Timer = null

var targetNode:MNode = null

signal Moved(N:MNode)
signal Bumped(MMCollided:MainframeMover)
signal Interacted(MM:MainframeMover)
signal AnimatePreMovement(MM:MainframeMover, N:MNode)
signal AnimatePreMoveFailed(MM:MainframeMover, N:MNode)
signal AnimateFinishMovement(MM:MainframeMover, N:MNode)

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if CurrentNode and !CurrentNode.is_queued_for_deletion():
			CurrentNode.Content.erase(self)

func _ready():
	if !Host:
		Host = get_parent()
	#assert(CurrentNode, "Mainframe mover can't work without initial CurrentNode value")
	#ForceMoveToNode(CurrentNode)

func CanMoveTo(n:MNode):
	return enabled && n.ArePassing(self)

func move(n:MNode):
	targetNode = n
	AnimatePreMovement.emit(self, n)
	if not current_move_timer:
		current_move_timer = GLOB.newtimer(self, PreMovetime)
		current_move_timer.timeout.connect(MoveToTargetNode)
	current_move_timer.start()

func MoveToTargetNode():
	if not targetNode:
		return
	var canpass = true
	if Dense:
		for i in targetNode.Content:
			if i.Dense:
				canpass = false
				break
	if canpass:
		ForceMoveToNode(targetNode)
	else:
		AnimatePreMoveFailed.emit(self, targetNode)
	targetNode = null

func ForceMoveToNode(n:MNode):
	if not n:
		return
	assert(n is MNode)
	Host.set_global_position(n.get_global_position())
	if CurrentNode:
		CurrentNode.MovedOut.emit(self)
		CurrentNode.Content.erase(self)

	CurrentNode = n
	n.Content.append(self)
	n.MovedIn.emit(self)
	Moved.emit(n)
	AnimateFinishMovement.emit(self, n)
