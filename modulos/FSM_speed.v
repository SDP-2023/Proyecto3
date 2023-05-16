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
    output ENABLE, UP_DOWN
);

// Declaramos los registros de estado
reg [1:0] state, next_state;

// Declaramos el valor de los estados
localparam STATE_IDLE = 2'd0, STATE_INCR = 2'd1, STATE_DECR = 2'd2;

/**
 * Copia next_state a state al ritmo del reloj. También reinicia al estado S01 si se pulsa
 * el botón de RESET.
 */
always @(posedge CLK, negedge RSTn, negedge Key1, negedge Key2) begin
    if(!RSTn)
        state <= STATE_IDLE;
    else
        state <= next_state;

    // Key1 decrementa
    // Key2 incrementa
    // Reiniciamos el estado a IDLE
    next_state = !Key1 ? STATE_DECR : !Key2 ? STATE_INCR : STATE_IDLE;
end


// Enable estará habilitado siempre y cuando no estemos en IDLE
assign ENABLE = state != STATE_IDLE;

// La dirección será hacia abajo cuando el estado sea de decremento
assign UP_DOWN = state == STATE_DECR;

endmodule
