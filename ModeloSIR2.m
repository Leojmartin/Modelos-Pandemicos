function ModeloSIR2 (alpha, beta)
  
  printf('\n\n\tMODELO: SIR.\n')
  printf('\nElija un metodo.\n');
  metodo = input('RK4 (1). Predictor (2) : ');
  
  printf('\n')
  h = input('Seleccione la longitud del paso h del metodo: ');
  
  printf('\nEscoja el lado derecho del intervalo.\n');
  a = 0; #input('Extremo izquierdo: ');
  b = input('Extremo derecho: ');
  

  N = (b-a) / h;  # buscamos N tal que el paso h sea igual a 0.1
  numEcu = 3;
  condInic = [0.8; 0.2; 0];
  
  Ro = alpha / beta;
  F = {@(t, S, I, R)-alpha*S*I, @(t, S, I, R)alpha*S*I - beta*I, @(t, S, I, R)beta*I};
  
  
  if (metodo == 1)

      [t w h] = RK4Sistema3Fun (a, b, numEcu, N, condInic, F);
      
      # plot de cada grupo, S, I y R
      figure
      plot(t, w(1,:), 'b', t, w(2,:), 'g', t, w(3,:), 'y', 'linewidth', 1)
      text(17, 0.4, ["R_0: " num2str(Ro)], 'fontsize', 11 );
      title(["Modelo: SIR, Metodo: RK4.\n\\alpha = " num2str(alpha) ". \\beta = " num2str(beta)],  'fontsize', 12);
      xlabel("Tiempo", 'fontsize', 12)
      legend({"Suceptibles", "Infecciosos", "Recuperados"}, 'Location','northwest');
      
      # plot de la fase de infectados en el tiempo
      figure;
      plot(t, e.^(-alpha*t))
      hold on;    # agregamos la linea que indica el tiempo media en la fase infecciosa
      y = ylim;
      plot([1/alpha 1/alpha],[y(1) y(2)], '--')
      title(["Individuos en la fase infecciosa.\nTiempo medio en la fase infecciosa = " num2str(1/alpha)])
      xlabel("Tiempo", 'fontsize', 12)
      xlim([0 (1/alpha)*2])

  elseif (metodo == 2)
      a2 = 0; b2 = 3*h;     # solo deseamos calcular los primeros 4 que vienen dados por el paso h
      N2 = round(b2 / linspace(a2, b2, 4)(2));

      [t w h] = RK4Sistema3Fun (a2, b2, numEcu, N2, condInic, F);
      
      N = N-4; # eliminamos los primeros 4 que calculamos con el RK4
      [t w] = PredictorSis3Fun(w, t, h, N, numEcu, F);
     
      # plot de cada grupo, S, I y R
      figure
      plot(t, w(1,:), 'b', t, w(2,:), 'g', t, w(3,:), 'y', 'linewidth', 1)
      text(17, 0.4, ["R_0: " num2str(Ro)], 'fontsize', 11 );
      title(["Modelo: SIR, Metodo: Adams-Bashforth.\n\\alpha = " num2str(alpha) ". \\beta = " num2str(beta)],  'fontsize', 12);
      xlabel("Tiempo", 'fontsize', 12)
      legend({"Suceptibles", "Infecciosos", "Recuperados"}, 'Location','northwest');
      
      # plot de la fase de infectados en el tiempo
      figure;
      plot(t, e.^(-alpha*t))
      hold on;    # agregamos la linea que indica el tiempo media en la fase infecciosa
      y = ylim;
      plot([1/alpha 1/alpha],[y(1) y(2)], '--')
      title(["Individuos en la fase infecciosa.\nTiempo medio en la fase infecciosa = " num2str(1/alpha)])
      xlabel("Tiempo", 'fontsize', 12)
      xlim([0 (1/alpha)*2])
   
  endif
  
endfunction