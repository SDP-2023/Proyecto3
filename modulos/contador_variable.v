module contador_variable #(
    parameter width_counter = 4
) (
    // Declaración de Entradas -->
    input clock, reset, enable, modo,
    input [width_counter-1:0] entrada,
    
    // Declaración de Salidas -->
    output reg[width_counter-1:0] cuenta,
    output fin_cuenta
);

localparam [width_counter-1:0] modulo_good = 2**width_counter-1;

wire [width_counter-1:0] cuenta_fin;

assign cuenta_fin = (modo == 1'b1) ? entrada : modulo_good;
assign fin_cuenta = ((cuenta == cuenta_fin) && (enable == 1'b1)) ? 1'b1 : 1'b0;

always @(posedge clock or negedge reset)
if (!reset)
    cuenta <= 0;
else if (enable)
    if (cuenta == cuenta_fin)
        cuenta = 0;
    else
        cuenta <= (cuenta + 1'b1);

endmodule
