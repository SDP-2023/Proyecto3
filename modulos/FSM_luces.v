/**
 * Máquina de estados finita que muestra un LED que se desplaza de lado a lado de una
 * matriz de 8 LEDs lineal al ritmo del reloj (CLK).
 */

module FSM_luces(
    // Declaración de Entradas -->
    input CLK, RSTn, ENABLE,
    
    // Declaración de Salidas -->
    output reg [7:0] LEDG
);

// Declaramos los registros de estado
reg [3:0] state, next_state;

// Declaramos el valor de los estados
localparam  S01 = 4'd0, S02 = 4'd1, S03 = 4'd2, S04 = 4'd3, S05 = 4'd4, S06 = 4'd5, S07 = 4'd6,
            S08 = 4'd7, S09 = 4'd8, S10 = 4'd9, S11 = 4'd10, S12 = 4'd11, S13 = 4'd12, S14 = 4'd13;

/**
 * Copia next_state a state al ritmo del reloj. También reinicia al estado S01 si se pulsa
 * el botón de RESET.
 */
always @(posedge CLK or negedge RESET)
    if(!RESET)
        state <= S01;
    else if (ENABLE)
        state <= next_state
    else
        state <= state;

/**
 * Cada vez que se actualiza el estado actual, dejamos next_state preparado para el siguiente
 * ciclo de reloj
 */
always @(state)
    case (state)
        S01: next_state = S02;
        S02: next_state = S03;
        S03: next_state = S04;
        S04: next_state = S05;
        S05: next_state = S06;
        S06: next_state = S07;
        S07: next_state = S08;
        S08: next_state = S09;
        S09: next_state = S10;
        S10: next_state = S11;
        S11: next_state = S12;
        S12: next_state = S13;
        S13: next_state = S14;
        S14: next_state = S01;
        default: next_state = state;
    endcase

/**
 * Establecemos el valor de la salida en base al estado actual
 */
always @(state)
    case (state)
        S01:      LEDG = 8'b10000000;
        S02, S14: LEDG = 8'b01000000;
        S03, S13: LEDG = 8'b00100000;
        S04, S12: LEDG = 8'b00010000;
        S05, S11: LEDG = 8'b00001000;
        S06, S10: LEDG = 8'b00000100;
        S07, S09: LEDG = 8'b00000010;
        S08:      LEDG = 8'b00000001;
    endcase

endmodule
