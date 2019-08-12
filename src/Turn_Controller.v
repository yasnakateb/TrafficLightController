module Turn_Controller(
    clock,
    ped_Hori_Interrupt,
    ped_Vert_Interrupt,
    police_Interrupt,
    traffic_Street_0,
    traffic_Street_1,
    address,
    read_Write,                                             
    enable,                                                 
    street,                                               
    north_South,                                            
    west_East ,                                           
    pedestrian_Hori_Street,    
    pedestrian_Vert_Street,
    traffic_Street
    );

    input clock;
    input ped_Hori_Interrupt;
    input ped_Vert_Interrupt;
    input police_Interrupt;
    input [3:0]traffic_Street_0;
    input [3:0]traffic_Street_1;
    input [6:0] address;
    input read_Write;                              
    input enable;                                     
    input street;                                     
    output reg [1:0] north_South = 0;                 
    output reg [1:0] west_East = 0;                    
    output reg pedestrian_Hori_Street = 0;    
    output reg pedestrian_Vert_Street = 0;
    output reg [3:0] traffic_Street = 4'b0;
            
    reg turn=0;                                                     
    reg [5:0] clk_Counter = 6'd0;       
    reg [5:0] max_Red_0 = 6'd19;                                        
    reg [5:0] max_Red_1 = 6'd19;        
    reg [5:0] hori_Three_Sec_Before_Red = 6'd0;                         
    reg [5:0] vert_Three_Sec_Before_Red = 6'd0;
    reg [5:0] max_Green_0 = 6'd15;
    reg [5:0] max_Green_1 = 6'd15;
    reg [5:0] max_Yellow_0 = 6'd4;
    reg [5:0] max_Yellow_1 = 6'd4;  
    reg [2:0] pol_Hori_Interrupt_Counter = 3'd0;                            
    reg [2:0] pol_Vert_Interrupt_Counter = 3'd0;
    reg [1:0] ped_Hori_Interrupt_Counter = 2'd0;                            
    reg [1:0] ped_Vert_Interrupt_Counter = 2'd0;
    reg [6:0] counter = 7'b0;                                   
    reg [3:0] street_0 [0:128];                                 
    reg [3:0] street_1 [0:128];
    always @(posedge clock) begin
        if (enable == 1) begin
            if (read_Write == 0) begin                              
                if(street == 0)                                         
                    traffic_Street = street_0[address];
                else                                                
                    traffic_Street = street_1[address];
            end     
            else begin                                              
                street_0[counter] = traffic_Street_0;
                street_1[counter] = traffic_Street_1;
                counter = counter + 7'd1;
            end 
        end 
    end         
                     
    always @ (posedge clock) begin                                  
        if (traffic_Street_0 < 5)
            max_Yellow_0 = 6'd4;
        else if (traffic_Street_0 < 10 )
            max_Yellow_0 = 6'd4 + 6'd1;
        else
            max_Yellow_0 = 6'd4 + 6'd2;                             
        if (traffic_Street_1 < 5)
            max_Yellow_1 = 6'd4;
        else if (traffic_Street_1 < 10 )
            max_Yellow_1 = 6'd4 + 6'd1;
        else
            max_Yellow_1 = 6'd4 + 6'd2;     
                                            
        max_Green_0 = 6'd15 + traffic_Street_0;             
        max_Green_1 = 6'd15 + traffic_Street_1;
        max_Red_0   = max_Green_1 + max_Yellow_1;           
        max_Red_1   = max_Green_0 + max_Yellow_0;
        vert_Three_Sec_Before_Red = max_Red_0 - 6'd3;
        hori_Three_Sec_Before_Red = max_Red_1 - 6'd3;
         
        if ((turn == 0 && clk_Counter == max_Red_0)      || 
            (turn == 1 && clk_Counter == max_Red_1)      ||
            (pol_Hori_Interrupt_Counter == max_Yellow_0 )||
            (pol_Vert_Interrupt_Counter == max_Yellow_1)) 
            begin 
                clk_Counter = 6'd0;                             
                turn = ~turn;
                ped_Vert_Interrupt_Counter = 0;                             
                ped_Hori_Interrupt_Counter = 0;
                pol_Hori_Interrupt_Counter = 0;
                pol_Vert_Interrupt_Counter = 0;
            end
        else  
            clk_Counter = clk_Counter + 6'd1;                   
        
        if (turn == 0) begin
            north_South <= 2'b00;
            pedestrian_Vert_Street = 1;                     
            pedestrian_Hori_Street = 0;                     
            if (clk_Counter > max_Green_0)
                west_East <= 2'b10;
            else begin
                if (police_Interrupt == 1) begin
                    pol_Hori_Interrupt_Counter <= pol_Hori_Interrupt_Counter + 3'd1;
                    west_East <= 2'b10;                 
                end
                else 
                    west_East <= 2'b01;     
            end 
            
            if (ped_Vert_Interrupt == 1 &&
                ped_Vert_Interrupt_Counter < 2) begin
                if (clk_Counter  > vert_Three_Sec_Before_Red) begin
                    clk_Counter  = vert_Three_Sec_Before_Red +6'b1;
                    ped_Vert_Interrupt_Counter <= ped_Vert_Interrupt_Counter + 2'd1;
                end             
            end 
        end
        else if (turn ==1) begin
            west_East<= 2'b00;
            pedestrian_Vert_Street = 0;
            pedestrian_Hori_Street = 1;
            if (clk_Counter > max_Green_1)
                north_South <= 2'b10;
            else begin
                if (police_Interrupt == 1) begin
                    pol_Vert_Interrupt_Counter <= pol_Vert_Interrupt_Counter + 3'd1;
                    north_South <= 2'b10;
                end 
                else begin
                    north_South <= 2'b01;
                end 
            end     
            if (ped_Hori_Interrupt == 1 &&
                ped_Hori_Interrupt_Counter < 2) begin
                if (clk_Counter  > hori_Three_Sec_Before_Red) begin
                    clk_Counter = hori_Three_Sec_Before_Red+6'b1;
                    ped_Hori_Interrupt_Counter <= ped_Hori_Interrupt_Counter + 2'd1;
                end 
            end     
        end     
    end
        
endmodule

