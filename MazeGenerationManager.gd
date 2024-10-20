extends Node2D

var maze
var EASY_DIM = 7
var MEDIUM_DIM = 12
var HARD_DIM = 20
var EXTREME_DIM = 25
var dim = 7
var offsetY = 23
var offsetX = -11
var wallunit = 160
var walls = []
var chests = []
var fish_coords: Array
var mazewall = preload("res://maze_wall.tscn")
var fishscene = preload("res://fish_prefab.tscn")
var fisharray = []
var portalscene = preload("res://portal.tscn")
var portalarray = []
var xdim
var ydim
var lefborder
var rightborder
var upborder
var downborder

var fishkarma = 0
var isBuffered = false
var bufferTimeLimit = 2.0
var bufferTime = 0.0
var karma = 0

var setOfCoords

#comment
# Called when the node enters the scene tree for the first time.
func _ready():
	#$AudioStreamPlayer.play()
	if Globalvariables.difficulty == "Easy":
		dim = EASY_DIM
	if Globalvariables.difficulty == "Medium":
		dim = MEDIUM_DIM
	if Globalvariables.difficulty == "Hard":
		dim = HARD_DIM
	if Globalvariables.difficulty == "Extreme":
		dim = EXTREME_DIM
	xdim = dim
	ydim = dim
	$AudioStreamPlayer.play()
	
	if not Globalvariables.resume:
		maze = generate_maze(xdim, ydim)
		print("MAZE: ")
		for edge in maze:
			print(edge.string_ver())
			
		for i in range (xdim):
			for j in range (ydim):
				var randomVariable = randi() % 25
				if (randomVariable == 0):
					fish_coords.append(Vector2(i, j))
					
		
		generate_walls(maze)
	else:
		maze = Globalvariables.maze
		$CatProtagonist.global_position = Globalvariables.characterPos
		fish_coords = Globalvariables.fishCoords
		fishkarma = Globalvariables.fishkarma
		generate_walls_2(maze)
	#when the player dies, regenerate the maze from the player node (call reset_variables from there)
	pass # Replace with function body.


func _on_fish_collected():
	if not isBuffered:
		fishkarma += 1
		isBuffered = true
		print("fish karma: " + str(fishkarma))

func reset_variables():
	maze = generate_maze(xdim, ydim)
	
	generate_walls(maze)
	
func generate_walls_2(maze):
	for fish in fisharray:
		fish.queue_free()
	fisharray = []
	
	for wall in walls:
		wall.queue_free()
	walls = []
	
	for chest in chests:
		chest.queue_free()
	chests = []
	
	for portal in portalarray:
		portal.queue_free()
	portalarray = []
	
	for edge in maze:
		#case 1: horizontal edge (will have to rotate the sprite by 90 degrees)
		if edge.vertex1.coords.y == edge.vertex2.coords.y:
			var wall = mazewall.instantiate()
			walls.append(wall)
			wall.add_to_group("walls")
			add_child(wall)
			wall.global_position = Vector2(min(edge.vertex1.coords.x, edge.vertex2.coords.x)*wallunit + (wallunit / 2) - offsetX, edge.vertex1.coords.y * wallunit - (wallunit / 2) + offsetY)
			print("generated wall at " + str(wall.global_position))
			wall.set_visible(true)
			pass
			
		#case 2: vertical edge
		elif edge.vertex1.coords.x == edge.vertex2.coords.x:
			
			var wall = mazewall.instantiate()
			walls.append(wall)
			wall.rotation_degrees = 90
			wall.add_to_group("walls")
			add_child(wall)
			wall.global_position = Vector2(edge.vertex1.coords.x * wallunit - offsetX, min(edge.vertex1.coords.y, edge.vertex2.coords.y)*wallunit + offsetY)
			print("generated wall at " + str(wall.global_position))
			wall.set_visible(true)
	
			pass
	
	for coord in fish_coords:	
		var fish = fishscene.instantiate()
		fisharray.append(fish)
		fish.add_to_group("fish")
		add_child(fish)
		fish.z_index = 200
		fish.collect.connect(self._on_fish_collected)
		fish.global_position = Vector2(coord.x * wallunit + (wallunit / 2), coord.y * wallunit + offsetY)
		fish.set_visible(true)
		
	setOfCoords = Globalvariables.setOfCoords
	
	var minigameindices = [0, 1]
	minigameindices.shuffle()
	
	for i in range (minigameindices.size()):
		var targetMinigame = minigameindices[i]
		var portal = portalscene.instantiate()
		portal.minigame = targetMinigame
		portalarray.append(portal)
		portal.add_to_group("portals")
		add_child(portal)
		portal.z_index = 200
		portal.global_position = Vector2(setOfCoords[i].x * wallunit + (wallunit / 2), setOfCoords[i].y * wallunit + offsetY)
		
	

