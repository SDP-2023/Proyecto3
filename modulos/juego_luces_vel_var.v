/**
 * Diseño de un juego de luces tipo coche fantástico, con velocidad variable mediante
 * dos botones..
 */

module juego_luces_vel_var(
    // Declaración de Entradas -->
    input CLOCK_50,
    input [1:0] SW,
    input [2:0] KEY,
    
    // Declaración de Salidas -->
    output [7:0] LEDG,
    output [7:0] LEDR
);

wire fin_cuenta_counter2, fin_cuenta_variable;
wire enable_speed, up_down_speed;
wire [3:0] cuenta;

contador #(
    .modulo(5_000_000)
) counter2 (
    .CLK(CLOCK_50),
    .RSTn(KEY[0]),
    .ENABLE(SW[0]),
    .UP_DOWN(SW[0]),
    .COUNT(),
    .TC(fin_cuenta_counter2)
);

FSM_luces FSM_luces_kit_medvedev (
    .CLK(CLOCK_50),
    .RSTn(KEY[0]),
    .ENABLE(fin_cuenta_variable),
    .LEDG(LEDG)
);

contador_variable #(
    .width_counter(4)
) contador_var (
    .clock(CLOCK_50),
    .reset(KEY[0]),
    .entrada(cuenta),
    .enable(fin_cuenta_counter2),
    .modo(SW[1]),
    .cuenta(LEDR[7:4]),
    .fin_cuenta(fin_cuenta_variable)
);

FSM_speed FSM_speed_mealy (
    .CLK(CLOCK_50),
    .RSTn(KEY[0]),
    .Key2(KEY[2]),
    .Key1(KEY[1]),
    .ENABLE(enable_speed),
    .UP_DOWN(up_down_speed)
);

contador #(
    .modulo(16)
) contador_up_down (
    .CLK(CLOCK_50),
    .RSTn(KEY[0]),
    .ENABLE(enable_speed),
    .UP_DOWN(up_down_speed),
    .COUNT(cuenta),
    .TC()
);

assign LEDR[3:0] = cuenta;

endmodule