@icon("res://Ico/floppa.png")
extends NetAtom

class_name Player

@export var StartingPrograms:Array[Program]
@export var UI:CanvasLayer
@export var DamageOverlay:CanvasLayer
func _ready():
	#$Mover.CurrentNode = StartingNode
	super()
	if not UI:
		UI = $UI
	if not DamageOverlay:
		DamageOverlay = $DamageOverlay
	var progholder:Control
	for i in $UI.get_children():
		if i is Control and i.name == "Programs":
			progholder = i
			break
	var count = 0
	var l = len(StartingPrograms)
	if l > 0:
		for i in progholder.get_children():
			if count > l-1:
				break
			if i is ProgramFrame:
				var prog:Program = StartingPrograms[count]
				i.MyProgram = prog
				var par = prog.get_parent()
				if par:
					par.remove_child.call_deferred(prog)
				i.add_child.call_deferred(prog)
				count += 1
				if(count > l):
					break
	$Mover/EntityStatus.HealthChanged.connect($UI/HP._on_entity_status_health_changed)
	$Mover/PlayerController.PWRChanged.connect($UI/PWR._on_player_controller_pwr_changed)
	$Mover/PlayerController.set_process_mode(PROCESS_MODE_PAUSABLE)
