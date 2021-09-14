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


module timeToMili(
    input [21:0] inputMinutes,inputHours,inputSec,inputMili,
    output [64:0] outputMili //17 bits binary ng mili in days  

    );
    
    assign outputMili =  (inputHours*22'b1101101110111010000000)//3600000
     + (inputMinutes*16'b1110101001100000)//60000 
     + (inputSec*10'b1111101000)//1000 
     + inputMili;
    
    
endmodule
