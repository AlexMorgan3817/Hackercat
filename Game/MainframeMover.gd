class_name MainframeMover extends Node
@export var Host:Node2D
@export var CurrentNode:MNode
@export var Dense:bool

@export var PC:PlayerController = null
@export var ES:EntityStatus = null

@export var enabled:bool = true
@export
var PreMovetime:float = 0.5

var current_move_timer:Timer = null

var targetNode:MNode = null

signal Moved(N:MNode, silent:bool)
signal Bumped(MMCollided:MainframeMover)
signal Interacted(MM:MainframeMover)
signal PreMovement(MM:MainframeMover, N:MNode, duration:float, silent:bool)
signal PreMoveFailed(MM:MainframeMover, N:MNode)
signal FinishMovement(MM:MainframeMover, N:MNode)

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

func move(n:MNode, silent:bool = false):
	targetNode = n
	PreMovement.emit(self, n, PreMovetime, silent)
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
				Bumped.emit(i)
				canpass = false
				break
	if canpass:
		ForceMoveToNode(targetNode)
	else:
		PreMoveFailed.emit(self, targetNode)
	targetNode = null

func ForceMoveToNode(n:MNode, silent:bool = false):
	if not n:
		return
	assert(n is MNode)
	Host.set_global_position(n.get_global_position())
	if CurrentNode:
		CurrentNode.Left(self)
	n.Join(self)
	CurrentNode = n
	Moved.emit(n, silent)
	FinishMovement.emit(self, n)

func Interact(node:MNode):
	Interacted.emit(self, node)
	node.Interacted.emit(self)
