module Intersection(
    clock,
    police_Interrupt,
    pedestrian_Hori_Street_Interrupt,
    pedestrian_Vert_Street_Interrupt,
    traffic_Street_0,
    traffic_Street_1,
    read_Write,
    memory_Enable,
    address,
    street,
    traffic_Street,
    led_North,
    led_South,
    led_West,
    led_East,
    led_Hori_North_East,
    led_Hori_North_West,
    led_Hori_South_East,
    led_Hori_South_West,
    led_Vert_North_East,
    led_Vert_North_West,
    led_Vert_South_East,
    led_Vert_South_West
    );
    
    input clock;
    input police_Interrupt;
    input pedestrian_Hori_Street_Interrupt;
    input pedestrian_Vert_Street_Interrupt;
    input [3:0]traffic_Street_0;
    input [3:0]traffic_Street_1;
    input  read_Write;
    input  memory_Enable;
    input  [6:0]address;
    input  street;
    output [3:0] traffic_Street;
    output [2:0] led_North;
    output [2:0] led_South;
    output [2:0] led_West;
    output [2:0] led_East;
    output [1:0]led_Hori_North_East;
    output [1:0]led_Hori_North_West;
    output [1:0]led_Hori_South_East;
    output [1:0]led_Hori_South_West;
    output [1:0]led_Vert_North_East;
    output [1:0]led_Vert_North_West;
    output [1:0]led_Vert_South_East;
    output [1:0]led_Vert_South_West;

    wire [1:0] cable_North_South;                     
    wire [1:0] cable_West_East;
    wire  cable_Pedestrian_Hori_Street;
    wire  cable_Pedestrian_Vert_Street;
    Turn_Controller main_turn_controller (
        .clock(clock), 
        .ped_Hori_Interrupt(pedestrian_Hori_Street_Interrupt), 
        .ped_Vert_Interrupt(pedestrian_Vert_Street_Interrupt), 
        .police_Interrupt(police_Interrupt), 
        .traffic_Street_0(traffic_Street_0), 
        .traffic_Street_1(traffic_Street_1), 
        .address(address), 
        .read_Write(read_Write), 
        .enable(memory_Enable), 
        .street(street), 
        .north_South(cable_North_South), 
        .west_East(cable_West_East), 
        .pedestrian_Hori_Street(cable_Pedestrian_Hori_Street), 
        .pedestrian_Vert_Street(cable_Pedestrian_Hert_Street), 
        .traffic_Street(traffic_Street)
        );

    
    Traffic_Light north  (        
        .input_Wire(cable_North_South), 
        .red(led_North[2]), 
        .green(led_North[1]), 
        .yellow(led_North[0])
        );


    Traffic_Light south (
        .input_Wire(cable_North_South), 
        .red(led_South[2]), 
        .green(led_South[1]), 
        .yellow(led_South[0])
        );


    Traffic_Light west (
        .input_Wire(cable_West_East), 
        .red(led_West[2]), 
        .green(led_West[1]), 
        .yellow(led_West[0])
        );


    Traffic_Light east (
        .input_Wire(cable_West_East), 
        .red(led_East[2]), 
        .green(led_East[1]), 
        .yellow(led_East[0])
        );


    Pedestrian_Light hori_north_east (
        .input_Wire(cable_Pedestrian_Hori_Street), 
        .red(led_Hori_North_East[1]), 
        .green(led_Hori_North_East[0])
        );


    Pedestrian_Light hori_south_east (
        .input_Wire(cable_Pedestrian_Hori_Street), 
        .red(led_Hori_South_East[1]), 
        .green(led_Hori_South_East[0])
        );


    Pedestrian_Light hori_north_west (
        .input_Wire(cable_Pedestrian_Hori_Street), 
        .red(led_Hori_North_West[1]), 
        .green(led_Hori_North_West[0])
        );


    Pedestrian_Light hori_south_west (
        .input_Wire(cable_Pedestrian_Hori_Street), 
        .red(led_Hori_South_West[1]), 
        .green(led_Hori_South_West[0])
        );


    Pedestrian_Light vert_north_east (
        .input_Wire(cable_Pedestrian_Vert_Street), 
        .red(led_Vert_North_East[1]), 
        .green(led_Vert_North_East[0])
        );


    Pedestrian_Light vert_north_west (
        .input_Wire(cable_Pedestrian_Vert_Street), 
        .red(led_Vert_North_West[1]), 
        .green(led_Vert_North_West[0])
        );


    Pedestrian_Light vert_south_east (
        .input_Wire(cable_Pedestrian_Vert_Street), 
        .red(led_Vert_South_East[1]), 
        .green(led_Vert_South_East[0])
        );

         
    Pedestrian_Light vert_south_west (
        .input_Wire(cable_Pedestrian_Vert_Street), 
        .red(led_Vert_South_West[1]), 
        .green(led_Vert_South_West[0])
        );

endmodule
