extends Node2D

var triangulo_verts = PackedVector2Array()
var hexagono_verts = PackedVector2Array()
var estrela_verts = PackedVector2Array()

var cor_contorno = Color.GOLD
var cores_interpoladas = PackedColorArray()

var textura_tile : Texture2D = load("res://Cobblestone.png")

func _ready():
	_setup_vertices()
	_gerar_cores_aleatorias()

func _setup_vertices():
	triangulo_verts = PackedVector2Array([
		Vector2(0, -50), Vector2(-50, 50), Vector2(50, 50)
	])
	
	hexagono_verts.resize(6)
	var hex_raio = 50.0
	for i in range(6):
		var angulo = (2.0 * PI * i / 6.0)
		hexagono_verts[i] = Vector2(cos(angulo) * hex_raio, sin(angulo) * hex_raio)

	estrela_verts.resize(10)
	var estrela_raio_ext = 50.0
	var estrela_raio_int = 20.0
	for i in range(10):
		var raio = estrela_raio_ext if i % 2 == 0 else estrela_raio_int
		var angulo = (2.0 * PI * i / 10.0) - (PI / 2.0) 
		estrela_verts[i] = Vector2(cos(angulo) * raio, sin(angulo) * raio)

func _gerar_cores_aleatorias():
	cor_contorno = Color(randf(), randf(), randf())
	
	cores_interpoladas.clear()
	for i in range(10):
		cores_interpoladas.append(Color(randf(), randf(), randf()))

func _draw():
	var pos_tri = Vector2(150, 150)
	var pos_hex = Vector2(150, 350)
	var pos_estrela = Vector2(150, 550)
	
	var offset_desenho = Vector2(400, 0)
	
	draw_rect(Rect2(Vector2.ZERO, get_viewport_rect().size), Color.GAINSBORO, true)

	desenhar_contorno(triangulo_verts, pos_tri)
	desenhar_interpolado(triangulo_verts, pos_tri + offset_desenho, 3)
	desenhar_tileado(triangulo_verts, pos_tri + offset_desenho * 2)

	desenhar_contorno(hexagono_verts, pos_hex)
	desenhar_interpolado(hexagono_verts, pos_hex + offset_desenho, 6)
	desenhar_tileado(hexagono_verts, pos_hex + offset_desenho * 2)
	
	desenhar_contorno(estrela_verts, pos_estrela)
	desenhar_interpolado(estrela_verts, pos_estrela + offset_desenho, 10)
	desenhar_tileado(estrela_verts, pos_estrela + offset_desenho * 2)

func _transformar_verts(verts: PackedVector2Array, pos: Vector2) -> PackedVector2Array:
	var transformados = PackedVector2Array()
	for v in verts:
		transformados.append(v + pos)
	return transformados

func desenhar_contorno(verts: PackedVector2Array, pos: Vector2):
	var verts_fechados = verts.duplicate()
	verts_fechados.append(verts[0])
	
	var verts_transformados = _transformar_verts(verts_fechados, pos)
	
	draw_polyline(verts_transformados, cor_contorno, 2.0)

func desenhar_interpolado(verts: PackedVector2Array, pos: Vector2, num_cores: int):
	var cores_para_forma = cores_interpoladas.slice(0, num_cores)
	var verts_transformados = _transformar_verts(verts, pos)
	
	draw_polygon(verts_transformados, cores_para_forma)

func desenhar_tileado(verts: PackedVector2Array, pos: Vector2):
	var verts_transformados = _transformar_verts(verts, pos)
	
	var uvs = PackedVector2Array()
	var tile_factor = 4.0 
	
	var bounds = Rect2(verts[0], Vector2.ZERO)
	for v in verts:
		bounds = bounds.expand(v)
	
	for v in verts:
		var uv = (v - bounds.position) / bounds.size
		uvs.append(uv * tile_factor)
		
	draw_polygon(verts_transformados, PackedColorArray([Color.WHITE]), uvs, textura_tile)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		_gerar_cores_aleatorias()
		queue_redraw()
