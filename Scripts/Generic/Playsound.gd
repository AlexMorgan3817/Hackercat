class_name PlaySound extends Node2D
var player:AudioStreamPlayer2D
var DeathTimer:Timer

signal stream_exhausted(ps:PlaySound)

static func playsound(loc:Node2D, v:AudioStream, volume:float = 1):
	var p = PlaySound.new()
	GLOB.get_global_node(loc).add_child(p)
	p.set_global_position(loc.get_global_position())
	p.setup(v)
	p.player.volume_db = volume
	p.startPlaying()
	return p

func _init():
	player = AudioStreamPlayer2D.new()
	add_child(player)
	DeathTimer = Timer.new()
	add_child(DeathTimer)

func setup(v:AudioStream):
	player.stream = v
	DeathTimer.wait_time = v.get_length()
	DeathTimer.connect("timeout", _on_timer_timeout)

func startPlaying():
	player.play()
	DeathTimer.start()

func _on_timer_timeout():
	stream_exhausted.emit(self)
	queue_free()
