# Trazabilidad

Todas las pruebas se refieren a la escena propuesta `res://niveles/invernadero.tscn`. Las evidencias se registrarán al ejecutar las pruebas en un prototipo real.

| Historia y origen | Requisito | Nodo y prueba | Evidencia prevista | Estado |
|---|---|---|---|---|
| Apagón · ESC-01/V01 | RF-01 · Mostrar el apagón una sola vez. | EntradaTaller. Entrar y regresar. | Grabación de primera entrada y reentrada. | Propuesto |
| Aprendizaje · ESC-01/V02 | RF-02 · Registrar la prueba válida y abrir el paso al corredor. | BancoPrueba. Probar sin batería, insertar y retirar. | Grabación de ambos resultados. | Propuesto |
| Desvío y orientación · V03–V04 | RF-03 · Bloquear el paso directo y mostrar ruta y plano. | Barrera, EntradaPasarela y ZonaPlano. Recorrer la ruta y volver al plano. | Grabación del desvío y del plano. | Propuesto |
| Conexión · ESC-02/V05 | RF-04 · Permitir corregir la toma sin perder la batería. | TomaVentilacion y TomaRiego. Probar rechazo y acierto. | Grabación de ambos intentos. | Propuesto |
| Recuperación · ESC-02/V06 | RF-05 · Mostrar el riego y habilitar el cierre solo tras el acierto. | Aspersores y Salida. Probar salida antes y después. | Grabación del riego y del cierre. | Propuesto |

Mejora prioritaria para la primera prueba: comprobar si el jugador puede identificar la toma de riego por la etiqueta y la gota sin escuchar el audio. Afecta V04–V05 y RF-04. Responsable de revisión: pendiente de asignar.

Repositorio, rama, enlace a carpeta, enlace a commit y persona que verificó acceso: pendientes de publicar y registrar.
