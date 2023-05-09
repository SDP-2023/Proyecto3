/**
    En este proyecto diseñaremos un circuito controlador para un motor paso a paso, 
    basado en una máquina de estados finitos, y comprobaremos su funcionamiento mediante un emulador de motor.
**/

// HALF_FULL=1 --> (1 a 2) ; HF=0 --> ()
module control_motor(
    // Declaramos las señales de entradas -->
    input CLK, RESET, ENABLE, HALF_FULL, UP_DOWN,

    // Declaramos las señales de salida -->
    output reg A, B, C, D, INH1, INH2
) ;

// Declaramos los estados "actual" y "siguiente" respectivamente -->
reg [2:0] state, next_state;

// Declaramos los valores de los 8 estados que existen --> (3 bits) --> 2^3 = 8 -->
parameter s1 = 3'd0, s2 = 3'd1, s3 = 3'd2, s4 = 3'd3, s5 = 3'd4, s6 = 3'd5, s7 = 3'd6, s8 = 3'd7;

/**
 * Copia next_state a state al ritmo del reloj. También reinicia al estado s1 si se pulsa
 * el botón de RESET.
 */
always @(posedge CLK or negedge RESET) begin
    if(!RESET)
        state <= s1;
    else
        state <= next_state;
end

// Este modo es posiblemente más eficiente, pero no crea una máquina de estados
/*always @(HALF_FULL or UP_DOWN or ENABLE or state) begin
  if(ENABLE)
	 if(HALF_FULL)
		if(UP_DOWN)
		  next_state = state+1;
		else
		  next_state = state-1;
    else
	   if(UP_DOWN)
		  next_state = state+2;
	   else
		  next_state = state-2;
  else
	 next_state = state;
end*/

always @(HALF_FULL, UP_DOWN, ENABLE, state) begin
    if (ENABLE)
        if (HALF_FULL)
            if (UP_DOWN)
                // Incrementamos 1
                case (state)
                    s1: next_state = s2;
                    s2: next_state = s3;
                    s3: next_state = s4;
                    s4: next_state = s5;
                    s5: next_state = s6;
                    s6: next_state = s7;
                    s7: next_state = s8;
                    s8: next_state = s1;
                endcase
            else
                // Decrementamos 1
                case (state)
                    s1: next_state = s8;
                    s2: next_state = s1;
                    s3: next_state = s2;
                    s4: next_state = s3;
                    s5: next_state = s4;
                    s6: next_state = s5;
                    s7: next_state = s6;
                    s8: next_state = s7;
                endcase
        else
            if (UP_DOWN)
                // Incrementamos 2
                case (state)
                    s1: next_state = s3;
                    s2: next_state = s4;
                    s3: next_state = s5;
                    s4: next_state = s6;
                    s5: next_state = s7;
                    s6: next_state = s8;
                    s7: next_state = s1;
                    s8: next_state = s2;
                endcase
            else
                // Decrementamos 2
                case (state)
                    s1: next_state = s7;
                    s2: next_state = s8;
                    s3: next_state = s1;
                    s4: next_state = s2;
                    s5: next_state = s3;
                    s6: next_state = s4;
                    s7: next_state = s5;
                    s8: next_state = s6;
                endcase
    else
        // Mantenemos el estado si no está habilitado
        next_state = state;
end

always @(state) begin
    case(state)
        s1: begin A = 0; B = 1; C = 0; D = 1; INH1 = 1; INH2 = 1; end
        s2: begin A = 0; B = 0; C = 1; D = 1; INH1 = 0; INH2 = 1; end
        s3: begin A = 1; B = 0; C = 0; D = 1; INH1 = 1; INH2 = 1; end
        s4: begin A = 1; B = 0; C = 0; D = 0; INH1 = 1; INH2 = 0; end
        s5: begin A = 1; B = 0; C = 1; D = 0; INH1 = 1; INH2 = 1; end
        s6: begin A = 0; B = 0; C = 1; D = 0; INH1 = 0; INH2 = 1; end
        s7: begin A = 0; B = 1; C = 1; D = 0; INH1 = 1; INH2 = 1; end
        s8: begin A = 0; B = 1; C = 0; D = 0; INH1 = 1; INH2 = 0; end
        default: begin A = 0; B = 1; C = 0; D = 1; INH1 = 1; INH2 = 1; end
    endcase
end

endmodule 
