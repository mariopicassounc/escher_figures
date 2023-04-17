# Informe Laboratorio 1 Paradigmas de la Programación

## Integrantes:
- Mateo Malpassi
- Matías Scantamburlo
- Mario Picasso

## Preguntas:

### Pregunta 1: ¿Por qué están separadas las funcionalidades en los módulos indicados?

Las funcionalidades en los módulos indicados están separadas porque nos permite tener un código más legible, ordenado, y nos permite identificar rápidamente qué hará cada módulo y cómo se relacionarán a la hora de trabajar. A su vez, cada módulo es independiente, lo que facilita la tarea de testear y verificar de que cada uno de estos funcione de la manera en que uno espera. Es fácil notar que esto, en trabajos de gran magnitud significa una ventaja notable, ya que evita arrastrar problemas.

En particular, el módulo Dibujo.hs se encarga de definir la sintaxis de nuestro lenguaje de figuras que vamos a utilizar, definiendo el tipo Dibujo junto a sus constructores, y las funciones que podremos utilizar. Notamos que en este módulo NO se da la interpretación geométrica real, ya que, como dijimos anteriormente, este módulo se encargará de la sintaxis

Concretamente, el módulo que definirá la semántica de nuestro lenguaje de figuras será Interp.hs. En este módulo sí se utilizaran vectores, los cuales serán manipulados a través de funciones para hacer representaciones geométricas. 

Luego Main.hs es el módulo que nos permitirá realizar los llamados a otros módulos, con configuraciones específicas para realizar los dibujos implementados, utilizando la librería Gloss.

### Pregunta 2: ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?

Las figuras básicas se pasan como parámetro, ya que la gracia es que no haya una interpretación fija, sino abstraer el concepto de figura básica para poder operar con ellas indiferentemente de su implementacíon; esto además, deja la posibilidad de crear infinitas figuras.

### Pregunta 3: ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?

En "Learn You a Haskell for Great Good!" pudimos ver que la funciónes fold nacen para encapsular el, a veces reiterado, comportamiento de pattern-matching por lo tanto de acá sacamos una primera ventaja:
La función `fold` se puede reutilizar fácilmente en diferentes contextos con diferentes funciones de combinación. Luego: Proporciona una forma genérica y segura de procesar estructuras de datos recursivamente, ya que se asegura de que se evalúen todos los elementos de la estructura de datos en un orden determinado haciendo uso de la recurción de cola (tail recursion).

Esto nos lleva a una segunda ventaja:
`fold` utiliza tail-recursion para procesar los elementos de la estructura de datos. Esto significa que, en lugar de crear una pila de llamadas de funciones, `fold` realiza todas las operaciones recursivas en el mismo marco de pila, lo que hace que sea más eficiente y evita el desbordamiento de la pila.
(https://stackoverflow.com/questions/33923/what-is-tail-recursion)

A esto le podemos agregar que:
Al utilizar `fold`, se puede ocultar la complejidad del proceso de reducción y enfocarse en el resultado final deseado. Esto puede hacer que el código sea más legible y fácil de mantener.

Aunque en algunos casos, el pattern-matching directo puede ser más simple y, valga la redundancia, directo que la utilización de `fold`. Por ejemplo, si se desea obtener el primer elemento de una lista, se puede utilizar el pattern-matching directo con una expresión más reducida y clara.

## Experiencia

Como grupo fue fundamental la división de tareas y la ayuda mutua para el:
Re-aprendizaje del lenguaje, principalmente conceptos como la currificación, funciones lambdas, estructuras recursivas y demás. Una mayor comprensión del paradigma funcional. Estudio de las librerias (y mucha paciencia para instalarlas!).

Trabajamos a través de meet. Usamos como materíal:
* http://learnyouahaskell.com/
* http://hoogle.haskell.org/
* https://cs.famaf.unc.edu.ar/~mpagano/henderson-funcgeo2.pdf
Como también stackoverflow y ayudas de AI en varias ocaciones.