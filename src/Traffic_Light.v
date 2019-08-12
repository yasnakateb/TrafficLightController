module Traffic_Light(
    input_Wire,                 
    red,                        
    green,                          
    yellow
    );

    input [1:0] input_Wire;                 // 00 : red 
    output red;                             // 01 : green
    output green;                           // 10 : yellow
    output yellow;

    assign  red = (input_Wire ==0);     
    assign  green = (input_Wire ==1);
    assign  yellow = (input_Wire ==2);

endmodule
