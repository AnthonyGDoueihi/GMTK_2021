extends Node2D


#Important Link
#https://www.youtube.com/watch?v=Lx2d5cgMj5U

var dragging = false

var selected = []

var drag_start = Vector2.ZERO
var select_rect = RectangleShape2D.new()

onready var hivemind_collider : KinematicBody2D = get_node("../KinematicBody2D")

signal move_tier(tier, creature_ids, destination)

var tier_selected = 2

func _unhandled_input(event):
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if selected.size() == 0:
				dragging = true
				drag_start = event.position
				
			else :
				var destination = event.position
				emit_signal("move_tier",tier_selected - 1, selected,event.position)
				selected = []
				
				
		elif dragging :
			dragging = false
			update()
			var drag_end = event.position
			select_rect.extents = (drag_end - drag_start) / 2
			
			var space = get_world_2d().direct_space_state
			
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape((select_rect))
			query.transform = Transform2D(0, (drag_start + drag_end) / 2 )
			
			
			for item in space.intersect_shape(query) :
				if item["collider"] == hivemind_collider :
					selected.append(item["shape"])
					
				
	elif event is InputEventKey :
		if event.scancode == KEY_2 or event.scancode == KEY_3 :
			tier_selected = event.scancode - 48
			
			
	
	if event is InputEventMouseMotion and dragging:
		update()

func _draw():
	
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
		Color(0.5,0.5,0.5), false )
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
