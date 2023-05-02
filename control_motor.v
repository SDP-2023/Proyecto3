/**
    En este proyecto diseñaremos un circuito controlador para un motor paso a paso, 
    basado en una máquina de estados finitos, y comprobaremos su funcionamiento mediante un emulador de motor.
**/
// HALF_FULL=1 --> (1 a 2) ; HF=0 --> ()
module control_motor(
// Declaramos las señales de entradas -->
input CLK, RESET, ENABLE, HALF_FULL, UP_DOWN ,
// Declaramos las señales de salida -->
output reg A, B, C, D, INH1, INH2

) ;
// Declaramos los estados "actual" y "siguiente" respectivamente -->
reg [2:0] state, next_state ;
// Declaramos los valores de los 8 estados que existen --> (3 bits) --> 2^3 = 8 -->
parameter s1 = 3'd0, s2 = 3'd1, s3 = 3'd2, s4 = 3'd3, s5 = 3'd4, s6 = 3'd5, s7 = 3'd6, s8 = 3'd7 ;

always @(posedge CLK or negedge RESET) begin
    if(!RESET)
        state <= s1 ;
    else begin
        state <= next_state ;
    end
end

always @(HALF_FULL or UP_DOWN or ENABLE or state) begin
    if(ENABLE)
        begin
            if(HALF_FULL)
            begin
                if(UP_DOWN)
                    next_state <= state+1 ;
                else
                    next_state <= state-1 ;
            end
            else
                begin
                    if(UP_DOWN)
                        next_state <= state+2 ;
                    else
                        next_state <= state-2 ;
                end
        end

end

always @(state) begin
    case(state)
        s1: begin
            A = 0;
            B = 1;
            C = 0;
            D = 1;
            INH1 = 1;
            INH2 = 1;
        end
        s2: begin
            A = 0;
            B = 0;
            C = 1;
            D = 1;
            INH1 = 0;
            INH2 = 1;
        end
        s3: begin
            A = 1;
            B = 0;
            C = 0;
            D = 1;
            INH1 = 1;
            INH2 = 1;
        end
        s4: begin
            A = 1;
            B = 0;
            C = 0;
            D = 0;
            INH1 = 1;
            INH2 = 0;
        end
        s5: begin
            A = 1;
            B = 0;
            C = 1;
            D = 0;
            INH1 = 1;
            INH2 = 1;
        end
        s6: begin
            A = 0;
            B = 0;
            C = 1;
            D = 0;
            INH1 = 0;
            INH2 = 1;
        end
        s7: begin
            A = 0;
            B = 1;
            C = 1;
            D = 0;
            INH1 = 1;
            INH2 = 1;
        end
        s8: begin
            A = 0;
            B = 1;
            C = 0;
            D = 0;
            INH1 = 1;
            INH2 = 0;
        end
        default: begin
            A = 0;
            B = 1;
            C = 0;
            D = 1;
            INH1 = 1;
            INH2 = 1;
        end
    endcase 


end

endmodule 