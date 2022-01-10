extends Path2D

class_name DrawingPath

func _draw():
	var curve = get_curve()
	var points = curve.get_baked_points()
	if points:
		draw_circle(points[0], 10, Color.green)
		if points.size() > 1:
			draw_circle(points[-1], 10, Color.red)
		draw_polyline(points, Color.blue, 5, true)
	pass
