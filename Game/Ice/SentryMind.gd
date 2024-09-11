extends Node

@export var MM:MainframeMover
@export var Enabled = true
#@export var AttackPreventsMove:bool = true

@export var AttackTimeout:Timer
var ReadyToAttack:bool = true
signal Attack(MM:MainframeMover, target:MainframeMover)

var rand:RandomNumberGenerator
func _ready():
	rand = RandomNumberGenerator.new()

func select_next_move() -> MNode:
	var target = MM.CurrentNode.UndirrectedLinks[
		rand.randi_range(0, len(MM.CurrentNode.UndirrectedLinks) - 1)
	]
	if(MM.CanMoveTo(target)):
		return target
	return null

func _on_timer_timeout():
	if not Enabled or not MM.CurrentNode:
		return
	var dot = false
	for i in MM.CurrentNode.Links:
		if not is_instance_valid(i):
			continue
		for j in i.Content:
			if not is_instance_valid(j):
				continue
			if j.PC != null:
				dot = true
				if ReadyToAttack:
					Attack.emit(MM, j)
	if dot and ReadyToAttack:
		ReadyToAttack = false
		AttackTimeout.start()
		return
	if len(MM.CurrentNode.UndirrectedLinks) == 0:
		return
	var target:MNode = select_next_move()
	if target:
		MM.MoveToNode(target)

func _on_attack_timeout_timeout():
	ReadyToAttack = true
