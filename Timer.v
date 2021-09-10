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
Not exactly Separate clock for time and date, AND counter since I could use arithmetic operations instead of manual flip flops
Clicking the start/stop would stop the ringing
*/




//NOTE: Use assign statement for continuous assignment (value changes accordingly) / combinatorial logic






module Timer(
       input splitOrReset, modeInput, startOrStop, clockSignal,
       output millisecondsTimeCount, timeInHoursDisplay, timeInHoursDisplay,
            timeInMinutesDisplay, dateDisplay, dayDisplay, yearDisplay, ringSound
    );
    
    //clock signal must be in 100Hz
    reg [64:0] millisecondsTimeCount;
    reg dateDisplay, dayDisplay, yearDisplay, 
        mode, ringSound, countDownEnabled, userSetCountDown;
    /*
    MODES IN ORDER:
    
    1. Timer
        - Given the number of hours and min, count down\
        - Start, Stop, and Reset to 0
    2. Stopwatch:
        - Start from 00:00:00 and count up until user presses stop
        - Lap and stop
    3. View time and date
        - Display Time and Date
        - Time and Date could be edited using reset
    4. Set alarm for time 
        - Some pins would be converted to left, right, and down
        - User would be able to set time for alarm
        - Alarm will be high when alarm sounds and will only go low when user presses button
    */
        
    initial
    begin
        countDownEnabled = 0;//count down is disabled by default
        mode =  2'b00; //mode at 0 by default 
        millisecondsTimeCount = 0; //set initial count to 0
        ringSound = 0; //initially the alarm is not ringing
    end

    
    always @ (posedge modeInput)
    begin
        mode = mode + 2'b01;
        //if mode overflows, it resets back to 00
    end
    
    
    
    
    
    always @ (posedge clockSignal)
        begin
            case(mode)
                2'b00: //Timer mode (decrement)
                    begin
                    /*
                        enable edit time functionality:
                            - mode would set the time and switch modes
                            - start would move down
                            - split reset would move right circularly
                    */
                        
//                        case(countDownEnabled)
//                        1:
//                        begin
                        
                        
//                        end
                        
//                        0:
//                        begin
//                        end
                        
                        
//                        endcase
                        
                        
                    
                    
                    end
                2'b01: //Stopwatch mode (increment)
                    begin
                    end
                2'b10: //View time and date mode 
                    begin
                    end
                2'b11: //Set time and alarm mode
                    begin
                    end
                
            
            endcase
            
            
            
            
            //Code to countdown, decrementing the milleseconds and sound the alarm when finished
            
            
            
            //PUT FUNCTION TO CONTINUOUSLY CONVERT MILLISECONDS TO DATE AND TIME HERE 
            
            //CODE TO DISMISS ALARM HERE IF SOUND IS RINGING
            if(ringSound == 1 & startOrStop == 1)
            begin
                ringSound = 0;
            end
            
            
            
            //increment millisecond count
            millisecondsTimeCount = millisecondsTimeCount + 1;
        end
    
    
    
    
     
endmodule