func generate_walls(maze):
	for fish in fisharray:
		fish.queue_free()
	fisharray = []
	
	for wall in walls:
		wall.queue_free()
	walls = []
	
	for chest in chests:
		chest.queue_free()
	chests = []
	
	for portal in portalarray:
		portal.queue_free()
	portalarray = []
	
	for edge in maze:
		#case 1: horizontal edge (will have to rotate the sprite by 90 degrees)
		if edge.vertex1.coords.y == edge.vertex2.coords.y:
			var wall = mazewall.instantiate()
			walls.append(wall)
			wall.add_to_group("walls")
			add_child(wall)
			wall.global_position = Vector2(min(edge.vertex1.coords.x, edge.vertex2.coords.x)*wallunit + (wallunit / 2) - offsetX, edge.vertex1.coords.y * wallunit - (wallunit / 2) + offsetY)
			print("generated wall at " + str(wall.global_position))
			wall.set_visible(true)
			pass
			
		#case 2: vertical edge
		elif edge.vertex1.coords.x == edge.vertex2.coords.x:
			
			var wall = mazewall.instantiate()
			walls.append(wall)
			wall.rotation_degrees = 90
			wall.add_to_group("walls")
			add_child(wall)
			wall.global_position = Vector2(edge.vertex1.coords.x * wallunit - offsetX, min(edge.vertex1.coords.y, edge.vertex2.coords.y)*wallunit + offsetY)
			print("generated wall at " + str(wall.global_position))
			wall.set_visible(true)
	
			pass
	
	for coord in fish_coords:	
		var fish = fishscene.instantiate()
		fisharray.append(fish)
		fish.add_to_group("fish")
		add_child(fish)
		fish.z_index = 200
		fish.collect.connect(self._on_fish_collected)
		fish.global_position = Vector2(coord.x * wallunit + (wallunit / 2), coord.y * wallunit + offsetY)
		fish.set_visible(true)
			
			
	var minigameindices = [0, 1, 2]
	minigameindices.shuffle()
	
	setOfCoords = []
	for i in range (xdim):
		for j in range (xdim):
			setOfCoords.append(Vector2(i, j))	
	setOfCoords.shuffle()
	
	#spawn portals
	for i in range (minigameindices.size()):
		var targetMinigame = minigameindices[i]
		var portal = portalscene.instantiate()
		portal.minigame = targetMinigame
		if targetMinigame == 2:
			print("parkour game: " + str(setOfCoords[i]))
		portalarray.append(portal)
		portal.add_to_group("portals")
		add_child(portal)
		portal.z_index = 200
		portal.global_position = Vector2(setOfCoords[i].x * wallunit + (wallunit / 2), setOfCoords[i].y * wallunit + offsetY)
		
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Globalvariables.fishkarma = fishkarma
	$FishLabel.text = "Fish Collected: " + str(fishkarma)
	$FishLabel.global_position = $CatProtagonist/CatCamera.get_screen_center_position() + Vector2(100, -300)
	
	$KarmaLabel.text = "Karma: " + str(Globalvariables.karma)
	$KarmaLabel.global_position = $CatProtagonist/CatCamera.get_screen_center_position() + Vector2(100, -200)
	
	$BG.global_position = $CatProtagonist/CatCamera.get_screen_center_position()
	$GiganticAssBlackScreen.global_position = $CatProtagonist/CatCamera.get_screen_center_position()
	
	
	if Globalvariables.difficulty == "Extreme":
		$GiganticAssBlackScreen.visible = true
	else:
		$GiganticAssBlackScreen.visible = false


	if isBuffered:
		bufferTime += delta
		if bufferTime > bufferTimeLimit:
			bufferTime = 0
			isBuffered = false
	
	pass





