extends AudioStreamPlayer2D

@export var timeoffset = 5
@export var RepeatTimer:Timer

func _ready():
	start()
	RepeatTimer.start()
	RepeatTimer.connect("timeout", start)

func start():
	var l = stream.get_length()
	playing = true
	RepeatTimer.wait_time = l - timeoffset
	RepeatTimer.start()
