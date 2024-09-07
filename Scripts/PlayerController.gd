extends Node

class_name PlayerController

@export var MM:MainframeMover
@export var Enabled = true

@export var MaxPWR:int = 20
@export var PWR:int = 20
var ProgramFrames:Array[ProgramFrame]

@export var SelectedIdicator:Node2D
@export var EpsilonForSelection:float = 0.3
var SelectedNode:MNode

@export var MoveDelay:Timer
@export var InteractionDelay:Timer
@export var ProgramUseDelay:Timer
var CanMove       :bool = true
var CanInteract   :bool = true
var CanUsePrograms:bool = true

signal UnableToMove
signal Moved
signal PWRChanged(PC:PlayerController, PWR:int)

signal Item1Used
signal Item2Used
signal Item3Used
signal Item4Used

func create_default_timer(timeoutcallback, time:float = 0.5):
	var t = Timer.new()
	t.one_shot = true
	t.wait_time =time
	t.timeout.connect(timeoutcallback)
	add_child(t)
	return t

func _ready():
	if !MoveDelay       : MoveDelay        = create_default_timer(_on_move_delay_timeout, 0.5)
	if !InteractionDelay: InteractionDelay = create_default_timer(_on_interaction_delay_timeout, 0.5)
	if !ProgramUseDelay : ProgramUseDelay  = create_default_timer(_on_program_use_delay_timeout, 0.5)
	var frames
	for i in MM.Host.get_children():
		if i.name == "UI" and i is CanvasLayer:
			for j in i.get_children():
				if j is Control and j.name == "Programs":
					frames = j
					break
			break
	for i in frames.get_children():
		if i is ProgramFrame:
			ProgramFrames.append(i)
			i.MM = MM
	for i in range(1, len(ProgramFrames) + 1):
		var pf = ProgramFrames[i-1]
		if(pf):
			connect("Item" + str(i) + "Used", pf.ActivateProgram)
	#if(ProgramFrames[0]): Item1Used.connect(ProgramFrames[0].ActivateProgram)
	#if(ProgramFrames[1]): Item1Used.connect(ProgramFrames[1].ActivateProgram)
	#if(ProgramFrames[2]): Item1Used.connect(ProgramFrames[2].ActivateProgram)
	#if(ProgramFrames[3]): Item1Used.connect(ProgramFrames[3].ActivateProgram)
	emit_signal("PWRChanged", self, PWR)

func CostPWR(i:int):
	if PWR < i:
		return false
	PWR -= i
	PWRChanged.emit(self, PWR)
	return true

func DeleteProgram(index:int):
	var j = 0
	for i in ProgramFrames:
		if j == index:
			i.RemoveProgram()
			return true
		j += 1
	return false

func AddProgram(p:PackedScene):
	var frame:Node2D = GetAvailableProgramFrame()
	if not frame:
		return false
	frame.SetProgram(p.instantiate())
	return true

func GetPrograms():
	var dot = []
	for i in ProgramFrames:
		if i.MyProgram:
			dot.append(i.MyProgram)
	return dot

func GetAvailableProgramFrame():
	for i in ProgramFrames:
		if not i.MyProgram:
			return i

func UseItem(s):
	CanUsePrograms = false
	emit_signal(s)
	ProgramUseDelay.start()

func _process(_delta):
	if !MM.CurrentNode:
		return
	if CanUsePrograms:
		if Input.is_action_just_pressed("Use Item 1"):
			UseItem("Item1Used")
		elif Input.is_action_just_pressed("Use Item 2"):
			UseItem("Item2Used")
		elif Input.is_action_just_pressed("Use Item 3"):
			UseItem("Item3Used")
		elif Input.is_action_just_pressed("Use Item 4"):
			UseItem("Item4Used")
	if CanMove:
		var X = sign(Input.get_axis("Left", "Right"))
		var Y = sign(Input.get_axis("Down", "Up"))
		if X != 0 or Y != 0:
			var nextNode:MNode
			if X == 1:
				nextNode = MM.CurrentNode.Links[3]
			elif X == -1:
				nextNode = MM.CurrentNode.Links[2]
			elif Y == 1:
				nextNode = MM.CurrentNode.Links[0]
			elif Y == -1:
				nextNode = MM.CurrentNode.Links[1]

			if nextNode != null:
				CanMove = false
				MoveDelay.start()
				if MM.CanMoveTo(nextNode):
					Moved.emit(MM.CurrentNode, nextNode)
					MM.MoveToNode(nextNode)
				else:
					UnableToMove.emit()
	

	if CanInteract:
		if Input.is_action_just_pressed("Interact"):
			cooldown_interaction()
			MM.CurrentNode.emit_signal("Interacted", MM)
			return
		if SelectedNode and Input.is_action_just_pressed("InteractRemote"):
			cooldown_interaction()
			SelectedNode.emit_signal("Interacted", MM)
 
	var d:Vector2i = get_discret_direction()
	SelectedNode = null
	if d.x == 1:
		SelectedNode = MM.CurrentNode.Links[3]
	elif d.x == -1:
		SelectedNode = MM.CurrentNode.Links[2]
	elif d.y == 1:
		SelectedNode = MM.CurrentNode.Links[1]
	elif d.y == -1:
		SelectedNode = MM.CurrentNode.Links[0]
	
	if SelectedNode:
		SelectedIdicator.visible = true
		SelectedIdicator.set_global_position(SelectedNode.get_global_position())
	else:
		SelectedIdicator.visible = false

func cooldown_interaction():
	InteractionDelay.start()
	CanInteract = false

func get_mouse_direction():
	var m:Vector2 = PlaySound.get_global_node(MM.Host).get_global_mouse_position()
	m -= MM.Host.get_global_position()
	m = m.normalized()
	return m

func get_discret_direction(epsilon:float = EpsilonForSelection):
	var m = get_mouse_direction()
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

func _on_move_delay_timeout():
	CanMove        = true

func _on_interaction_delay_timeout():
	CanInteract    = true

func _on_program_use_delay_timeout():
	CanUsePrograms = true
