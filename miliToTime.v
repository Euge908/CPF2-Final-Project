`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.09.2021 00:20:12
// Design Name: 
// Module Name: timeToMili
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module militoTime(
    output reg [21:0] outputMinutes,outputHours,outputSec,outputMili,
    input [63:0]  inputMili//17 bits binary ng mili in days  

    );
    integer i;
    //kasi bawal ma reg yung input temp na lang 
    reg  [63:0] temp;
    
 
    always@(inputMili)
    begin
    //put input to temp 
    temp = inputMili;
    outputMili = 1'b0;
    //while loop causes error synthesis needs defined time.
    for ( i = 0; i < 4; i = i + 1 )
    begin
    //check if larger or equal to an hour 
    if(temp>=22'b1101101110111010000000)//3600000
        begin 
        outputHours = temp/22'b1101101110111010000000;
        temp = temp%22'b1101101110111010000000;
        end
     //check if larger or equal to a minute     
    else if(temp>=16'b1110101001100000)//60000 
        begin 
        outputMinutes = temp/16'b1110101001100000;
        temp = temp%16'b1110101001100000;
        end
     //check if larger or equal to a sec    
    else if(temp>=10'b1111101000)//1000 
        begin 
        outputSec = temp/10'b1111101000;
        temp = temp%10'b1111101000;
        end   
    //if below 1000ms or 1 sec then add all to ms 
    else if(10'b1111101000>temp )
        begin 
        outputMili = outputMili+temp;
        temp = 1'b0;
        end           
    
    
    end
    end
    
    
 
    
    
endmodule
