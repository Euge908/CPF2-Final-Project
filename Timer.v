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



//Note to self: get rid of excess binary bits necessary
//MODULES don't seem to work insde an always block, so I placed the raw code instead
//Also verilog arrays are inclusive. Meaning [4:0] is actually 5 bits

module Timer(
       input splitOrReset, modeInput, startOrStop, clockSignal,    
       input wire [4:0] inputHours, 
       input wire [5:0] inputMinutes, inputSeconds,
       
       output reg [4:0] timeInHoursDisplay, 
       output reg [5:0] timeInMinutesDisplay, timeInSeconds,
       output reg [6:0] millisecondsDisplay, 
       output reg ringSound
       
    );
       
    parameter timer = 2'b00, stopwatch = 2'b01, viewClockAndDate = 2'b10, setAlarm = 2'b11, twentyFourHours = 8640000;
    
    //verilog doesn't support 2d array as input/output
    reg [4:0] lappedHours [9:0], lappedMinutes [9:0], lappedSeconds[9:0], lappedMilliseconds[9:0];
    reg [23:0] millisecondsTimeCount, lappedMillisecondsCount;

    
    //clock signal must be in 100Hz
    reg [1:0] mode;
    reg startFlagTimer, startFlagStopWatch, pause;    
    reg [23:0] timerAlarmCount, clockAlarm;
    reg lapIndex;


    initial
    begin
        lapIndex = 0; //by default the lap position is at 0
        startFlagTimer = 0;//count down is disabled by default
        startFlagStopWatch = 0;
        
        mode =  2'b00; //mode at 0 by default
        
        lappedMillisecondsCount = 0;
        
        //Used to use loops, but they slowed the simulation too much
        lappedSeconds[0] = 0;
        lappedSeconds[1] = 0;
        lappedSeconds[2] = 0;
        lappedSeconds[3] = 0;
        lappedSeconds[4] = 0;
        lappedSeconds[5] = 0;
        lappedSeconds[6] = 0;
        lappedSeconds[7] = 0;
        lappedSeconds[8] = 0;
        lappedSeconds[9] = 0;
        
        lappedMinutes[0] = 0;
        lappedMinutes[1] = 0;
        lappedMinutes[2] = 0;
        lappedMinutes[3] = 0;
        lappedMinutes[4] = 0;
        lappedMinutes[5] = 0;
        lappedMinutes[6] = 0;
        lappedMinutes[7] = 0;
        lappedMinutes[8] = 0;
        lappedMinutes[9] = 0;

        lappedMilliseconds[0] = 0;
        lappedMilliseconds[1] = 0;
        lappedMilliseconds[2] = 0;
        lappedMilliseconds[3] = 0;
        lappedMilliseconds[4] = 0;
        lappedMilliseconds[5] = 0;
        lappedMilliseconds[6] = 0;
        lappedMilliseconds[7] = 0;
        lappedMilliseconds[8] = 0;
        lappedMilliseconds[9] = 0;

        lappedHours[0] = 0;
        lappedHours[1] = 0;
        lappedHours[2] = 0;
        lappedHours[3] = 0;
        lappedHours[4] = 0;
        lappedHours[5] = 0;
        lappedHours[6] = 0;
        lappedHours[7] = 0;
        lappedHours[8] = 0;
        lappedHours[9] = 0;

    //for performance issues, set all to 0 instead of looping
        
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
                        startFlagStopWatch = !startFlagStopWatch;
                    end
                viewClockAndDate: 
                    begin
                        //do nothing
                    end
                setAlarm: 
                    begin
                        //Convert HHMMSS to ms
                        clockAlarm = inputHours * 60 * 60 * 100 + inputMinutes * 60 * 100 + inputSeconds * 100;
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
                            if(startFlagStopWatch == 1)
                            begin
                                lappedMilliseconds[lapIndex] = lappedMillisecondsCount % 100;
                                lappedSeconds[lapIndex] = lappedMillisecondsCount / 100;
                                lappedMinutes[lapIndex] = lappedMillisecondsCount / (60 * 100);
                                lappedHours[lapIndex] = lappedMillisecondsCount / (60 * 60 * 100);
                                lapIndex = lapIndex +1;                            
                            end
                            else
                            begin
                                //Used to use loops, but they slowed the simulation too much
                                //Used to use loops, but they slowed the simulation too much
                                lappedSeconds[0] <= 0;
                                lappedSeconds[1] <= 0;
                                lappedSeconds[2] <= 0;
                                lappedSeconds[3] <= 0;
                                lappedSeconds[4] <= 0;
                                lappedSeconds[5] <= 0;
                                lappedSeconds[6] <= 0;
                                lappedSeconds[7] <= 0;
                                lappedSeconds[8] <= 0;
                                lappedSeconds[9] <= 0;
                                
                                lappedMinutes[0] <= 0;
                                lappedMinutes[1] <= 0;
                                lappedMinutes[2] <= 0;
                                lappedMinutes[3] <= 0;
                                lappedMinutes[4] <= 0;
                                lappedMinutes[5] <= 0;
                                lappedMinutes[6] <= 0;
                                lappedMinutes[7] <= 0;
                                lappedMinutes[8] <= 0;
                                lappedMinutes[9] <= 0;
                        
                                lappedMilliseconds[0] <= 0;
                                lappedMilliseconds[1] <= 0;
                                lappedMilliseconds[2] <= 0;
                                lappedMilliseconds[3] <= 0;
                                lappedMilliseconds[4] <= 0;
                                lappedMilliseconds[5] <= 0;
                                lappedMilliseconds[6] <= 0;
                                lappedMilliseconds[7] <= 0;
                                lappedMilliseconds[8] <= 0;
                                lappedMilliseconds[9] <= 0;
                        
                                lappedHours[0] <= 0;
                                lappedHours[1] <= 0;
                                lappedHours[2] <= 0;
                                lappedHours[3] <= 0;
                                lappedHours[4] <= 0;
                                lappedHours[5] <= 0;
                                lappedHours[6] <= 0;
                                lappedHours[7] <= 0;
                                lappedHours[8] <= 0;
                                lappedHours[9] <= 0;
                                
                                lappedMillisecondsCount <= 0;
                            end                        
                                                   
                        end
                    viewClockAndDate: 
                        begin
                            millisecondsTimeCount = 0;
                        end
                    setAlarm: 
                        begin
                        clockAlarm = 4'bXXXX;
                        end
                    
                
                endcase        
        end
    
    always @ (posedge clockSignal) //when clock is high
        begin
            
            //Check if countdown is enabled
            if(startFlagTimer == 1)
            begin
                //timerAlarmCount = milliseconds + userDefinedMilliseconds 
                timerAlarmCount =  (100 * inputSeconds + 100 * 60 * inputMinutes + 100 * 60 * 60  * inputHours);
                startFlagTimer = 0;
            end
            
            if(timerAlarmCount > 0 && !pause) //the moment user set time is reached, ring the alarm
            begin
                timerAlarmCount = timerAlarmCount - 1;
            end
            
            if(timerAlarmCount <= 0 )
            begin
                ringSound = 1;
            end            
            
            if(startFlagStopWatch == 1)
            begin
                if(lappedMillisecondsCount <= twentyFourHours)
                begin
                    lappedMillisecondsCount = lappedMillisecondsCount +1;
                end
                else
                begin
                    lappedMillisecondsCount = 0;
                    startFlagStopWatch = 0;
                end         
                
            end
            
            
            //PUT FUNCTION TO CONTINUOUSLY CONVERT MILLISECONDS TO DATE AND TIME DISPLAY HERE 
            //Originally was going to be the loopy thing that you did, but program seems to hang whenever I try to use it. So a solution without loops was needed, and this was the initial one
            //also putting modules inside always block doesnt seem to work 
            millisecondsDisplay = millisecondsTimeCount % 100; //the modulo is the ms count
            timeInSeconds= (millisecondsTimeCount/100) % 60; 
            timeInMinutesDisplay = (millisecondsTimeCount/(100 * 60))% 60;
            timeInHoursDisplay = (millisecondsTimeCount / (100 * 60 * 60)) % 24;
            
            
            
            //END
            if(millisecondsTimeCount  <= twentyFourHours)
            begin
                millisecondsTimeCount = millisecondsTimeCount + 1;
            end
            else
            begin
                millisecondsTimeCount = 0; //reset back to 0
            end
            
            if(clockAlarm>0)
            begin
                clockAlarm= clockAlarm -1 ;
            end
            else
            begin
                ringSound = 1;
            end
        end
    
    
    
    
     
endmodule

