@icon("res://Textures/Ico/Switch.png")
class_name Switch extends NetAtom
@export var target:Array[DoorEntity]

func _ready():
	super()
	$ToogleDoor.targets = target
