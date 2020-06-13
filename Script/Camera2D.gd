extends Camera2D
class_name MainCamera

var _previousPosition: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;

func _ready():
	current = true
	
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton && event.button_index == BUTTON_RIGHT:
		get_tree().set_input_as_handled();
		if event.is_pressed():
			_previousPosition = event.position;
			_moveCamera = true;
		else:
			_moveCamera = false;
	elif event is InputEventMouseMotion && _moveCamera:
		get_tree().set_input_as_handled();
		position += (_previousPosition - event.position);
		_previousPosition = event.position;
	if event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_DOWN && zoom<Vector2(1.5,1.5):
		zoom.x += .1
		zoom.y += .1
	elif event is InputEventMouseButton && event.button_index == BUTTON_WHEEL_UP && zoom>Vector2(0.3,0.3):
		zoom.x -= .1
		zoom.y -= .1
