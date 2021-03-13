tool
extends EditorPlugin

var inspect_viewport

func _enter_tree():
	inspect_viewport = preload("res://addons/viewport-spy/viewport_inspector.gd").new()
	add_inspector_plugin(inspect_viewport)

func _exit_tree():
	remove_inspector_plugin(inspect_viewport)
