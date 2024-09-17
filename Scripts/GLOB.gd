class_name GLOB

static var DEBUG:bool = false
static var glob_node:Node

static func addtimer(source:Node, proc, time, loop = false):
	var t = Timer.new()
	t.one_shot = !loop
	t.wait_time = time
	t.timeout.connect(proc)
	if not loop:
		t.timeout.connect(func del(): t.queue_free())
	source.add_child(t)
	t.start()
	return t

static func get_global_node(node:Node):
	var d = node
	while d and not (d is Scene):
		d = d.get_parent()
	if d:
		glob_node = d
	return d

static func switch_scene(src:Node, scene:PackedScene):
	glob_node = null
	src.get_tree().change_scene_to_packed(scene)
