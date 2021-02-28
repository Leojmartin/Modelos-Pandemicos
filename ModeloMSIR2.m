

function ModeloMSIR2 (alpha, beta, B, eta, miu)
  
  printf('\n\n\tMODELO: MSIR.\n')
  printf('\nElija un metodo.\n');
  metodo = input('RK4 (1). Predictor (2) : ');
  
  printf('\n')
  h = input('Seleccione la longitud del paso h del metodo: ');
  
  printf('\nEscoja el lado derecho intervalo.\n');
  a = 0; #input('Extremo izquierdo: ');
  b = input('Extremo derecho: ');
  
  N = (b-a) / h;  # buscamos N tal que el paso h sea igual a 0.1
  numEcu = 4;
  condInic = [0.1; 0.8; 0.2; 0];
  
  F = {@(t, M, S, I, R)B - eta*M*S - miu*M, @(t, M, S, I, R)eta*M*S - alpha*S*I - miu*S, @(t, M, S, I, R)alpha*S*I - beta*I - miu*I, @(t, M, S, I, R)beta*I - miu*R};
  
  if (metodo == 1)

      [t w h] = RK4Sistema4Fun (a, b, numEcu, N, condInic, F);
      
      figure
      plot(t, w(1,:), 'r', t, w(2,:), 'b', t, w(3,:), 'g', t, w(4,:), 'y', 'linewidth', 1)
      #text(17, 0.4, ["R_0: " num2str(Ro)], 'fontsize', 12 );
      title(["Modelo: MSIR, Metodo: RK4.\n\\alpha = " num2str(alpha) ". \\beta = " num2str(beta) ". B = " num2str(B) ". \\eta = " num2str(eta) ". \\mu = " num2str(miu)], 'fontsize', 12);
      xlabel("Tiempo", 'fontsize', 12)
      legend({"Inmunes", "Suceptibles", "Infecciosos", "Recuperados"}, 'Location','northeast');

  
  elseif (metodo == 2)
     # a2 = 0; b2 = 0.3;
     # N2 = 3;
     a2 = 0; b2 = 3*h;     # solo deseamos calcular los primeros 4 que vienen dados por el paso h
     N2 = round(b2 / linspace(a2, b2, 4)(2));

      [t w h] = RK4Sistema4Fun (a2, b2, numEcu, N2, condInic, F);
      
      N = N-4; # eliminamos los primeros 4 que calculamos con el RK4
      [t w] = PredictorSis4Fun(w, t, h, N, numEcu, F);
     
      figure
      plot(t, w(1,:), 'r', t, w(2,:), 'b', t, w(3,:), 'g', t, w(4,:), 'y', 'linewidth', 1)
      #text(17, 0.4, ["R_0: " num2str(Ro)], 'fontsize', 12 );
      title(["Modelo: MSIR, Metodo: Adams-Bashforth.\n\\alpha = " num2str(alpha) ". \\beta = " num2str(beta) ". B = " num2str(B) ". \\eta = " num2str(eta) ". \\mu = " num2str(miu)], 'fontsize', 12);
      xlabel("Tiempo", 'fontsize', 12)
      legend({"Inmunes", "Suceptibles", "Infecciosos", "Recuperados"}, 'Location','northeast');
   
  endif
endfunction