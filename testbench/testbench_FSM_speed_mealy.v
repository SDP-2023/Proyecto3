`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module testbench_FSM_speed_mealy();
	localparam T = 20;
    
    reg CLK, RSTn, Key1, Key2;
    wire ENABLE, UP_DOWN;

    FSM_speed speed(
        .CLK(CLK),
        .RSTn(RSTn),
        .Key1(Key1),
        .Key2(Key2),
        .ENABLE(ENABLE),
        .UP_DOWN(UP_DOWN)
    );

    // Generamos el clock -->
	always #(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y vicev

    // Test procedure (Lo que vamos a hacer para probarlo)
    initial begin
        // Empezamos reiniciando
		CLK = 0;
		RSTn = 0;
        Key1 = 1;
        Key2 = 1;
        // Desconectamos el reset
        #(T*2) RSTn = 1;
       

        // Pulsamos Key1 durante un par de ciclos
        Key1 = 0;
        #(T*2) Key1 = 1;

        // Pulsamos Key1 durante un par de ciclos
        Key1 = 0;
        #(T*2) Key1 = 1;
        

        // Pulsamos Key2 durante un par de ciclos
        Key2 = 0;
        #(T*2) Key2 = 1;

        // Pulsamos Key2 durante un par de ciclos
        Key2 = 0;
        #(T*2) Key2 = 1;

        #(T*2); // Damos un poco de margen

        $stop;
    end

endmodule
