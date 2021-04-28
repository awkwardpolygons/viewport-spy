tool
extends VBoxContainer


const icon_shown = preload("res://addons/viewport-spy/ui/icons/visible.svg")
const icon_hidden = preload("res://addons/viewport-spy/ui/icons/hidden.svg")
const SpyView = preload("res://addons/viewport-spy/ui/spy_view.gd")
var object: Viewport setget set_object
var view: SpyView
var toggle: Button

func set_object(v):
	object = v
	var visible = false
	if object:
		visible = object.get_meta("__spy") if object.has_meta("__spy") else false
	if view:
		view.texture = object.get_texture() if object else null
		view.visible = visible
	if toggle:
		toggle.pressed = visible

func _init():
	view = SpyView.new()
	view.rect_min_size.y = 256.0
	view.rect_size = Vector2(256, 256)
	view.visible = false
	toggle = Button.new()
	toggle.toggle_mode = true
	toggle.text = "Preview"
	toggle.icon = icon_hidden
	toggle.connect("toggled", self, "_on_toggle_view")
	toggle.flat = true

func _enter_tree():
	add_child(view)
	add_child(toggle)
	
	set_object(object)

func _exit_tree():
	if is_instance_valid(view):
		view.texture = null
		view.queue_free()
	if is_instance_valid(toggle):
		toggle.queue_free()
		toggle.disconnect("toggled", self, "_on_toggle_view")

func _on_toggle_view(visible):
	view.visible = visible
	object.set_meta("__spy", visible)
	toggle.icon = icon_shown if visible else icon_hidden
