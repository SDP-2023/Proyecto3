`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module testbench_FSM_luces();
	localparam T = 20;
    
    reg CLK, RSTn, ENABLE;
    wire [7:0] LEDG;

    FSM_luces luces(
        .CLK(CLK),
        .RSTn(RSTn),
        .ENABLE(ENABLE),
        .LEDG(LEDG)
    );

    // Generamos el clock -->
	always #(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y vicev

    // Test procedure (Lo que vamos a hacer para probarlo)
    initial begin
        // Empezamos reiniciando
		CLK = 0;
		RSTn = 0;
        ENABLE = 0;
        // Desconectamos el reset
        #(T*2) RSTn = 1;
        // Habilitamos enable
        ENABLE = 1;
    end

endmodule
