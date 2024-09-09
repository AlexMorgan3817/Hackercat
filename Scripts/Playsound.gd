extends Node2D
class_name PlaySound

var Player:AudioStreamPlayer2D
var DeathTimer:Timer

static func playsound(loc:Node2D, v:AudioStream, volume:float = 0):
	var p = PlaySound.new()
	GLOB.get_global_node(loc).add_child(p)
	p.set_global_position(loc.get_global_position())
	p.setup(v)
	p.Player.volume_db = volume
	p.startPlaying()

func _init():
	Player = AudioStreamPlayer2D.new()
	add_child(Player)
	DeathTimer = Timer.new()
	add_child(DeathTimer)
func setup(v:AudioStream):
	Player.stream = v
	DeathTimer.wait_time = v.get_length()
	DeathTimer.connect("timeout", _on_timer_timeout)

func startPlaying():
	Player.play()
	DeathTimer.start()

func _on_timer_timeout():
	queue_free()
