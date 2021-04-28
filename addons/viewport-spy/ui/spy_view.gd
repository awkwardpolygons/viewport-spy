tool
extends TextureRect


const checkerboard = preload("res://addons/viewport-spy/ui/icons/checkerboard.svg")
var viewer: TextureRect

func set_texture(v):
	viewer.set_texture(v)

func get_texture():
	return viewer.get_texture()

func _set(property, value):
	if property == "texture":
		set_texture(value)
		return true
	return false

func _init():
	stretch_mode = TextureRect.STRETCH_TILE
	texture = checkerboard
	viewer = TextureRect.new()
	viewer.expand = true
	viewer.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	viewer.anchor_top = ANCHOR_BEGIN
	viewer.anchor_left = ANCHOR_BEGIN
	viewer.anchor_bottom = ANCHOR_END
	viewer.anchor_right = ANCHOR_END

func _enter_tree():
	add_child(viewer)

func _exit_tree():
	if is_instance_valid(viewer):
		viewer.texture = null
		viewer.queue_free()
