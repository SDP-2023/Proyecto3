/**
    En este módulo planteamos la realización de un  testbench sobre el módulo
    "juego_de_luces_vel_var.v", módulo final en el cuals e instancia casi tods los
    módulos creados anteriormente.
**/

// Cuanto es el paso de la simulación (siempre igual)
`timescale 1ns/100ps 

module testbench_FSM_luces_kit();
    // Decalramos el parámetro local de tiempo -->
	localparam T = 20;
    // Declaramos los registros de reloj interno (CLK_50) -->
    reg CLOCK_50 ;
    // Declaramos las entrasdas de los dos rpimeros switches -->
    reg [1:0] SW ;
    // Declaramos las tres primeras entradas de los botones -->
    reg [2:0] KEY ;
    // Declaramos el cable de los 8 bits del set de salidas de luces Verdes -->
    wire [7:0] LEDG;
    // Declaramos el cable de los 8 bits del set de salidas de luces Rojas -->
    wire [7:0] LEDR;

    juego_luces_vel_var luces_var(
        .CLK_50(CLK_50),
        .SW(SW),
        .KEY(KEY),
        .LEDG(LEDG),
        .LEDR(LEDR)
    );

    // Generamos el clock -->
	always #(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y viceversa

    // Test procedure (Lo que vamos a hacer para probarlo)
    initial begin
        // Empezamos reiniciando
		CLK_50 = 0 ;
		KEY[0] = 0 ; // Reset
        SW[0] = 0 ; // Enable

        #(T*2)
        // Desconectamos el reset
        KEY[0] = 1 ;
        // Habilitamos enable
        SW[0] = 1 ;
        // Esperamos un par de ciclos
        #(T*2) 

        // Decrementamos Velocidad
        KEY[1] = 0 ;
        #(T*2) 

        // Aumentamos Velocidad
        KEY[1] = 1 ;
        KEY[2] = 0 ;
        #(T*2)

        // Decrementamos dos seguidas
        KEY[2] = 1 ;
        KEY[1] = 0 ;
        KEY[1] = 0 ;
        #(T*2) 

        // pULSAMOS EL SEGUNDO SWITCH
        KEY[1] = 1 ;
        SW[1] = 1 ;
        #(T*2) 

        // Deshabilitamos tod
        KEY[0] = 1 ; // Reset
        KEY[1] = 1 ; 
        KEY[2] = 1 ; 
        SW[0] = 0 ; // Enable
        SW[1] = 0 ; 
        $stop ;
    end

endmodule