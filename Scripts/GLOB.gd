class_name GLOB

static var DEBUG:bool = true

static func addtimer(source:Node, proc, time):
	var t = Timer.new()
	t.one_shot = true
	t.wait_time = time
	t.timeout.connect(proc)
	t.timeout.connect(func del(): t.queue_free())
	source.add_child(t)
	t.start()
