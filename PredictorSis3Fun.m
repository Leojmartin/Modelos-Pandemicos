
function [t w] = PredictorSis3Fun(w, t, h, N, numEcu, F)
  # w es una matriz en donde cada columna son los valores en los tiempos
  # respectivos que se calcularon con el RK, salida del RK
  # t es un vector que indica en que tiempos se evaluo el RK, salida del RK
  # F es la lista que contiene a las funciones
  
  for k = 1:1:N  # este for nos permite agregar mas valores para mayores tiempos t con el mismo paso h
      aux = zeros(numEcu, 1);
      aux2 = zeros(numEcu, 1);
      for i = 1:1:numEcu
         j = length(w);
         f = F{i};
         aux(i) = w(i,j) + (h/24 * [55*f(t(j), w(1,j), w(2,j), w(3,j)) - 59*f(t(j-1), w(1,j-1), w(2,j-1), w(3,j-1)) + 37*f(t(j-2), w(1,j-2), w(2,j-2), w(3,j-2)) - 9*f(t(j-3), w(1,j-3), w(2,j-3), w(3,j-3))]);
         # ahora agreagamos los nuevos valores a nuestra w y nuestro vector t
      endfor
      # agregamos el nuevo tiempo
      t(length(t)+1) = t(length(t))+ h;
      
      w = [w aux];
  endfor
endfunction