class_name Trap extends NetAtom

@export var damage:int = 1
var enabled:bool = true

signal Triggered(Target:MainframeMover)

func _ready():
	super()
	$DealDamage.damage = damage

func trigger(MM:MainframeMover):
	if not enabled or not MM.ES:
		return
	enabled = false
	Triggered.emit(MM)

func place_on(n:MNode):
	GLOB.get_global_node(n).add_child(self)
	Mover.ForceMoveToNode(n, true)
	n.MovedIn.connect(trigger)
