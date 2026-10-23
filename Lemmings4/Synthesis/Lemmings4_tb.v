
`timescale 1ns/1ps

module Lemmings4_tb;

    reg clk;
    reg areset;
    reg bump_left;
    reg bump_right;
    reg ground;
    reg dig;

    wire walk_left;
    wire walk_right;
    wire aaah;
    wire digging;

    integer errors;

    localparam LEFT       = 3'b000;
    localparam RIGHT      = 3'b001;
    localparam FALL_RIGHT = 3'b011;
    localparam DIG_RIGHT  = 3'b101;
    localparam SPLATTER   = 3'b110;

    Lemmings4 dut (
        .clk(clk),
        .areset(areset),
        .bump_left(bump_left),
        .bump_right(bump_right),
        .ground(ground),
        .dig(dig),
        .walk_left(walk_left),
        .walk_right(walk_right),
        .aaah(aaah),
        .digging(digging)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check_state;
        input [2:0] expected;
        input [200*8:1] test_name;
        begin
            if (dut.state !== expected) begin
                $display("FAIL: %0s | expected state=%b, got=%b at %0t",
                         test_name, expected, dut.state, $time);
                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s at %0t", test_name, $time);
            end
        end
    endtask

    initial begin
        $dumpfile("Lemmings4.vcd");
        $dumpvars(0, Lemmings4_tb);

        errors = 0;

        areset = 1;
        bump_left = 0;
        bump_right = 0;
        ground = 1;
        dig = 0;

        // Verify asynchronous reset
        #1;
        check_state(LEFT, "Reset enters LEFT");

        #11;
        areset = 0;

        // LEFT -> RIGHT
        @(negedge clk);
        bump_left = 1;
        @(negedge clk);
        check_state(RIGHT, "Bump changes LEFT to RIGHT");
        bump_left = 0;

        // RIGHT -> DIG_RIGHT
        dig = 1;
        @(negedge clk);
        check_state(DIG_RIGHT, "Dig enters DIG_RIGHT");
        dig = 0;

        // DIG_RIGHT -> FALL_RIGHT
        ground = 0;
        @(negedge clk);
        check_state(FALL_RIGHT, "Leaving ground enters FALL_RIGHT");

        // Short fall: land before counter exceeds 20
        repeat (3) @(negedge clk);
        ground = 1;
        @(negedge clk);
        check_state(RIGHT, "Short fall recovers to RIGHT");

        // Start a long fall
        ground = 0;
        @(negedge clk);
        check_state(FALL_RIGHT, "Second fall enters FALL_RIGHT");

        // Remain falling long enough for n to reach 21
        repeat (22) @(negedge clk);
        ground = 1;
        @(negedge clk);
        check_state(SPLATTER, "Long fall enters SPLATTER");

        // SPLATTER must be absorbing
        repeat (2) @(negedge clk);
        check_state(SPLATTER, "SPLATTER remains permanent");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule

