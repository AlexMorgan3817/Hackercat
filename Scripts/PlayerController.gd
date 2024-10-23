extends Node

class_name PlayerController

@export var MM:MainframeMover
@export var Enabled = true

@export var MaxPWR:int = 20
@export var PWR:int = 20
#var ProgramFrames:Array[ProgramFrame]
var Programs:Array[Program]
var ProgramLimit:int = 4
var Program_idx:int = 0
var Frame:ProgramFrame

@export var SelectedIdicator:Node2D
var EpsilonForSelection:float = 0.3
var SelectedNode:MNode


@export var MoveDelayTime:float = 0.55
@export var InteractionDelayTime:float = 0.5
@export var ProgramUseDelayTime:float = .5
var MoveDelay:Timer
var InteractionDelay:Timer
var ProgramUseDelay:Timer

var CanMove       :bool = true
var CanInteract   :bool = true
var CanUsePrograms:bool = true

signal UnableToMove
signal Moved
signal PWRChanged(PC:PlayerController, PWR:int)

signal ProgramPreuse(PF:ProgramFrame)
signal ProgramUsed(PF:ProgramFrame)

func create_default_timer(timeoutcallback, time:float = 0.5):
	var t = Timer.new()
	t.one_shot = true
	t.wait_time =time
	t.timeout.connect(timeoutcallback)
	add_child(t)
	return t

func _ready():
	if !MoveDelay       :
		MoveDelay        = create_default_timer(_on_move_delay_timeout, MoveDelayTime)
	if !InteractionDelay:
		InteractionDelay = create_default_timer(_on_interaction_delay_timeout, InteractionDelayTime)
	if !ProgramUseDelay :
		ProgramUseDelay  = create_default_timer(_on_program_use_delay_timeout, ProgramUseDelayTime)
	for i in MM.Host.get_children():
		if i.name == "UI" and i is CanvasLayer:
			for j in i.get_children():
				if j is ProgramFrame:
					Frame = j
					break
			break
	PWRChanged.emit(self, PWR)

func CostPWR(i:int):
	if PWR < i:
		return false
	PWR -= i
	PWRChanged.emit(self, PWR)
	return true

func DeleteProgram(index:int):
	var j = 0
	for i in Programs:
		if j == index:
			i.RemoveProgram()
			return true
		j += 1
	return false

func AddProgram(p:Program):
	if len(Programs) >= ProgramLimit:
		return false
	Programs.append(p)
	return true

func GetPrograms():
	var dot = []
	for i in Programs:
		if i:
			dot.append(i)
	return dot

func UseProgram():
	CanUsePrograms = false
	ProgramPreuse.emit(self)
	Programs[Program_idx].UseProgram(MM)
	ProgramUsed.emit(self)
	ProgramUseDelay.start()

func _process(_delta):
	if !MM.CurrentNode:
		return
	if CanUsePrograms and Input.is_action_just_pressed("ActivateProgram"):
		return UseProgram()
	if CanMove:
		var X = sign(Input.get_axis("Left", "Right"))
		var Y = sign(Input.get_axis("Down", "Up"))
		if X != 0 or Y != 0:
			var nextNode:MNode
			if   X ==  1: nextNode = MM.CurrentNode.Links[3]
			elif X == -1: nextNode = MM.CurrentNode.Links[2]
			elif Y ==  1: nextNode = MM.CurrentNode.Links[0]
			elif Y == -1: nextNode = MM.CurrentNode.Links[1]

			if nextNode != null:
				CanMove = false
				MoveDelay.start()
				if MM.CanMoveTo(nextNode):
					Moved.emit(MM.CurrentNode, nextNode)
					MM.move(nextNode)
				else:
					UnableToMove.emit()
	if CanInteract:
		if Input.is_action_just_pressed("Interact"):
			cooldown_interaction()
			MM.CurrentNode.Interacted.emit(MM)
			return
		if SelectedNode and Input.is_action_just_pressed("InteractRemote"):
			cooldown_interaction()
			SelectedNode.Interacted.emit(MM)
			return
	if Frame and Input.is_action_just_pressed("DescProgram"):
		return Frame.examine()

	var d:Vector2i = get_discret_direction()
	SelectedNode = null
	if   d.x ==  1: SelectedNode = MM.CurrentNode.Links[3]
	elif d.x == -1: SelectedNode = MM.CurrentNode.Links[2]
	elif d.y ==  1: SelectedNode = MM.CurrentNode.Links[1]
	elif d.y == -1: SelectedNode = MM.CurrentNode.Links[0]
	
	if SelectedNode:
		SelectedIdicator.visible = true
		SelectedIdicator.set_global_position(SelectedNode.get_global_position())
	else:
		SelectedIdicator.visible = false

func cooldown_interaction():
	InteractionDelay.start()
	CanInteract = false

func _on_program_use_delay_timeout(): CanUsePrograms = true
func        _on_move_delay_timeout(): CanMove        = true
func _on_interaction_delay_timeout(): CanInteract    = true

func get_discret_direction(epsilon:float = EpsilonForSelection):
	var m:Vector2 = GLOB.get_global_node(MM.Host).get_global_mouse_position()
	m -= MM.Host.get_global_position()
	m = m.normalized()
	if abs(m.x - 1) < epsilon:
		m.x = 1
		m.y = 0
	if abs(m.x + 1) < epsilon:
		m.x = -1
		m.y = 0
	if abs(m.y - 1) < epsilon:
		m.x = 0
		m.y = 1
	if abs(m.y + 1) < epsilon:
		m.x = 0
		m.y = -1
	return m
