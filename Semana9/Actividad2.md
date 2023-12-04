## TDD

Presenta tus respuestas en un repositorio llamado `TDD`. La actividad es individual.

En clase sobre ciclo de vida ágil, discutimos dos aspectos de la garantía del software: validación  y verificación. BDD nos ayuda a comunicarnos eficazmente con el cliente para realizar la validación. Aquí, nos centraremos en la verificación, específicamente en cómo comprobar si hemos creado el sistema correctamente mediante pruebas de software.

### FIRST

Recuerda, los principios FIRST son un conjunto de pautas para redactar pruebas unitarias precisas y efectivas. FIRST significa rápido, independiente, repetible, autocontrolado y oportuno. Dado el código siguiente, determina qué principio FIRST no se sigue y por qué. Determina cómo podrías editar la prueba para resolver su insuficiencia.
​
En el archivo `HomeController.rb`:

```
def index
  if Time.now.tuesday?
    render 'special_index'
   else
    render 'index'
   end
end
```
En el archivo `HomeControllerSpec.rb`:

```
it "should␣render␣special␣template␣on␣Tuesdays" do
  get 'index'
  if Time.now.tuesday?
    response.should render_template('special_index')
  else
    response.should render_template('index')
   end
end
```

### AAA

El patrón más popular para la anatomía de una prueba unitaria es el método `Arrange`, `Act` y `Assert`. En este ejercicio, implementaremos cada una de estas etapas para una clase `BankAccount`.

Aquí está el código de clase `BankAccount`:

```
class BankAccount
  attr_reader :total
  def initialize(amount)
    @total = amount
  end
  def cash(amount)
    @total += amount
  end
end
```
Completa la siguiente prueba unitaria, siguiendo el paradigma Triple A, para probar si el método `cash` funciona. Inicializa la cuenta bancaria con un monto 100. `Cash` un monto de 1. Indica que el total esperado después de `cash` es 101.

```
RSpec.describe BankAccount do
   # Arrange aqui
    ..........................................
   describe '#cash' do
      it 'adds the passed amount to total' do
        # Act aqui
        ..........................................
        # Assert aqui
        ..........................................
      end
    end
end
```

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
