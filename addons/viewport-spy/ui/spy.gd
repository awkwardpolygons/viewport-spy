tool
extends VBoxContainer


var object: Viewport setget set_object
var bg: TextureRect
var view: TextureRect
var toggle: Button
var icon_shown = preload("res://addons/viewport-spy/ui/icons/visible.svg")
var icon_hidden = preload("res://addons/viewport-spy/ui/icons/hidden.svg")

func set_object(v):
	object = v
	var visible = false
	if object:
		visible = object.get_meta("__spy") if object.has_meta("__spy") else false
	if view:
		view.texture = object.get_texture() if object else null
	if bg:
		bg.visible = visible
	if toggle:
		toggle.pressed = visible

func _init():
	bg = TextureRect.new()
	bg.rect_min_size.y = 256.0
	bg.rect_size = Vector2(256, 256)
	bg.stretch_mode = TextureRect.STRETCH_TILE
	bg.texture = preload("res://addons/viewport-spy/ui/icons/checkerboard.svg")
	bg.visible = false
	view = TextureRect.new()
	view.expand = true
	view.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	view.anchor_top = ANCHOR_BEGIN
	view.anchor_left = ANCHOR_BEGIN
	view.anchor_bottom = ANCHOR_END
	view.anchor_right = ANCHOR_END
	toggle = Button.new()
	toggle.toggle_mode = true
	toggle.text = "Preview"
	toggle.icon = icon_hidden
	toggle.connect("toggled", self, "_on_toggle_view")
	toggle.flat = true

func _enter_tree():
	bg.add_child(view)
	add_child(bg)
	add_child(toggle)
	
	set_object(object)

func _exit_tree():
	if is_instance_valid(bg):
		bg.queue_free()
		view.texture = null
		view.queue_free()
	if is_instance_valid(toggle):
		toggle.queue_free()
		toggle.disconnect("toggled", self, "_on_toggle_view")

func _on_toggle_view(visible):
	bg.visible = visible
	object.set_meta("__spy", visible)
	toggle.icon = icon_shown if visible else icon_hidden
