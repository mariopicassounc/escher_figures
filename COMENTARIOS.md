### General
Muy bien, usan muchos de los recursos del paradigma funcional

Aclaración: en un lenguaje como Haskell, algunas cosas "cosméticas" que serían competencia de la calidad de código en otra situación, son contempladas como competencia de la funcionalidad

### Repo
- Tageen el repo para la próxima
- Usen `.gitignore`, queda todo más limpio

### Funcionalidad
- Las funciones definidas como infijas se pueden usar como infijas
- No implementaron `--list` en la CLI
- Podrían usar `case` junto con `let in` en `foldDib` y `mapDib`. Cuando ustedes ven código repetido de esa manera ya deberían hacerse esta pregunta, ¿No tendrá Haskell una herramienta para evitar esta repetición? y lo más probable es que exixta una forma más limpia de escribir, porque Haskell esta diseñado para eso.
- `mapDib` y `figuras` se pueden escribir usando `foldDib` y queda más limpio
- En `Grilla` lo correcto sería usar un tipo básico `(Int, Int)` para que sea escalable. Así como está es demasiado hardcodeado
- El Escher está muy bien hecho, bien "a lo funcional"

### Calidad de código
- Algunas líneas un poquito largas
- `Feo` y `Grilla` repiten código
- Hay algunas reducciones para hacer, las marca el Linter, por ejemplo paréntesis en `Escher.hs`

### Modularización y diseño
- OK
