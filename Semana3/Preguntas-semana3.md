## Semana 3: Modismos en Ruby

**CC 3S2: Desarrollo de software**

### Descripción general

1. Define los principales modismos de Ruby
2. ¿Cuáles de las siguientes expresiones en Ruby son iguales entre sí?: (a) `:f1` (b) `%q{f1}` (c) `%Q{f1}` (d) `’f1’.to_sym` (e) `:f1.to_s`
3. ¿Qué se almacena en $1 cuando la cadena `25 to 1` se compara con las siguientes expresiones regulares?:
    - `/(\d+)$/`
    - `/^\d+([^0-9]+)/`
4. ¿Por qué `5.superclass` resulta en un error de 'método indefinido'?
5. ¿Cuántas clases antecesoras tiene el objeto `5`?
6. Teniendo en cuenta que `superclass` devuelve `nil` cuando se le llama sobre `BasicObject` pero devuelve un valor no `nil` en el resto de ocasiones, escribe un método Ruby que, cuando se le pase un objeto, escriba la clase del objeto y sus clases ancestras hasta `BasicObject`.
7. ¿Cuál es el método `send` equivalente de las siguientes expresiones?: `a<b`, `a==b`, `x[0]`, `x[0]= 'f1'`.
8. Abejita Bitdiddle pregunta: 'Si i es un entero y f es un número en coma flotante en Ruby, y escribo `i+f`, al hacer la suma, ¿ `i` se convierte en float o `f` se convierte en un entero?” Explica por qué la pregunta de Abejita está mal formulada si se aplica a Ruby.
9.  Escribe una línea de Ruby que compruebe si una cadena `s` es un palíndromo, es decir, se lee igual hacia atrás que hacia adelante.
10.  Iluminada por la respuesta que le has dado , ahora Abejita observa que escribir `i+=f` es legal en Ruby. Tu pregunta es: ¿ `+= `es un operador de separación en Ruby, o es
sólo una forma simplificada de escribir `i=i+f.  Diseña y pon a prueba un experimento para determinar la respuesta.
11. Supongamos que mezclas `Enumerable` en una clase `F1` que no proporciona el método `each`. ¿Qué error se generará cuando llames a `F1.new.map { |elt| puts elt }`.
12. ¿Qué sentencia es correcta y por qué: (a) include ’enumerable’ (b) `include Enumerable`?.
13. Recuerda que los dos primeros enteros en la serie de Fibonacci son 1 y 1, y que cada uno de los siguientes números en la serie son la suma de los dos anteriores. Construye una clase que devuelva un iterador para los primeros `n` números de la serie de Fibonacci. Debería ser capaz de usar la clase como sigue:

      ```
        # Iterador de Fibonacci :
        f = FibSequence.new(6) 
        f.each { |s| print(s,':') }  # => 1:1:2:3:5:8:
        f.reject { |s| s.odd? }      # => [2, 8]
        f.reject(&:odd?)             # => [2, 8]
        f.map { |x| 2*x }            # => [2, 2, 4, 6, 10, 16]
      ```
14. Un árbol binario ordenado es aquel en el que cada nodo tiene un valor y hasta 2 hijos, cada uno de los cuales es también un árbol binario ordenado, y el valor de cualquier elemento del subárbol izquierdo de un nodo es menor que el valor de cualquier elemento en el subárbol derecho del nodo. Definaeuna clase colección llamada `BinaryTree` que ofrezca los métodos de instancia `<<` (insertar elemento), `empty?` (devuelve cierto si el árbol no tiene elementos) y `each` (el iterador estándar que devuelve un elemento cada vez, en el orden que tu quieras).
15. Extienda la clase de tu árbol binario ordenado para que ofrezca los siguientes métodos, cada uno de los cuales toma un bloque: `include?(elt)` (devuelve cierto si el árbol incluye a `elt`), `all?` (cierto si un bloque dado es cierto para todos los elementos), `any?` (cierto si un bloque dado es cierto para alguno de sus elementos), `sort` (ordena los elementos).
#### Otros ejercicios

1. Escribe una función que acepte una cadena que contenga todas las letras del alfabeto excepto una y devuelva la letra que falta. Por ejemplo, la cadena `the quick brown box jumps over a lazy dog` contiene todas las letras del alfabeto excepto la letra `f`. La función debe tener una complejidad temporal de `O(n)`.
2. Escribe un algoritmo que encuentre el mayor valor dentro de un árbol de búsqueda binario
3. Escribe una función de autocorrección que intenta reemplazar el error tipográfico de un usuario con una palabra correcta. La función debe aceptar una cadena que represente el texto que escribió un usuario. Si la cadena del usuario no está en el [trie](https://www.interviewcake.com/concept/java/trie), la función debe devolver una palabra alternativa que comparta el prefijo más largo posible con la cadena del usuario. Por ejemplo, digamos que el trie contiene las palabras `cat`, `catnap` y `catnip`. Si el usuario escribe accidentalmente `catnar`, la  función debería devolver `catnap`, ya que esa es la palabra del trie que comparte el prefijo más largo con `catnar`. Esto se debe a que tanto `catnar` como `catnap` comparten el prefijo `catna`, que tiene cinco caracteres. La palabra "catnip" no es tan buena, ya que sólo comparte el prefijo más corto de cuatro caracteres de `catn` con `catnar`. Un ejemplo más: si el usuario escribe `caxasfdij`, la función podría devolver  cualquiera de las palabras `cat`, `catnap` y `catnip`, ya que todas comparten el mismo prefijo `ca` con el error tipográfico del usuario. Si la cadena del usuario se encuentra en el trie, la función debería devolver simplemente la palabra misma. Esto debería ser cierto incluso si el texto del usuario no es una palabra completa, ya que solo intentamos corregir errores tipográficos, no sugerir terminaciones para el prefijo del usuario.
4. Estás escribiendo una función que acepta un arreglo de números y calcula el producto más alto de dos números cualesquiera en el arreglo. A primera vista, esto es fácil, ya que podemos simplemente encontrar los dos números mayores y multiplicarlos. Sin embargo, el arreglo puede contener números negativos y verse así: `[5, -10, -6, 9, 4]`.  En este caso, en realidad es el producto de los dos números más bajos, `-10` y `-6`, el que produce el producto más alto  de `60`. Podríamos usar bucles anidados para multiplicar cada par de números posible, pero esto tomaría $O(n^2)$. Tu trabajo es optimizar la función para que sea una $O(n)$.
5. Estás escribiendo una función que acepta un arreglo de números enteros sin ordenar y devuelve la longitud de la secuencia consecutiva más larga entre ellos. La secuencia está formada por números enteros que aumentan en 1. Por ejemplo, en el arreglo: `[10, 5, 12, 3, 55, 30, 4, 11, 2]` la secuencia consecutiva más larga es `2-3-4-5`. Estos cuatro números enteros forman una secuencia creciente porque cada número entero es uno mayor que el anterior. Si bien también hay una secuencia de `10-11-12`, es solo una secuencia de tres números enteros. En este caso, la función debería devolver `4`, ya que esa es la longitud de la secuencia consecutiva más larga que se puede formar a partir de este arreglo.

    Un ejemplo más: `[19, 13, 15, 12, 18, 14, 17, 11]`

    La secuencia más larga de est arreglo es `11-12-13-14-15`, por lo que la función devolvería `5`. Si ordenamos el arreglo, podemos recorrerla solo una vez para encontrar la secuencia consecutiva más      larga. Sin embargo, el ordenamiento en sí tomaría $O(n \log n)$. Tu trabajo es optimizar la función para que tome tiempo $O(n)$.
