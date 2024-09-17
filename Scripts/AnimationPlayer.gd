extends AnimationPlayer

@export var autostart:bool = false
@export var animation:String = "default"
#@export var IsLooping:bool = false
#@export var LoopingTime:float = 0
#var looptimer:Timer
func _ready():
	if autostart:
		play(animation)
	#if IsLooping:
		#looptimer = GLOB.addtimer(\
			#self, func p(): play(animation), LoopingTime, true)

func _on_entity_status_took_damage(ES, currentHits):
	play("TookDamage")

func _on_mover_animate_pre_movement(MM:MainframeMover, n:MNode):
	play("Premove")

func _on_mover_animate_finish_movement(MM, N):
	play("Moved")
