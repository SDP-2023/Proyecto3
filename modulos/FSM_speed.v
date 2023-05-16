/**
 * Módulo de control para un contador. Cuando se pulse KEY2 el contador se incrementará, y
 * cuando se pulse KEY1, se decrementará. El contador es del tipo contador.v, así que las
 * salidas de este módulo ENABLE y UP_DOWN se conectan a las entradas homónimas del contador,
 * lo que debería ser suficiente para manejar su correcto funcionamiento.
 */

module FSM_speed(
    // Declaración de Entradas -->
    input CLK, RSTn, Key1, Key2,
    
    // Declaración de Salidas -->
    output reg ENABLE, UP_DOWN
);

// Declaramos el registro de estado
reg [1:0] state;

// Guardamos el estado anterior, para asegurarnos que si se mantienen pulsados los
// pulsadores sólo se manda un pulso por la salida
reg Key1_prev, Key2_prev;

// Declaramos el valor de los estados
localparam STATE_IDLE = 2'd0, STATE_INCR = 2'd1, STATE_DECR = 2'd2;

/**
 * Copia next_state a state al ritmo del reloj. También reinicia al estado S01 si se pulsa
 * el botón de RESET.
 */
always @(posedge CLK or negedge RSTn) begin
    if(!RSTn) begin
        state <= STATE_IDLE;
        ENABLE <= 0;
        UP_DOWN <= 0;
        Key1_prev <= 1;
        Key2_prev <= 1;
    end
    else begin
        case (state)
        STATE_IDLE: begin
            // Key1 decrementa
            if (!Key1 && Key1_prev) begin
                state <= STATE_DECR;
                ENABLE <= 1;
                UP_DOWN <= 1;
            end
            // Key2 incrementa
            else if (!Key2 && Key2_prev) begin
                state <= STATE_INCR;
                ENABLE <= 1;
                UP_DOWN <= 0;
            end
            else begin
                state <= STATE_IDLE;
                ENABLE <= 0;
                UP_DOWN <= 0; // Realmente da igual
            end
        end
        // Cuando se llegue al estado de incremento o decremento, reiniciamos al estado IDLE
        STATE_INCR, STATE_DECR: begin
            state <= STATE_IDLE;
            ENABLE <= 0;
            UP_DOWN <= 0; // Realmente da igual
        end
        endcase
        
        Key1_prev <= Key1;
        Key2_prev <= Key2;
    end
end


endmodule
