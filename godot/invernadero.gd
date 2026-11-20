extends Node2D

enum Battery { GROUND, HAND, BENCH, INSTALLED }

const BANK := Vector2(155, 370)
const PLAN := Vector2(520, 161)
const WATER := Vector2(710, 211)
const FAN := Vector2(831, 211)
const EXIT := Vector2(874, 431)
const FLOOD := Rect2(278, 122, 145, 242)
const CREAM := Color("#ecf5da")
const MUTED := Color("#a9c799")

var lina: Vector2
var loose_battery: Vector2
var battery: Battery
var tested: bool
var watering: bool
var finished: bool
var notice: String
var elapsed := 0.0


func _ready() -> void:
	reset()
	if "--smoke" in OS.get_cmdline_user_args():
		smoke_test()


func reset() -> void:
	lina = Vector2(70, 256)
	loose_battery = Vector2(155, 256)
	battery = Battery.GROUND
	tested = false
	watering = false
	finished = false
	notice = "Omar: Prueba la batería en el banco y llévala al control de riego."


func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return
	match event.physical_keycode:
		KEY_E:
			interact()
		KEY_Q:
			if not finished and battery == Battery.HAND:
				loose_battery = lina
				battery = Battery.GROUND
				notice = "Batería en el suelo. Pulsa E para recuperarla."
		KEY_R:
			reset()
		KEY_ESCAPE:
			get_tree().quit()


func _process(delta: float) -> void:
	elapsed += delta
	if not finished:
		var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var wasd := Vector2(
			int(Input.is_physical_key_pressed(KEY_D)) - int(Input.is_physical_key_pressed(KEY_A)),
			int(Input.is_physical_key_pressed(KEY_S)) - int(Input.is_physical_key_pressed(KEY_W))
		)
		var motion := (direction + wasd).limit_length() * 195.0 * delta
		var horizontal := lina + Vector2(motion.x, 0)
		if passable(horizontal):
			lina = horizontal
		var vertical := lina + Vector2(0, motion.y)
		if passable(vertical):
			lina = vertical
		check_exit()
	queue_redraw()


func passable(point: Vector2) -> bool:
	return Rect2(36, 134, 882, 345).has_point(point) and not FLOOD.grow(12).has_point(point) and (tested or point.x < 255)


func near(point: Vector2, radius := 49.0) -> bool:
	return lina.distance_to(point) < radius


func interact() -> void:
	if finished:
		return
	if battery == Battery.GROUND and near(loose_battery):
		battery = Battery.HAND
		notice = "Batería en mano. " + ("Llévala al control." if tested else "Pulsa E junto al banco.")
	elif near(BANK):
		if battery == Battery.HAND:
			battery = Battery.BENCH
			tested = true
			notice = "Batería lista. Pulsa E para retirarla y cruza por la pasarela."
		elif battery == Battery.BENCH:
			battery = Battery.HAND
			notice = "Batería probada. Cruza por la pasarela del sur."
		else:
			notice = "Recoge la batería para probarla."
	elif near(PLAN):
		notice = "Plano de Omar. Gota: RIEGO. Hélice: VENTILACIÓN."
	elif near(WATER) or near(FAN):
		if watering:
			notice = "Riego restablecido. Ve a la salida."
		elif battery != Battery.HAND or not tested:
			notice = "Trae la batería probada."
		elif near(FAN):
			notice = "Esta toma no alimenta el riego. La batería sigue en tus manos."
		else:
			battery = Battery.INSTALLED
			watering = true
			notice = "Riego restablecido. Los aspersores funcionan y la salida está abierta."
	elif near(EXIT):
		notice = "Activa el riego para abrir la salida."


func check_exit() -> void:
	if watering and near(EXIT, 26):
		finished = true
		notice = "Nivel completado. Los semilleros recuperaron su ciclo de riego."


func caption(words: String, x: float, y: float, size: int, tint := CREAM) -> void:
	draw_string(ThemeDB.fallback_font, Vector2(x, y), words, HORIZONTAL_ALIGNMENT_LEFT, -1, size, tint)


func station(point: Vector2, words: String, tint: Color) -> void:
	draw_rect(Rect2(point - Vector2(46, 22), Vector2(92, 44)), tint)
	caption(words, point.x - 39, point.y + 5, 14)


