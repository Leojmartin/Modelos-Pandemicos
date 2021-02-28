#                         Modelado de Pandemias

# Definiciones:
# alpha: tasa de infeccion
# beta: tasa de recuperacion
# sigma: tasa de encubacion del virus dentro del individuo
# B: tasa de promedio de nacimientos
# miu: tasa promedio de defuciones
# eta: Tiempo de inmunidad temporal



#                             Modelo SIR

# El modelado de epidemias por el SIR es uno de los mas comunes y de el derivan muchos mas 
# modelos. Este modelo se basa en dividir a la poblacion en 3 grupos, los Suceptibles,
# quienes pueden contraer la enfermedad, los Infectados, quienes contangian a los suceptibles
# y los Recuperados, quienes pasan de estar en la fase de infectados a ser recuperados.
# Por la tanto tendremos 3 ecuaciones diferenciales, que miden el cambio medio en el tiempo
# de cada uno de los grupos, es decir, como cambia en el tiempo la cantidad de individuos 
# suceptibles o infectados o recuperados.
# En los modelos pandemicos existe un factor llamado Ro que indica cuanto perdurara una epidemias
# en el tiempo, es decir, si la pandemia se volvera endemica o no. Esto se puede determinar 
# a traves del Ro que se define como el numero basico de reproducciones, en otras palabras,
# cuantas personas seran infectadas por el paciente cero.
# Si Ro > 1 la epidemia permanece en el tiempo y si Ro < 1 la epidemia desaparece rapidamente

# Es posible calcular el tiempo en que los individuos estaran en la fase 
# infecciosa, esto viene dado por la ecuacion I(t) donde: 
# I' = alpha*S*I - beta*I donde S al inicio es toda la poblacion, normalizando
# S = 1 y no tenemos individuos pasando a la etapa de recuperacion por lo que 
# beta*I = 0, entonces
# en el tiempo cero nos queda que I' = alpha*I
# que tiene por solucion I(t) = I(0)*e^(-alpha*t) (1)
#
# tiempo medio que permanecen los individuos en la clase infecciosa = 1 / alpha
#
# NOTA: el parametro alpha puede ser encontrado de la ecuacion (1) al entonar el valor 
# de alpha de forma tal que se obtenga el menor error cuadratico entre las observaciones reales 
# y los valores aproximados de I por la ecuacion (1) con < t < tf.

# Es importante destacar que existen muchas variaciones y generalizaciones para cada uno de los
# modelos y el uso de cada modelo junto a las diferentes consideraciones a tomar 
# dependera del tipo de virus o bacteria que se desee estudiar. 
# Algunas de las variaciones es, por ejemplo, considerar las personas que nacen y mueren
# de forma natural, considerar las personas que mueren por le enfermedad, considerar
# una poblacion constante o una poblacion de tamano variable o considerar si se tiene 
# vacuna para el virus o si se colaca vacuna a nuevos infantes nacidos, etc.

# Veamos un ejemplo con datos reales
clear;
clc;
alpha = 0.4091;
beta = 0.024;
ModeloSIR2 (alpha, beta)





#                           Modelado SEIR

# El modelado de una pandemia por SEIR es una generalizacion del metodo SIR, en este caso
# se agrega un nuevo grupo a los tres definidos anteriormente. El nuevo grupo hace referencia
# a los individuos Expuestos, E, que son individuos que han sido infectados pero que aun
# no estan es capacidad de infectar a otros ya que el virus necesita un tiempo de encubacion
# dentro del organismo del individuo para finalmente atacarlo.
# Por lo que ahora contamos con 4 ecuaciones diferenciales que miden la tasa de cambio respecto al tiempo
# de los individuos en cada una de las etapas.
# El valor del Ro indica lo mismo que antes.
# En este caso el tiempo en que los individuos permaneceran en la fase de infeccion se 
# calcula igual que como se vio para el SIR

alpha = 0.4091;
beta = 0.024;
sigma = 1/5.2; 
ModeloSEIR2(alpha, beta, sigma)

# Se utilizaron los mismos valores tanto para alpha y beta como para la condiciones iniciales
# para ambos modelos. Segun las graficas podemos observar como el modelo de SEIR nos indica
# que se obtendria un mayor numero de personas infectadas que para SIR durando la epidemia 
# aproximadamente la misma cantidad de tiempo. El comportamiento de los individuos Suceptibles y
# Recuperados es similar en ambos casos.
# 
# Para el caso del SEIR podemos observar como la cantidad de personas Expuestas disminuye
# en el tiempo. Ahora si variamos el parametro de encubacion del virus sigma, por ejemplo,
# al colocar un periodo de encubacion mas lento vemos como la cantidad total de infectados
# disminuye pero el tiempo en observar mayor numero de personas recuperadas que infectadas 
# aumenta. Y finalmente con un sigma menor tendremos un numero mayor personas recuperadas en el 
# tiempo.




#                           Modelado MSIR

# En el caso de los modelos MSIR se realiza una nueva consideracion respecto al SIR que es
# agregar una nueva etapa M que se refiere a infantes recien nacidos que en principio 
# son imunes a la enfermedad pero eventualmente se convierten en personas suceptibles al 
# virus, bacteria, etc.
# Para este modelo consideraremos que la poblacion total no es constante ya que
# la tasa nacimientos y la tasa de muertes no es la misma.

alpha = 0.4091;
beta = 0.024;
B = 0.000323; #0.00875;
eta = 0.000214;
miu = 0.00875; #0.000323; #
ModeloMSIR2 (alpha, beta, B, eta, miu)



# Por su parte el MSIR muestra la menor cantidad de infectados con un crecimiento similar 
# al modelo del SIR pero cuando la cantidad de infectados comienza a disminuir
# en el caso del MSIR la curva tiende mas rapidamente a cero.
# Posteriormente al visualizar la curva de los individuos recuperados vemos que existiran
# mas recuperados que infectados aproximadamente al mismo tiempo que para el modelo del SEIR,
# en definitiva, se tendra menor cantidad de infectados pero durara mas. A pesar
# de que la curva de infectados decrece con una mayor pendiente podriamos pensar que 
# la epidimia deberia durar menos tiempo respecto a los modelos anteriores pero la curva
# de recuperados crece con menor pendiente.
# Tambien vemos que no llegamos a tener la misma cantidad de recuperados 
# que de suceptibles para ningun tiempo t esto debido a que estamos considerando que no tenemos
# una poblacion constante. 
# Si asignamos el mismo valor para la tasa de nacimiento y muertes
# tendremos ahora un comportamiento muy parecido a todas las curvas vista en el modelo del SIR








