tool
extends TextureRect

var object: Viewport
var view: TextureRect

func _init():
	rect_min_size.y = 256.0
	rect_size = Vector2(256, 256)
	stretch_mode = TextureRect.STRETCH_TILE
	texture = preload("res://addons/viewport-spy/ui/icons/checkerboard.svg")
	view = TextureRect.new()
	view.expand = true
	view.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	view.anchor_top = ANCHOR_BEGIN
	view.anchor_left = ANCHOR_BEGIN
	view.anchor_bottom = ANCHOR_END
	view.anchor_right = ANCHOR_END
	add_child(view)

func _enter_tree():
	view.texture = object.get_texture()

func _exit_tree():
	view.texture = null
