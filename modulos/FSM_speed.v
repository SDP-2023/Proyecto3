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
reg state, next_state;

// Declaramos el valor de los estados
localparam STATE_IDLE = 2'd0, STATE_INCR = 2'd1, STATE_DECR = 2'd2;

/**
 * Copia next_state a state al ritmo del reloj. También reinicia al estado S01 si se pulsa
 * el botón de RESET.
 */
always @(posedge CLK or negedge RSTn) begin
    if(!RSTn)
        state <= STATE_IDLE;
    else if (ENABLE)
        state <= next_state;
    else
        state <= state;

    // Reiniciamos el estado a IDLE
    next_state = STATE_IDLE;
end


// Key1 decrementa
always @(posedge Key1) next_state = STATE_DECR;

// Key2 incrementa
always @(posedge Key2) next_state = STATE_INCR;


// Enable estará habilitado siempre y cuando no estemos en IDLE
assign ENABLE = state != STATE_IDLE;

// La dirección será hacia abajo cuando el estado sea de decremento
assign UP_DOWN = state == STATE_DECR;

endmodule
