extends Node

@export
var MM:MainframeMover
@export
var father:SimpleMind

var player:AnimationPlayer

var old_color:Color
func _ready():
	if !father: father = get_parent()
	father.Attack.connect(_atck)
	father.AttackReloaded.connect(_reload)
	if !MM: MM = father.MM
	if $ReloadAnimation:
		$ReloadAnimation.speed_scale = 1/father.AttackInterval
	

func _atck(mm:MainframeMover, target:MainframeMover):
	old_color = MM.Host.modulate
	if $ReloadAnimation:
		$ReloadAnimation.play("reload")
	else:
		MM.Host.modulate = Color(.25, .25, .25)

func _reload(mm:MainframeMover):
	MM.Host.modulate = old_color
