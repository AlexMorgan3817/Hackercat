@icon("res://Ico/door.png")
extends NetAtom

class_name DoorEntity

@export var MyDoor:Door
@export var InitialState:bool = false

func _ready():
	super()
	if !MyDoor:
		MyDoor = $Door
	MyDoor.set_open(InitialState)