func _draw() -> void:
	draw_rect(Rect2(0, 0, 960, 600), Color("#142a22"))
	caption("EL INVERNADERO", 30, 28, 14, MUTED)
	caption("Último turno", 28, 77, 44)
	for x in range(24, 938, 30):
		for y in range(117, 492, 30):
			draw_rect(Rect2(x, y, 27, 27), Color("#213b30"))
	caption("TALLER", 38, 108, 15, MUTED)
	caption("PASO INUNDADO", 277, 108, 15, MUTED)
	caption("ANTESALA", 467, 108, 15, MUTED)
	caption("CONTROL DE RIEGO", 662, 108, 15, MUTED)
	draw_rect(FLOOD, Color("#254e5d"))
	for y in range(141, 355, 24):
		var wave := PackedVector2Array()
		for x in range(285, 420, 5):
			wave.append(Vector2(x, y + sin(x * 0.13 + elapsed * 3) * 2.5))
		draw_polyline(wave, Color("#49848a"), 2.0, true)
	draw_rect(Rect2(277, 377, 147, 87), Color("#786244"))
	for x in range(281, 420, 13):
		draw_line(Vector2(x, 378), Vector2(x, 463), Color("#af8e5e"), 2.0)
	caption("PASARELA →", 303, 429, 16)
	if not tested:
		draw_rect(Rect2(254, 122, 8, 357), Color("#cc9863"))
	station(BANK, "BANCO", Color("#776143"))
	station(PLAN, "PLANO", Color("#4b6045"))
	station(WATER, "RIEGO", Color("#38734a") if watering else Color("#3e6665"))
	station(FAN, "VENT.", Color("#69574b"))
	station(EXIT, "SALIDA", Color("#38734a") if watering else Color("#694b43"))
	for row in range(2):
		for col in range(5):
			var bed := Vector2(667 + col * 44, 279 + row * 49)
			draw_rect(Rect2(bed, Vector2(35, 36)), Color("#604838"))
			draw_rect(Rect2(bed + Vector2(7, 7), Vector2(21, 22)), Color("#83aa62") if watering else Color("#596348"))
			if watering:
				draw_circle(bed + Vector2(15 + sin(elapsed * 9 + col) * 9, 13 + cos(elapsed * 7 + row) * 9), 3.0, Color("#bcefe9"))
	var battery_point := loose_battery
	match battery:
		Battery.HAND:
			battery_point = lina + Vector2(14, -13)
		Battery.BENCH:
			battery_point = BANK + Vector2(0, -29)
		Battery.INSTALLED:
			battery_point = WATER + Vector2(0, -29)
	draw_rect(Rect2(battery_point - Vector2(8, 7), Vector2(16, 14)), Color("#edb75c"))
	draw_circle(lina, 12.0, Color("#bfdd9d"))
	caption("Lina", lina.x - 13, lina.y + 27, 13)
	var hint := notice
	if not tested and lina.x >= 218:
		hint = "Paso cerrado. Prueba la batería en el banco." if battery == Battery.HAND else "Paso cerrado. Recoge el cuadrado amarillo con E y llévalo al banco."
	caption(hint, 28, 531, 19, Color("#f6dd9a"))
	caption("WASD o flechas · E interactuar · Q soltar · R reiniciar · Esc salir", 28, 573, 16, MUTED)
	if finished:
		draw_rect(Rect2(265, 240, 430, 89), Color("#10251d"))
		caption("Nivel completado", 338, 295, 34)


func smoke_test() -> void:
	assert(not passable(Vector2(260, 421)))
	lina = loose_battery
	interact()
	assert(battery == Battery.HAND)
	lina = BANK
	interact()
	assert(tested and battery == Battery.BENCH)
	interact()
	assert(battery == Battery.HAND)
	assert(not passable(Vector2(340, 288)) and passable(Vector2(340, 420)))
	lina = FAN
	interact()
	assert(not watering and battery == Battery.HAND)
	lina = EXIT
	check_exit()
	assert(not finished)
	lina = WATER
	interact()
	assert(watering and battery == Battery.INSTALLED)
	lina = EXIT
	check_exit()
	assert(finished)
	print("PRUEBA OK: batería, banco, pasarela, rechazo, riego y salida.")
	get_tree().quit()
