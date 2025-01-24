@icon("res://Textures/Ico/EnterPoint_ico.png")
extends NetAtom

@export var RequiredAmountOfProgs:int = 0 # REWORK TO Array[Objective]; Objective extends Resource
@export var scene:PackedScene

func _ready():
	super()
	$Mover.Interacted.connect(_interacted)

func _interacted(MM:MainframeMover):
	if MM.PC and len(MM.PC.GetPrograms()) >= RequiredAmountOfProgs:
		GLOB.switch_scene(self, scene)
