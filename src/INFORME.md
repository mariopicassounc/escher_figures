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

