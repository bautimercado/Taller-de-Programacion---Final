# Repositorio sobre el final de taller de programaciòn
# Bautista Mercado.

# Tres paradigmas:

## IMPERATIVO - PASCAL:
  - Ordenar una serie de elementos en un array con un algoritmo. Ordenamiento por inserciòn

  - Recursiòn, caso base.

  - Àrboles Binarios de Bùsqueda (EEDD no lineal). Agregar un elemento, buscar un elemento (O log), recorridos.

  - Merge y Merge acumulador (con dos o màs estructuras ordenadas por el mismo criterio, generar una unica estructura con toda la informaciòn). El merge acumulador usa un corte de control. Se necesita buscar el mìnimo en cada estructura, y colocar ese mìnimo
  al final de la estructura nueva (para mantener el orden) mientras las estructuras tengan elementos para procesar.
  
  - ^ --> shift + acento

## POO - JAVA:
  - Objeto, estado interno-atributos (variables de instancia PRIVADAS), comportamiento (mètodos PUBLICOS).

  - Encapsulamiento, las variables de instancia han de ser privadas para protegerlas y ocultar la implementaciòn del objeto.

  - Clase, molde generico del cual se crea un objeto.

  - Mensaje, se envia un mensaje, utilizando un objeto y enviandole un mensaje sintaticamente identico al de un comportamiento del objeto en cuestiòn.

  - Instanciaciòn, creaciòn de un objeto, se envia un mensaje de creaciòn a la clase, se reserva espacio en memoria para el objeto, se ejecuta un constructor (si no hay, se ejecuta un constructor nulo), y se obtiene una referencia la cual se vincula a una variable.

  - Constructor, conjunto de instrucciones que permiten que cuando se instancie un objeto sus variables de instancia tengan valores, los cuales son pasados como parametros.

  - Herencia, capacidad de una clase de compartir su estado interno y comportamiento con otras clases (reusabilidad de còdigo, jerarquia). Las clases que hereden el estado interno y comportamiento (subclases) de una clase padre (superclase), a su vez tambien pueden definir sus propios atributos y mètodos.

  - Una clase abstracta es una clase la cual NO puede ser instanciable, define variables de instancia y metodos para un conjunto de clases, tambien se pueden implementar mètodos abstractos (mètodos con su encabezado e implementados en las subclases).

  - Polimorfismo, objetos de clases distintas responden al mismo mensaje pero de forma distinta. Còdigo generico y reusable.

  - Binding dinàmico, Se determina en tiempo de ejecuciòn que mètodo es el que se tiene que ejecutar para un mensaje.

## CONCURENCIA - R-INFO:
  - Varios procesos (no mòdulos) ejecutandose a la vez para resolver una tarea en comùn. Comparten recursos, coordinan y cooperan.
  
  - Util para explotar el hardware de una computadora (varios nucleos, varios niveles de memoria).

  - Los programas concurrentes poseen mecanismos para comunicar y sincronizar procesos.

  - Memoria local - Àrea Privada, Memoria Cachè - Àrea Parcialmente Compartida, Memoria Principal - Àrea Compartida.

  - Envio de mensajes, los robots pueden enviarse y recibir mensajes para coordinar, cooperar y transmitirse informaciòn.

  - EnviarMensaje(variable, variable_robot), envia un mensaje con un valor a otro robot, luego de enviar el mensaje, el robot sigue su ejecuciòn (Asincronico).

  - RecibirMensaje(variable, variable-robot), recibe un mensaje de un robot (se puede usar un caràcter para indicar que se recibe un mensaje de cualquier robot) y se lo guarda en una variable, cuando se ejecuta esta instrucciòn, el robot detiene su ejecuciòn y se queda esperando hasta que le llegue un mensaje (Sincronico). Debe usarse con precauciòn.

  - Los mòdulos pueden utilizar la misma memoria (memoria compartida) pero esto puede causar errores, por lo cual hay que tener algùn mecanismo para bloquear y liberar el acceso a la memoria compartida. Pueden retrasar a los procesos. Hay que bloquear en el momento preciso (solo si es necesario) y liberar lo antes posible.

  - BloquearEsquina(avenida, calle), Bloquea una esquina dada por el nro de avenida y calle, si la esquina ya esta bloqueada el robot se queda en un loop hasta que pueda bloquearlo.

  - LiberarEsquina(avenida, calle), Libera una esquina dada por el nro de avenida y calle.
  
  - Para ejecutar r-info --> java -jar r-Info-2.9.jar
