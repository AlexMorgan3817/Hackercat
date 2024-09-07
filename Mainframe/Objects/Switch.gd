@icon("res://Ico/Switch.png")
extends NetAtom

class_name Switch

@export var target:Array[DoorEntity]

func _ready():
	super()
	$ToogleDoor.targets = target
