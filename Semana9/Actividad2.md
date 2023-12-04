## TDD

Presenta tus respuestas en un repositorio llamado `TDD`. La actividad es individual.

### RSpec TDD 
Ya hemos visto una variante de la anatomía `AAA` en Cucumber, donde las precondiciones generalmente son pasos `Given`, las acciones tomadas generalmente son pasos `When` 
y las postcondiciones generalmente se expresan en pasos `Then`.

En el framework RSpec, cada caso de prueba se denomina ejemplo y, aunque la terminología es un poco diferente, los conceptos son los mismos. Cada ejemplo:

  * `Arrange`: establece algunas precondiciones. Al igual que Cucumber, las precondiciones se pueden colocar en un bloque `before(:each)` que se ejecuta antes de cada ejemplo.
  * `Act`: ejecutar algún código (es decir, llamar al método de clase).
  * `Assert`: Marca 1+ expectativas para verificar la corrección del comportamiento. RSpec puede expresar muchos tipos de expectativas:
    - `Equality`: el valor calculado es igual a algún valor conocido
    - `Set Inclusion`: la colección calculada incluye algún elemento.
    - `Method Invoked`: se debe llamar a un método particular
    - `Mutation`: los valores de algunas expresiones deberían haber cambiado (es decir, la longitud de la colección después del nuevo elemento).

Dada una definición de clase para `LinkedList`, con dos métodos:

1. `add`: agrega un elemento a la lista
2. `count`: devuelve el número de elementos de la lista

Escribe pruebas RSpec para ambos métodos.

```
  describe "LinkedList" do
     describe "adding an item" do
          it "should increase the count by 1" do
          ................................................
          ................................................
          ................................................
     end
  end
  describe "#count" do
    it "should start at zero" do
    ................................................
    ................................................
    ................................................
    end
 end
end    
```
