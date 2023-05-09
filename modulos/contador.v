
/**
 * Creación de un contador binario síncrono de módulo parametrizable ascendente/descendente
 */ 

module contador #(
    parameter modulo = 10               // modulo de la cuenta
)(
    // Declaración de Entradas -->
    input CLK, RSTn, ENABLE, UP_DOWN,   // CLK, activo a nivel alto, RST asíncrono actv a lvl bajo,
                                        // Enable a lvl alto y Señal de contador(1), restador(0)

    // Declaración de Salidas -->
    output reg [N-1:0] COUNT,           // Contador de tamaño 'N' bits
    output TC                           // Terminal count (Activo cuando la cuenta ha llegado a su fin)
);

// Calculamos el número de bits necesarios para el módulo dado
localparam N = $clog2(modulo-1);

// Bloque procedural always con sensibilidad de reloj a nivel alto y Reset a lvl bajo
always @(posedge CLK or negedge RSTn) begin
    // Si el reset se activa, ponemos el contador al inicio (coge el valor del primer bit)
    if(!RSTn) COUNT <= {N{1'b0}};

    // Si el ENABLE está activo para funcionar
    else if(ENABLE)
        // Una vez llegado a maximo, reiniciar (poner los bits a 0)
        if(COUNT == modulo-1)
            COUNT <= { N{ 1'b0 } };
        // De lo contrario, sumamos 1 si UP_DOWN == 1 o lo restamos si UP_DOWN == 0.
        else
            COUNT <= COUNT + (UP_DOWN ? 1'd1 : -1'd1);

    // TC cogerá el valor de UNO, en caso de que se halla finalizado la cuenta, y sino, cogerá valor CERO
	assign TC = UP_DOWN == 1'b1 ?
        (COUNT == modulo-1) ? 1'b1 : 1'b0 :
        (COUNT == 0)        ? 1'b1 : 1'b0;

end

endmodule
