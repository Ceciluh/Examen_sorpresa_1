# 1. Cinemática Directa
¿Qué variables articulares utiliza el modelo?
Usa ángulos en radianes: gamma (base), alpha (hombro) y beta (codo).

¿Qué transformaciones homogéneas se emplean?
Traslaciones en ejes locales y rotaciones (rotateX, rotateY) mediante una estructura de matriz anidada.

¿Cómo se valida la posición calculada?
Mediante la coincidencia visual entre el extremo del shape(end) y los puntos almacenados en trail.

# 3. Cinemática Inversa
¿Qué método se utilizó para resolverla?
Método geométrico basado en el Teorema del Coseno y funciones trigonométricas (atan2, acos).

¿Cómo se manejan soluciones múltiples o singularidades?
Se usa constrain() para limitar la extensión del brazo y evitar valores imposibles en la raíz o el coseno.

¿Qué limitaciones articulares se consideraron?
La longitud fija de los eslabones F=50 y T=70 y el radio de alcance máximo.

# 4. Planificación de Trayectorias
¿Cómo se parametriza la trayectoria en la esfera?
Se mapean coordenadas cartesianas a esféricas (latitud/longitud) con un radio fijo R.

¿Qué tipo de interpolación se utilizó?
Interpolación lineal simple (lerp) entre puntos de control definidos por segmentos de tiempo.

¿Cómo se garantiza continuidad en posición y velocidad?
Haciendo coincidir el punto final del segmento n con el inicial del n+1 y usando un speed constante.
