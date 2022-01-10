extends Node2D

var path2d: Path2D
var mouseDown = false
var localToScene = false

func _on_RemovePath2DButton_pressed():
	if path2d and is_instance_valid(path2d):
		path2d.queue_free()
		path2d = null
	pass

func addPath2D():
	var Path2DScene = preload("res://LocalPath2D.tscn") if localToScene else preload("res://Path2D.tscn")
	var path2d = Path2DScene.instance()
	add_child(path2d)
	self.path2d = path2d
	print("resource_local_to_scene: ", path2d.get_curve().resource_local_to_scene)
	pass

func addPoint(point: Vector2):
	if !path2d:
		addPath2D()
	var curve = path2d.get_curve()
	var prev_point = curve.get_point_position(curve.get_point_count() - 1)
	if prev_point == point:
		return
	path2d.get_curve().add_point(point)
	path2d.update()
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		mouseDown = event.is_pressed()
		addPoint(event.position)
	elif event is InputEventMouseMotion:
		if mouseDown:
			addPoint(event.position)
	pass


func _on_LocalToSceneToggleCheckButton_toggled(button_pressed):
	localToScene = button_pressed


func _on_ClearPointsButton_pressed():
	if path2d:
		path2d.get_curve().clear_points()
		path2d.update()
