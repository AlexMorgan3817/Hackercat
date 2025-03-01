class_name PlayerController extends Node

@export var MM:MainframeMover
@export var MyDeck:Deck
@export var Enabled = true

@export var SelectedIdicator:Node2D
var EpsilonForSelection:float = 0.3
var SelectedNode:MNode

@export var MoveDelayTime:float = 0.55
@export var InteractionDelayTime:float = 0.5
@export var ProgramUseDelayTime:float = .5
@export var ProgramSwitchDelayTime:float = .1

var MoveDelay         :Timer
var InteractionDelay  :Timer
var ProgramUseDelay   :Timer
var ProgramSwitchDelay:Timer

var CanMove       :bool = true
var CanInteract   :bool = true
var CanUsePrograms:bool = true
var CanSwitch     :bool = true

signal DescProg(pc:PlayerController, p:Program)

func _ready():
	MoveDelay           = GLOB.create_timer_if_need(self, MoveDelay                 , func(): CanMove        = true, MoveDelayTime)
	InteractionDelay    = GLOB.create_timer_if_need(self, InteractionDelay          , func(): CanInteract    = true, InteractionDelayTime)
	ProgramUseDelay     = GLOB.create_timer_if_need(self, ProgramUseDelay           , func(): CanUsePrograms = true, ProgramUseDelayTime)
	ProgramSwitchDelay  = GLOB.create_timer_if_need(self, ProgramSwitchDelay , func(): CanSwitch = true, ProgramSwitchDelayTime)
	if !MM: MM = get_parent()
	MM.PreMovetime = MoveDelayTime - 0.05
	if !MyDeck:
		for i in get_children():
			if i is Deck:
				MyDeck = i
				break
	if !MyDeck:
		MyDeck = Deck.new()
		add_child(MyDeck)
	MyDeck.PC = self
	MyDeck.ProgramPreUse.connect(  func(deck:Deck):
		CanUsePrograms = false
	)
	MyDeck.ProgramUsed.connect(    func(deck:Deck):
		ProgramUseDelay.start()
	)

func _process(_delta):
	if !MM.CurrentNode:
		return
	if CanUsePrograms and Input.is_action_just_pressed("ActivateProgram"):
		return MyDeck.UseProgram()
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
					# Moved.emit(MM.CurrentNode, nextNode)
					MM.move(nextNode)
	if CanInteract:
		if Input.is_action_just_pressed("Interact"):
			cooldown_interaction()
			MM.Interact(MM.CurrentNode)
			# MM.CurrentNode.Interacted.emit(MM)
			return
		if SelectedNode and Input.is_action_just_pressed("InteractRemote"):
			cooldown_interaction()
			MM.Interact(SelectedNode)
			# SelectedNode.Interacted.emit(MM)
			return
	if CanSwitch:
		if Input.is_action_just_pressed("SwitchLeft"):
			MyDeck.PrevProgram()
			switch_interaction()
			return
		if Input.is_action_just_pressed("SwitchRight"):
			MyDeck.NextProgram()
			switch_interaction()
			return
	if Input.is_action_just_pressed("DescProgram"):
		DescProg.emit(self, MyDeck.GetCurrentProgram())

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

func switch_interaction():
	ProgramSwitchDelay.start()
	CanSwitch = false
func cooldown_interaction():
	InteractionDelay.start()
	CanInteract = false

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
