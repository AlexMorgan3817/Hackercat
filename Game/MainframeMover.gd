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

signal Moved(N:MNode)
signal Bumped(MMCollided:MainframeMover)
signal Interacted(MM:MainframeMover)
signal AnimatePreMovement(MM:MainframeMover, N:MNode)
signal AnimateFinishMovement(MM:MainframeMover, N:MNode)

func _ready():
	if !Host:
		Host = get_parent()
	#assert(CurrentNode, "Mainframe mover can't work without initial CurrentNode value")
	#ForceMoveToNode(CurrentNode)

func CanMoveTo(n:MNode):
	return enabled && n.ArePassing(self)

func MoveCleanup():
	if current_move_timer:
		var c = current_move_timer
		current_move_timer = null
		c.stop()
		c.queue_free()

func move(n:MNode):
	MoveCleanup()
	AnimatePreMovement.emit(self, n)
	current_move_timer = GLOB.addtimer(self, func(): ForceMoveToNode(n), PreMovetime)

func ForceMoveToNode(n:MNode):
	if not n:
		return
	assert(n is MNode)
	MoveCleanup()
	Host.set_global_position(n.get_global_position())
	if CurrentNode:
		CurrentNode.MovedOut.emit(self)
		CurrentNode.Content.erase(self)

	CurrentNode = n
	n.Content.append(self)
	n.MovedIn.emit(self)
	Moved.emit(n)
	AnimateFinishMovement.emit(self, n)
