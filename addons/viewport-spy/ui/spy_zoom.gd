tool
extends PopupPanel


const SpyView = preload("res://addons/viewport-spy/ui/spy_view.gd")
var texture: Texture setget set_texture
var view: SpyView

func set_texture(v):
	texture = v
	view.texture = v

func _init():
#	mouse_filter = Control.MOUSE_FILTER_IGNORE
	view = SpyView.new()
	view.anchor_top = ANCHOR_BEGIN
	view.anchor_left = ANCHOR_BEGIN
	view.anchor_bottom = ANCHOR_END
	view.anchor_right = ANCHOR_END
	view.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _enter_tree():
	add_child(view)

func _exit_tree():
	if is_instance_valid(view):
		texture = null
		view.queue_free()
