# Guion jugable

## ESC-01 · El apagón · Taller de mantenimiento (B1–B2)

- **Propósito y disparador.** Comprender que el riego está apagado y aprender a manipular la batería. Primera entrada de Lina al taller con `intro_vista = false`.
- **Acción y controles.** Flechas o WASD para caminar. E para recoger, insertar o retirar según el objeto cercano. Q para soltar en suelo transitable.
- **Texto.** «Ciclo de riego interrumpido». Nota de Omar: «Prueba la batería en el banco y llévala a la sala de control».
- **Respuesta.** Al probar la batería en el banco, el sistema registra `bateria_probada`, muestra «Batería lista» y abre la puerta hacia el corredor.
- **Cámara y sonido.** Vista cenital con el banco y la batería visibles. Zumbido inicial y pitido de éxito, respaldados por texto. El jugador conserva el control.
- **Salida, fallo y reentrada.** La escena progresa cuando Lina retira la batería probada y cruza al corredor. Si interactúa sin batería, aparece «Recoge la batería». Si la suelta, puede recogerla. Al volver, persisten el resultado de la prueba y la puerta abierta.

## ESC-02 · Devuelve el agua · Sala de control (B5–B6)

- **Propósito y disparador.** Elegir el circuito correcto. Entrada a la sala con batería probada en mano y riego apagado. Si llega sin batería, el acceso indica que debe recuperarla.
- **Acción y texto.** E junto a una toma visible. La gota indica «RIEGO» y la hélice indica «VENTILACIÓN».
- **Respuesta.** Ventilación muestra «Esta toma no alimenta el riego» y la batería permanece en mano. Riego instala la batería, activa los aspersores, habilita la salida y muestra «Riego restablecido».
- **Cámara y sonido.** Vista cenital con las dos tomas en el encuadre. Aviso breve al fallar y sonido de agua al acertar, con texto y cambios visibles. El jugador conserva el control.
- **Salida, fallo y reentrada.** Lina puede volver al plano de la antesala o corregir en el lugar. Si regresa tras el acierto, los aspersores siguen funcionando. Cruzar la salida con riego activo marca el nivel como completado una sola vez.
