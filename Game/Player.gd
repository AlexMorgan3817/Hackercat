@icon("res://Textures/Ico/floppa.png")
class_name Player extends NetAtom

@export var StartingPrograms:Array[Program] = [null, null, null, null]
@export var ProgramsLimit:int = 4

@export var UI:CanvasLayer
@export var DamageOverlay:CanvasLayer

func _ready():
	#$Mover.CurrentNode = StartingNode
	super()
	if not UI:
		UI = $UI
	if not DamageOverlay:
		DamageOverlay = $DamageOverlay
	$Mover/EntityStatus.HealthChanged.connect($UI/HP._on_entity_status_health_changed)
	$Mover/PlayerController.PWRChanged.connect($UI/PWR._on_player_controller_pwr_changed)
	$Mover/PlayerController.set_process_mode(PROCESS_MODE_PAUSABLE)
	for i in StartingPrograms:
		$Mover/PlayerController.AddProgram(i)
