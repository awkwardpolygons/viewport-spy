tool
extends VBoxContainer


const icon_shown = preload("res://addons/viewport-spy/ui/icons/visible.svg")
const icon_hidden = preload("res://addons/viewport-spy/ui/icons/hidden.svg")
const SpyView = preload("res://addons/viewport-spy/ui/spy_view.gd")
const SpyZoom = preload("res://addons/viewport-spy/ui/spy_zoom.gd")
var object: Viewport setget set_object
var view: SpyView
var zoom: SpyZoom
var toggle: Button
# A workaround for popup not capturing its exit click, which then gets passed
# onto underlying controls, if the spy view is still under the mouse on click
# then the popup is reopened immediately, and looks like it never closed.
var _zoom_just_hidden: bool = false

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
#	view.focus_mode = Control.FOCUS_ALL
	view.connect("gui_input", self, "_on_toggle_zoom")
	zoom = SpyZoom.new()
	zoom.connect("popup_hide", self, "_on_zoom_hide")
	toggle = Button.new()
	toggle.toggle_mode = true
	toggle.text = "Preview"
	toggle.icon = icon_hidden
	toggle.connect("toggled", self, "_on_toggle_view")
	toggle.flat = true

func _enter_tree():
	add_child(view)
	add_child(zoom)
	add_child(toggle)
	
	set_object(object)

func _exit_tree():
	if is_instance_valid(view):
		view.texture = null
		view.disconnect("gui_input", self, "_on_toggle_zoom")
		view.queue_free()
	if is_instance_valid(zoom):
		zoom.disconnect("popup_hide", self, "_on_zoom_hide")
		zoom.texture = null
		zoom.queue_free()
	if is_instance_valid(toggle):
		toggle.disconnect("toggled", self, "_on_toggle_view")
		toggle.queue_free()

func _on_toggle_view(visible):
	view.visible = visible
	object.set_meta("__spy", visible)
	toggle.icon = icon_shown if visible else icon_hidden

func _on_toggle_zoom(event):
	if !_zoom_just_hidden and event is InputEventMouseButton and event.pressed:
		zoom.texture = object.get_texture()
		zoom.popup_centered_ratio(0.6)
	_zoom_just_hidden = false

func _on_zoom_hide():
	_zoom_just_hidden = true
