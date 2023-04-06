extends Node

func play(path:String, loop:bool = false):
	playfromstream(load(path), loop)

func playfromstream(stream:AudioStream, loop:bool = false):
	var audiosource = AudioStreamPlayer.new()
	add_child(audiosource)
	audiosource.stream = stream
	audiosource.play()
	if !loop:
		audiosource.finished.connect(
			func():
				audiosource.queue_free()
		)
	else:
		audiosource.finished.connect(
			func():
				audiosource.play()
		)

func play3d(path:String, object:Node3D, loop:bool = false):
	var audiosource = AudioStreamPlayer3D.new()
	get_tree().current_scene.add_child(audiosource)
	audiosource.global_position = object.global_position
	audiosource.stream = load(path)
	audiosource.play()
	if !loop:
		audiosource.finished.connect(
			func():
				audiosource.queue_free()
		)
	else:
		audiosource.finished.connect(
			func():
				audiosource.play()
		)
