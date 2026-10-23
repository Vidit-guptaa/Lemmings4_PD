module Lemmings4(
    input clk,
    input areset,  
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter LEFT = 3'b000,
              RIGHT = 3'b001,
              FALL_LEFT = 3'b010,
              FALL_RIGHT = 3'b011,
              DIG_LEFT = 3'b100,
              DIG_RIGHT = 3'b101,
              SPLATTER = 3'b110;    

    reg [2:0] state, next_state;
    reg [4:0] n;

    always @(*) begin
        next_state = state;

        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if(dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
            end

            FALL_LEFT: begin
                if (ground) begin
                    if (n > 5'd20)
                        next_state = SPLATTER;
                    else
                        next_state = LEFT;
                end
                else
                    next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground) begin
                    if (n > 5'd20)
                        next_state = SPLATTER;
                    else
                        next_state = RIGHT;
                end
                else 
                    next_state = FALL_RIGHT;
            end
            
            DIG_LEFT: begin
                if(~ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            
            DIG_RIGHT: begin
                if(~ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            
            SPLATTER: begin
                next_state = SPLATTER;
            end
            
            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        n <= 5'd0;
    end
    else begin
        state <= next_state;

        if (state == FALL_LEFT || state == FALL_RIGHT) begin
            if (n < 5'd21)
                n <= n + 1'b1;
        end
        else if (next_state == FALL_LEFT || next_state == FALL_RIGHT) begin
            n <= 5'd1;
        end
        else begin
            n <= 5'd0;
        end
    end
end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = ((state == FALL_LEFT) || (state == FALL_RIGHT));
    assign digging    = ((state == DIG_LEFT) || (state == DIG_RIGHT));

endmodule
