module Intersection_tb();

    // Inputs
    reg clock;
    reg police_Interrupt;
    reg pedestrian_Hori_Street_Interrupt;
    reg pedestrian_Vert_Street_Interrupt;
    reg [3:0] traffic_Street_0;
    reg [3:0] traffic_Street_1;
    reg read_Write;
    reg memory_Enable;
    reg [6:0] address;
    reg street;

    // Outputs
    wire [3:0] traffic_Street;
    wire [2:0] led_North;
    wire [2:0] led_South;
    wire [2:0] led_West;
    wire [2:0] led_East;
    wire [1:0] led_Hori_North_East;
    wire [1:0] led_Hori_North_West;
    wire [1:0] led_Hori_South_East;
    wire [1:0] led_Hori_South_West;
    wire [1:0] led_Vert_North_East;
    wire [1:0] led_Vert_North_West;
    wire [1:0] led_Vert_South_East;
    wire [1:0] led_Vert_South_West;

    // Instantiate the Unit Under Test (UUT)
    Intersection uut (
        .clock(clock), 
        .police_Interrupt(police_Interrupt), 
        .pedestrian_Hori_Street_Interrupt(pedestrian_Hori_Street_Interrupt), 
        .pedestrian_Vert_Street_Interrupt(pedestrian_Hert_Street_Interrupt), 
        .traffic_Street_0(traffic_Street_0), 
        .traffic_Street_1(traffic_Street_1), 
        .read_Write(read_Write), 
        .memory_Enable(memory_Enable), 
        .address(address), 
        .street(street), 
        .traffic_Street(traffic_Street), 
        .led_North(led_North), 
        .led_South(led_South), 
        .led_West(led_West), 
        .led_East(led_East), 
        .led_Hori_North_East(led_Hori_North_East), 
        .led_Hori_North_West(led_Hori_North_West), 
        .led_Hori_South_East(led_Hori_South_East), 
        .led_Hori_South_West(led_Hori_South_West), 
        .led_Vert_North_East(led_Vert_North_East), 
        .led_Vert_North_West(led_Vert_North_West), 
        .led_Vert_South_East(led_Vert_South_East), 
        .led_Vert_South_West(led_Vert_South_West)
    );
    //always #0.5 clock =~clock;
    initial begin
        // Initialize Inputs
        $dumpfile("Intersection_tb.vcd");
        $dumpvars(0,Intersection_tb);


        clock = 0;
        police_Interrupt = 0;
        pedestrian_Hori_Street_Interrupt = 0;
        pedestrian_Vert_Street_Interrupt = 0;
        traffic_Street_0 = 0;
        traffic_Street_1 = 0;
        read_Write = 0;
        memory_Enable = 0;
        address = 0;
        street = 0;

        // Wait 100 ns for global reset to finish
        #100;
        clock = 1;
        #100;
        clock = 0;
        #100;
        clock = 1;  
    end      
endmodule

