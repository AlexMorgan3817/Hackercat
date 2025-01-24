extends Node

class_name SimpleMind

@export var MM:MainframeMover
@export var Enabled = true
@export var StunsAfterAttack:bool = true
@export var ThinkingInterval:float = 0.75
@export var AttackInterval:float = 2
var ReadyToAttack:bool = true

var thinking_timer:Timer
var attack_timer:Timer

var rand:RandomNumberGenerator
signal Attack(mm:MainframeMover, target:MainframeMover)
signal AttackReloaded(mm:MainframeMover)


func _ready():
	if !MM: MM = get_parent()

	rand = RandomNumberGenerator.new()

	thinking_timer = Timer.new()
	thinking_timer.wait_time = ThinkingInterval
	thinking_timer.timeout.connect(life)
	add_child(thinking_timer)
	thinking_timer.start()
	MM.PreMovetime = ThinkingInterval - 0.05
	
	attack_timer = Timer.new()
	attack_timer.wait_time = AttackInterval
	attack_timer.timeout.connect(_attack_reload)
	attack_timer.one_shot = true
	add_child(attack_timer)

func life():
	if not Enabled or not MM.CurrentNode:
		return
	if ReadyToAttack:
		for i in MM.CurrentNode.Links:
			if not is_instance_valid(i): continue
			for j in i.Content:
				if not is_instance_valid(j): continue
				if j.Host is Player:
					ReadyToAttack = false
					Attack.emit(MM, j)
					attack_timer.start()
					return
	elif StunsAfterAttack:
		return
	if len(MM.CurrentNode.UndirrectedLinks) == 0:
		return
	var target:MNode = select_next_move()
	if target:
		MM.move(target)

func select_next_move() -> MNode:
	var target = MM.CurrentNode.UndirrectedLinks[
		rand.randi_range(0, len(MM.CurrentNode.UndirrectedLinks) - 1)
	]
	if(MM.CanMoveTo(target)):
		return target
	return null

func _attack_reload():
	ReadyToAttack = true
	AttackReloaded.emit(MM)
