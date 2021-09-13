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
ALSO, time must be in 64 bits to avoid Y2038 problem
*/


/*
Every button press for mode, cycle through these functionalities:
1. Counter with Lap 
2. Set alarm for hours and min(Alarm sounds after elapsed time)
3. Time and Date (Reset would change the time and date)
4. Set Alarm for Time and Date
*/




//NOTE: Use assign statement for continuous assignment (value changes accordingly) / combinatorial logic
                          



module Timer(
       input splitOrReset, modeInput, startOrStop, clockSignal,    
       input wire [4:0] inputHours, 
       input wire [5:0] inputMinutes, inputSeconds, inputDate, inputDay,
       input wire [13:0] inputYear,
       
       
       output reg [63:0] millisecondsTimeCount,
       output reg [4:0] timeInHoursDisplay, 
       output reg [5:0] timeInMinutesDisplay, timeInSeconds, dateDisplay, dayDisplay,
       output reg [6:0] millisecondsDisplay, 
       output reg [13:0] yearDisplay, 
       output reg ringSound
       
    );
    
    parameter timer = 2'b00, stopwatch = 2'b01, viewClockAndDate = 2'b10, setAlarm = 2'b11;
    
    
    //verilog doesn't support 2d array as input/output
    reg [10:0] lappedHours [4:0], lappedMinutes [4:0], lappedSeconds[4:0], lappedMilliseconds[4:0];

    
    //clock signal must be in 100Hz
    reg [1:0] mode;
    reg startFlagTimer, pause, startFlagStopWatch;    
    reg [23:0] timerAlarmCount, setTimeTimer;
    reg [4:0] lapIndex;
    
    //50 x 4 array for hours, 50 x 5 array for minutes, seconds, and milliseconds (will produces 50x 19 array in total)
    //^^ is better than 50 x 64 array 
    initial
    begin
        startFlagTimer = 0;//count down is disabled by default
        startFlagStopWatch = 0;
        mode =  2'b00; //mode at 0 by default
        
        
//        initialize array to 0
        
        
        
        //set initial count to 0
        //by default, time 0 is at 00:00:00 UTC on 1 January 1970 (see UNIX time, and Y2038 problem)
        millisecondsTimeCount = 0; 
        ringSound = 0; //initially the alarm is not ringing
    end
    
    
    always @ (posedge  modeInput)
    begin
        mode = mode + 2'b01; //cycle through the 4 modes (0 to 3) respectively
    end
    
    
    always @ (posedge startOrStop)
    begin
        case(mode) //if set was pressed during one of the modes
                timer: 
                   begin
                    if(timerAlarmCount == 0)
                        begin
                            startFlagTimer = 1;
                            
                        end
                        
                    else
                        begin
                            pause = !pause;
                        end
                    end
                stopwatch: 
                    begin
                        //lap when pressed, save it to 2d array
                        startFlagTimer = !startFlagTimer;
                    end
                viewClockAndDate: 
                    begin
                    end
                setAlarm: 
                    begin
                    end
                
            
            endcase        
    end
    
    always @ (posedge splitOrReset)
        begin
        
            case(mode)
                    timer: 
                       begin
                        //set the timer alarm count 
                        timerAlarmCount = 0;
                        pause = 1;
                        end
                    stopwatch: 
                        begin     
                            if(startFlagTimer != 1)
                            begin
                                
                            lappedMilliseconds [lapIndex] = lappedMilliseconds[lapIndex] + 1;
                            lappedSeconds[lapIndex] = lappedMilliseconds [lapIndex] / 100;
                            lappedMinutes[lapIndex] = lappedMilliseconds [lapIndex] / (60 * 100);
                            lappedHours[lapIndex] = lappedHours [lapIndex] / (60 * 60 * 100);
                            lapIndex = lapIndex +1;
                                //increment other timer
                            end
                            else
                            begin
                                
                            end                        
                                                   
                        end
                    viewClockAndDate: 
                        begin
                        end
                    setAlarm: 
                        begin
                        end
                    
                
                endcase        
        end
    
    always @ (posedge clockSignal) //when clock is high
        begin
            
            case(mode) //when clock is high and the mode is at X
                timer:
                   begin

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
            
            
            //Check if countdown is enabled
            if(startFlagTimer == 1)
            begin
                //timerAlarmCount = milliseconds + userDefinedMilliseconds 
                timerAlarmCount = millisecondsTimeCount + (100 * inputSeconds + 100 * 60 * inputMinutes + 100 * 60 * 24 * inputHours);
                setTimeTimer = millisecondsTimeCount;
                startFlagTimer = 0;
            end
            
            if(setTimeTimer < timerAlarmCount && !pause) //the moment user set time is reached, ring the alarm
            begin
                setTimeTimer = setTimeTimer + 1;
            end
            else if(setTimeTimer > timerAlarmCount)
            begin
                ringSound = 1;
                
            end            
            
            if(startFlagTimer == 1)
            begin
                
                                
                
            end
            
            
            
            //PUT FUNCTION TO CONTINUOUSLY CONVERT MILLISECONDS TO DATE AND TIME DISPLAY HERE 
           
           
           
           
           
            //increment millisecond count
            millisecondsTimeCount = millisecondsTimeCount + 1;
        end
    
    
    
    
     
endmodule