tool
extends EditorPlugin


const Spy = preload("res://addons/viewport-spy/ui/spy.gd")
var inspect_viewport
var spy

func _enter_tree():
	inspect_viewport = preload("res://addons/viewport-spy/viewport_inspector.gd").new()
	add_inspector_plugin(inspect_viewport)
	spy = Spy.new()
	spy.visible = false
	add_control_to_container(EditorPlugin.CONTAINER_PROPERTY_EDITOR_BOTTOM, spy)

func _exit_tree():
	remove_inspector_plugin(inspect_viewport)
	remove_control_from_container(EditorPlugin.CONTAINER_PROPERTY_EDITOR_BOTTOM, spy)
	if is_instance_valid(spy):
		spy.queue_free()

func handles(object):
	return object is Viewport

func make_visible(visible):
	spy.visible = visible

func edit(object):
	spy.object = object
