`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2021 19:02:47
// Design Name: 
// Module Name: Timer
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

/*
Project Features:
- Lap/ Counter/ Incrementer
- Timer/ Set and Decrementer
- Clock (optional)
- Alarm (optional)
- Date and Day (Optional)

*/


//Timer Based on : https://www.hartsport.com.au/coaching/stopwatches-and-timers/stopwatches/hart-sports-timer-yellow

/*
By default, mode is at time and date
ALSO, time must be in 64 bits to avoid Y2K problem
*/


/*
Every button press for mode, cycle through these functionalities:
1. Counter with Lap 
2. Set alarm for hours and min(Alarm sounds after elapsed time)
3. Time and Date (Reset would change the time and date)
4. Set Alarm for Time and Date
*/

/*
Separate clock for time and date, AND counter
Clicking the start/stop would stop the ringing
*/

/*
Functions to Add:
Function to Convert Milliseconds to Date, time, and day for display
Function to Alarm given user input and expected time in milliseconds  (using always statement)
Function to dismiss alarm using always statement (using always statement)

*/

/*
Frame of the program (I can do this):
    Will detect which mode and what functions would do accordingly
*/


//NOTE: Use assign statement for continuous assignment (value changes accordingly) / combinatorial logic



module Timer(
       input splitOrReset, mode, startOrStop,
       output timeCounterCount, datAndTimeCounterCount, dateDisplay, dayDisplay, yearDisplay, ringSound
    );
    
     
endmodule
