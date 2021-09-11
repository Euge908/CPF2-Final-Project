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




module Timer(
       input splitOrReset, modeInput, startOrStop, clockSignal,
       output reg millisecondsTimeCount, timeInHoursDisplay,
            timeInMinutesDisplay, dateDisplay, dayDisplay, yearDisplay, ringSound
    );
    
    parameter timer = 2'b00, stopwatch = 2'b01, viewClockAndDate = 2'b10, setAlarm = 2'b11;
    
    //clock signal must be in 100Hz
    reg [64:0] millisecondsTimeCount;
    reg mode, countDownEnabled, userSetCountDown, index;    
    reg [64:0] timerAlarmCount;
    
    reg [5:0] userCountDownHours;
    reg [6:0] userCountDownMinutes, userCountDownSeconds;
    
    
    initial
    begin
        countDownEnabled = 0;//count down is disabled by default
        mode =  2'b00; //mode at 0 by default
        //set initial count to 0
        //by default, time 0 is at 00:00:00 UTC on 1 January 1970 (see UNIX time, and Y2038 problem)
        millisecondsTimeCount = 0; 
        ringSound = 0; //initially the alarm is not ringing
        index = 2'b00; //initially the index is at the left most
    end
    
    always @ (posedge splitOrReset, posedge clockSignal) //if splitOrResetButton is pressed while clocksignal is high
    begin   
        case(mode)
                timer:
                   begin
                    index = index + 2'b01; //index cycles from 0 to 2 since there are only 3 positions (hours: minute:seconds)
                    
                    if(index == 2'b11) //if index is 3, then set it to 0 for uniformity
                    begin
                        index = 2'b00;
                    end
                    
                   end
                stopwatch: 
                    begin
                    end
                viewClockAndDate: 
                    begin
                    end
                setAlarm:
                    begin
                    end
                
            
            endcase
    
    end
    
    always @ (posedge startOrStop, posedge clockSignal)//if startOrStop button is pressed while clocksignal is high
    begin
    
        case(mode)
                timer: 
                   begin
                   
                   //if alarm is ringing, dismiss it
                   if(ringSound == 1)
                    begin
                        ringSound = 0;
                    end
                   else//else go to the code below
                    case(index)
                        2'b01:
                        begin
                            case (index)
                                2'b00: //index is at hours
                                begin
                                    userCountDownHours = userCountDownHours + 1;
                                    
                                    if(userCountDownHours > 24)
                                    begin
                                        userCountDownHours = 0;
                                    end
                                    
                                end
                                
                                2'b01: //index is at minutes
                                begin
                                    userCountDownMinutes = userCountDownMinutes+ 1;
                                    
                                    if(userCountDownMinutes > 59)
                                    begin
                                        userCountDownHours = 0;
                                    end
                                
                                end
                                
                                2'b11: //index is at seconds
                                begin
                                    userCountDownSeconds = userCountDownSeconds+ 1;
                                    
                                    if(userCountDownSeconds > 59)
                                    begin
                                        userCountDownSeconds = 0;
                                    end
                                end
                            
                            endcase
                        
                        end
                    endcase
                   
                   end
                stopwatch: 
                    begin
                    end
                viewClockAndDate: 
                    begin
                    end
                setAlarm: 
                    begin
                    end
                
            
            endcase
    
    
            //CODE TO DISMISS ALARM HERE IF SOUND IS RINGING
            
    end


    always @ (posedge modeInput, posedge clockSignal) //if modeInput Button is pressed while clocksignal is high
    begin
    
        case(mode)
                timer: 
                   begin
                    //enabled countdown
                    countDownEnabled = 1;
                    
                   end
                stopwatch: 
                    begin
                    end
                viewClockAndDate: 
                    begin
                    end
                setAlarm: 
                    begin
                    end
                
            
            endcase
        mode = mode + 2'b01; //cycle through the 4 modes (0 to 3)
        
    end
    
    
    always @ (posedge clockSignal) //when clock is high
        begin
            //Check if countdown is enabled
            if(countDownEnabled == 1)
            begin
                //timerAlarmCount = milliseconds + userDefinedMilliseconds 
                timerAlarmCount = millisecondsTimeCount + (100 * userCountDownSeconds + 100 * 60 * userCountDownMinutes + 100 * 60 * 60 * userCountDownSeconds);
                countDownEnabled = 0; //disable count down
            end
            
            if(timerAlarmCount < millisecondsTimeCount) //the moment user set time is reached, set the alarm
            begin
                ringSound = 1;
            end
            
            
            
            //PUT FUNCTION TO CONTINUOUSLY CONVERT MILLISECONDS TO DATE AND TIME DISPLAY HERE 
            
            
            
            
            
            //increment millisecond count
            millisecondsTimeCount = millisecondsTimeCount + 1;
        end
    
    
    
    
     
endmodule