func generate_maze (m, n):
	var innervertices = []
	for i in range(m):
		for j in range (n):
			var v = Vertex.new(Vector2(i+0.5, j+0.5))
			innervertices.append(v)
	
	var inneredges = []
	for i in range (m):
		for j in range (n):
			if i < (m-1):
				var e = Edge.new(innervertices[n*i + j], innervertices[n*(i+1) + j])
				inneredges.append(e)
				
	for i in range(m):
		for j in range (n):
			if j < (n-1):
				var e = Edge.new(innervertices[n*i + j], innervertices[n*i + j + 1])
				inneredges.append(e)
				

	
	#run prims
	
	var innermazevertices = []
	var innermazeedges = []
	
	
	#pick a random starting vertex
	var startingvertex = innervertices[randi() % innervertices.size()]
	var unusedvertices = innervertices
	
	innermazevertices.append(startingvertex)
	unusedvertices.erase(startingvertex)
	
	#keep appending vertices (and edges)
	for i in range(m*n - 1):
		var foundEdge = false
		for j in range (innermazevertices.size()):
			var offset = randi() % innermazevertices.size()
			var currVertex = innermazevertices[(j + offset) % innermazevertices.size()]

			var edge_array = currVertex.edges
			var availEdges = []
			for edge in edge_array:

				if unusedvertices.has(edge.othervertex(currVertex)):
					availEdges.append(edge)

			

			if availEdges.size() > 0:
				foundEdge = true
				var edgetoappend = availEdges[randi() % availEdges.size()]
				innermazeedges.append(edgetoappend)
				innermazevertices.append(edgetoappend.othervertex(currVertex))
				var newvertex = edgetoappend.othervertex(currVertex)
				unusedvertices.erase(newvertex)
				print("new edge: " + edgetoappend.string_ver())
				print("new vertex: " + str(newvertex.coords))
				
		
			#remove the new vertex
			if foundEdge:
				break
	
	print("------------------------------------")
	

	
	var outeredges = []
	var outervertices = []
	for i in range(m+1):
		for j in range (n+1):
			var v = Vertex.new(Vector2(i, j))
			outervertices.append(v)		
	
	for i in range (m+1):
		for j in range (n+1):
			if i < m:
				var e = Edge.new(outervertices[(n+1)*i + j], outervertices[(n+1)*(i+1) + j])
				outeredges.append(e)
				
	for i in range(m+1):
		for j in range (n+1):
			if j < n:
				var e = Edge.new(outervertices[(n+1)*i + j], outervertices[(n+1)*i + j + 1])
				outeredges.append(e)
	
	var mazeedges = []
	for outeredge in outeredges:
		var intersects_inner = false
		for inneredge in innermazeedges:
			if inneredge.intersects(outeredge):
				intersects_inner = true
				
		if not intersects_inner:
			if not ((outeredge.vertex1.coords.x == xdim and outeredge.vertex1.coords.y == ydim and outeredge.vertex2.coords.x == xdim-1 and outeredge.vertex2.coords.y == ydim) or (outeredge.vertex1.coords.x == xdim-1 and outeredge.vertex1.coords.y == ydim and outeredge.vertex2.coords.x == xdim and outeredge.vertex2.coords.y == ydim)):
				mazeedges.append(outeredge)
	
	
	return mazeedges



func originally_connected (x, y):
	
	pass


class Graph:
	var edges: Array[Edge]
	var vertices: Array[Vertex]
	func _init(e: Array[Edge], v: Array[Vertex]):
		edges = e
		vertices = v
		
	
	

class Edge:
	var vertex1: Vertex
	var vertex2: Vertex
	func _init(ver1: Vertex, ver2: Vertex):
		vertex1 = ver1
		vertex2 = ver2
		ver1.add_edge(self)
		ver2.add_edge(self)
		ver1.connected_vertices.append(ver2)
		ver2.connected_vertices.append(ver1)
		
	func othervertex(ver: Vertex):
		if ver == vertex1:
			return vertex2
		elif ver == vertex2:
			return vertex1
		else:
			return null
			
	func intersects(otheredge: Edge):
		var vertex3 = otheredge.vertex1
		var vertex4 = otheredge.vertex2
		
		var is_intersect = false
		#casework on orientation
		#case 1: this edge is horizontal
		if (vertex1.coords.y == vertex2.coords.y):
			var condition1 = (vertex3.coords.x == vertex4.coords.x)
			var condition2 = (vertex1.coords.y > min(vertex3.coords.y, vertex4.coords.y))
			var condition3 = (vertex1.coords.y < max(vertex3.coords.y, vertex4.coords.y))
			var condition4 = (vertex3.coords.x > min(vertex1.coords.x, vertex2.coords.x))
			var condition5 = (vertex3.coords.x < max(vertex1.coords.x, vertex2.coords.x))
			is_intersect = condition1 and condition2 and condition3 and condition4 and condition5
			
		#case 2: this edge is vertical
		if (vertex1.coords.x == vertex2.coords.x):
			var condition1 = (vertex3.coords.y == vertex4.coords.y)
			var condition2 = (vertex1.coords.x > min(vertex3.coords.x, vertex4.coords.x))
			var condition3 = (vertex1.coords.x < max(vertex3.coords.x, vertex4.coords.x))
			var condition4 = (vertex3.coords.y > min(vertex1.coords.y, vertex2.coords.y))
			var condition5 = (vertex3.coords.y < max(vertex1.coords.y, vertex2.coords.y))
			is_intersect = condition1 and condition2 and condition3 and condition4 and condition5
			
			
		return is_intersect
		
		
	func string_ver():
		return "Edge from " + str(vertex1.coords) + " to " + str(vertex2.coords)
		
	
	pass
	

class Vertex:
	var coords: Vector2
	var edges: Array[Edge]
	var connected_vertices: Array[Vertex]
	func _init(vec: Vector2):
		edges = []
		connected_vertices = []
		coords = vec
	
	func add_edge(edge: Edge):
		edges.append(edge)
		
	func is_connected_to(othervertex: Vertex):
		return connected_vertices.has(othervertex)
		
		
		
	
