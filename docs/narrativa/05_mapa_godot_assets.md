# Mapa técnico y recursos

Escena propuesta para todas las viñetas: `res://niveles/invernadero.tscn`. Lina es un `CharacterBody2D` con `CollisionShape2D` y cámara `Camera2D`. Las zonas emplean `Area2D` con forma, monitoring habilitado y máscara compatible con la capa de Lina. El script del nivel filtra el grupo jugador. Las interacciones con E se resuelven en el punto válido más cercano dentro del alcance.

| Viñeta / escena | Nodo (clase) | Evento, estado o recurso | Prueba prevista |
|---|---|---|---|
| V01 / ESC-01 | EntradaTaller (Area2D), Aviso (Label) | body_entered consulta y fija intro_vista. Texto del apagón. | Entrar, salir y volver. El aviso se dispara una vez. |
| V02 / ESC-01 | BancoPrueba (Area2D), Pitido (AudioStreamPlayer) | E inserta o retira según el estado. La prueba activa bateria_probada. | Pulsar E sin batería y luego con ella. Solo la prueba válida abre la puerta. |
| V03 / Corredor | Barrera (StaticBody2D), EntradaPasarela (Area2D) | La barrera bloquea el camino frontal. Las flechas señalan la ruta. | Intentar cruzar la barrera y luego recorrer la pasarela hasta la antesala. |
| V04 / Antesala | ZonaPlano (Area2D), Plano (Label) | Entrar muestra las etiquetas. Salir oculta el plano. | Entrar, salir y regresar. El plano vuelve a mostrarse. |
| V05 / ESC-02 | TomaRiego y TomaVentilacion (Area2D) | E en la toma de riego con batería probada activa riego_activo. | Probar ventilación primero. La batería queda en mano. Riego la instala. |
| V06 / ESC-02 | Aspersores (AnimationPlayer), Agua (AudioStreamPlayer), Salida (Area2D) | riego_activo activa el cierre y permite que Salida complete el nivel. | Intentar salir antes y después de activar el riego. El cierre ocurre una vez. |

**Estado de todas las filas:** propuesto. La batería puede estar en suelo, en mano, en banco o instalada. Su estado se conserva al moverse entre zonas de la misma escena.

| ID y uso | Recurso previsto | Origen | Licencia y responsable | Estado |
|---|---|---|---|---|
| AS-01 · V01–V06 | res://arte/lina.png y bateria.png | Arte propio previsto | Pendientes de registrar y asignar | Propuesto |
| AS-02 · V01–V06 | res://arte/invernadero.png e iconos_tomas.png | Arte propio previsto | Pendientes de registrar y asignar | Propuesto |
| AS-03 · V01–V06 | res://audio/ambiente.ogg, prueba.ogg, aviso.ogg, riego.ogg | Grabación o síntesis propia prevista | Pendientes de registrar y asignar | Propuesto |
| AS-04 · V01–V06 | res://datos/textos_nivel.csv | Redacción propia prevista | Pendientes de registrar y asignar | Propuesto |
| AS-05 · V06 | Animación aspersores en la escena del nivel | Animación propia prevista | Pendientes de registrar y asignar | Propuesto |

Referencias de Godot 4.5: [Area2D](https://docs.godotengine.org/en/4.5/classes/class_area2d.html), [CharacterBody2D](https://docs.godotengine.org/en/4.5/classes/class_characterbody2d.html), [Camera2D](https://docs.godotengine.org/en/4.5/classes/class_camera2d.html), [AnimationPlayer](https://docs.godotengine.org/en/4.5/classes/class_animationplayer.html).
