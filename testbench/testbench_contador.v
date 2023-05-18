/**
    En este módulo planteamos la realización de un  testbench sobre el módulo
    "contador.v", módulo el cual se lleva un cuenta sobre lso pasos que llevan 
    los leds hacia un lado u hacia otro, para qeu así tenga que cambiar en 
    cuanto a la dirección.
**/

`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module testbench_contador();
	localparam T = 20;
    
    reg CLK, RSTn, ENABLE;
    wire TC;
    wire [2:0] cuenta;

    contador #(
        .modulo(8)
    ) counter2 (
        .CLK(CLK),
        .RSTn(RSTn),
        .ENABLE(ENABLE),
        .UP_DOWN(1),
        .COUNT(cuenta),
        .TC(TC)
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

        @(posedge TC);
        @(negedge TC);
        
        ENABLE = 0;
        $stop;
    end

endmodule
