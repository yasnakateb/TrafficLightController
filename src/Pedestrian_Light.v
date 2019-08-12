module Pedestrian_Light(
    input_Wire,                 
    red,                        
    green
    );

    input  input_Wire;                  // 0 : red 
    output red;                         // 1 : green
    output green;

    assign  red = (input_Wire ==0);     
    assign  green = (input_Wire ==1);

endmodule
