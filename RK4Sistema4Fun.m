
function [t x h] = RK4Sistema4Fun (a, b, numEcu, N, condInic, F)
  
  h = (b - a)/ N;
  t = a:h:b;
  aux = zeros(numEcu, 1);
  # para los primeros w, tenemos que son igual a la condicion inicial
  
  w = condInic;
  x(:,1) = w;


  for i = 1:1:N
    k = zeros(numEcu,4);
    # tenemos que calcular cada k_i para cada funcion de F
    for j = 1:1:numEcu
      # cada k debe ser un vector columna
      # donde cada componente es el k_1 de cada funcion de F
      f = F{j};
      aux(j) =  h * f(t(i), w(1), w(2), w(3), w(4));
    endfor
    k(:,1) = aux;
    
    for j = 1:1:numEcu
      f = F{j};
      aux(j) =  h * f(t(i) + h/2, w(1) + 0.5*k(:,1)(1), w(2) + 0.5*k(:,1)(2), w(3) + 0.5*k(:,1)(3), w(4) + 0.5*k(:,1)(4));
    endfor
    k(:,2) = aux;
     
    for j = 1:1:numEcu
      f = F{j};
      aux(j) =  h * f(t(i) + h/2, w(1) + 0.5*k(:,2)(1), w(2) + 0.5*k(:,2)(2), w(3) + 0.5*k(:,1)(3), w(4) + 0.5*k(:,1)(4));
    endfor  
    k(:,3) = aux;
    
    
    for j = 1:1:numEcu
      f = F{j};
      aux(j) =  h * f(t(i) + h/2, w(1) + k(:,3)(1), w(2) + k(:,3)(2), w(3) + k(:,3)(3), w(4) + k(:,3)(4));
    endfor
    k(:,4) = aux;
  
      w = w + (k(:,1) + 2*k(:,2) + 2*k(:,3) + k(:,4)) / 6;
      x(:,i+1) = w;
    
  endfor
  
endfunction