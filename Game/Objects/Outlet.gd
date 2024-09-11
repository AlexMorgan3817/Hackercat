@icon("res://Ico/EnterPoint_ico.png")
extends NetAtom

@export var RequiredAmountOfProgs:int = 0
@export var scene:PackedScene

func _ready():
	super()
	$Mover.Interacted.connect(_interacted)

func _interacted(MM:MainframeMover):
	if MM.PC and len(MM.PC.GetPrograms()) >= RequiredAmountOfProgs:
		GLOB.switch_scene(self, scene)
