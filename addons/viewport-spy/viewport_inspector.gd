tool
extends EditorInspectorPlugin

const Spy = preload("res://addons/viewport-spy/ui/spy.gd")

func can_handle(object):
	return object is Viewport

func parse_begin(object):
	var spy = Spy.new()
	spy.object = object
	add_custom_control(spy)
