//+------------------------------------------------------------------+
//|                                          HHD68_VSA V2.1.mq5      |
//|                                  Copyright 2025, HHD68            |
//|                                             https://www.hhd68.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, HHD68"
#property link      "https://www.hhd68.com"
#property version   "2.10"
#property strict

//--- Include necessary libraries
#include <Trade/Trade.mqh>
#include <Trade/PositionInfo.mqh>
#include <Trade/OrderInfo.mqh>

//--- Global variables
CTrade         trade;
CPositionInfo  posInfo;
COrderInfo     ordInfo;

//--- Input parameters
input int InpVolumePeriod = 20;  // Volume average period
input int InpSwingDepth = 10;    // Swing detection depth

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("HHD68_VSA V2.1 initialized");
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    Print("HHD68_VSA V2.1 deinitialized");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    // Main trading logic
    string symbol = _Symbol;
    ENUM_TIMEFRAMES tf = PERIOD_CURRENT;
    
    // Check for low volume conditions
    if(HasLowVolume(symbol, tf, 1))
    {
        Print("Low volume detected");
    }
    
    // Test swing functions
    if(IsSwingLowGE2(5, InpSwingDepth, symbol, tf))
    {
        Print("Swing low detected");
    }
    
    if(IsSwingHighGE2(5, InpSwingDepth, symbol, tf))
    {
        Print("Swing high detected");
    }
}

//+------------------------------------------------------------------+
//| Calculate average volume                                          |
//+------------------------------------------------------------------+
long CalculateAverageVolume(string symbol, ENUM_TIMEFRAMES tf, int period, int startBar)
{
    long totalVolume = 0;
    int count = 0;
    
    for(int i = startBar; i < startBar + period; i++)
    {
        long vol = iVolume(symbol, tf, i);
        if(vol > 0)
        {
            totalVolume += vol;
            count++;
        }
    }
    
    // Line 480: Type conversion issue - potential data loss
    return (count > 0) ? totalVolume / count : 0;
}

//+------------------------------------------------------------------+
//| Check if current bar has low volume                              |
//+------------------------------------------------------------------+
bool HasLowVolume(string symbol, ENUM_TIMEFRAMES tf, int bar)
{
    long currentVolume = iVolume(symbol, tf, bar);
    long avgVolume = CalculateAverageVolume(symbol, tf, InpVolumePeriod, bar + 1);
    
    // Check if volume is significantly lower than average
    if(currentVolume < avgVolume * 0.5)
    {
        // Line 466: Nested function declaration - NOT ALLOWED in MQL5
        bool CheckSWRetestVolume(int testBar)
        {
            long retestVol = iVolume(symbol, tf, testBar);
            return (retestVol < avgVolume * 0.7);
        }
        
        // Use the nested function
        return CheckSWRetestVolume(bar);
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Check for swing retest with volume confirmation                  |
//+------------------------------------------------------------------+
// This function should be at global scope, not nested
// bool CheckSWRetestVolume(int testBar) { ... }

//+------------------------------------------------------------------+
//| Main signal detection function                                   |
//+------------------------------------------------------------------+
void DetectTradingSignals(string symbol, ENUM_TIMEFRAMES tf)
{
    // Find swing points
    for(int i = 10; i < 100; i++)
    {
        if(IsSwingLowGE2(i, InpSwingDepth, symbol, tf))
        {
            double swingPrice = iLow(symbol, tf, i);
            
            // Check if swing was broken - Line 899: Undeclared identifier
            if(IsSwingBroken_Low(swingPrice, symbol, tf, i, 0))
            {
                Print("Swing low broken at bar ", i);
            }
            
            // Check for no lower low between points
            if(NoLowerLowBetween(i, 0, symbol, tf))
            {
                Print("No lower low between swing and current");
            }
        }
        
        if(IsSwingHighGE2(i, InpSwingDepth, symbol, tf))
        {
            double swingPrice = iHigh(symbol, tf, i);
            
            // Check if swing was broken - Undeclared identifier
            if(IsSwingBroken_High(swingPrice, symbol, tf, i, 0))
            {
                Print("Swing high broken at bar ", i);
            }
            
            // Check for no higher high between points
            if(NoHigherHighBetween(i, 0, symbol, tf))
            {
                Print("No higher high between swing and current");
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Check if swing low meets criteria (>=2 bars on each side)       |
//+------------------------------------------------------------------+
bool IsSwingLowGE2(int bar, int maxDepth, string symbol, ENUM_TIMEFRAMES tf)
{
    if(bar < maxDepth || bar >= iBars(symbol, tf) - maxDepth)
        return false;
    
    double centerLow = iLow(symbol, tf, bar);
    
    // Check left side
    int leftCount = 0;
    for(int i = 1; i <= maxDepth; i++)
    {
        if(iLow(symbol, tf, bar + i) > centerLow)
            leftCount++;
        else
            break;
    }
    
    // Check right side
    int rightCount = 0;
    for(int i = 1; i <= maxDepth; i++)
    {
        if(iLow(symbol, tf, bar - i) > centerLow)
            rightCount++;
        else
            break;
    }
    
    return (leftCount >= 2 && rightCount >= 2);
}

//+------------------------------------------------------------------+
//| Check if swing high meets criteria (>=2 bars on each side)      |
//+------------------------------------------------------------------+
bool IsSwingHighGE2(int bar, int maxDepth, string symbol, ENUM_TIMEFRAMES tf)
{
    if(bar < maxDepth || bar >= iBars(symbol, tf) - maxDepth)
        return false;
    
    double centerHigh = iHigh(symbol, tf, bar);
    
    // Check left side
    int leftCount = 0;
    for(int i = 1; i <= maxDepth; i++)
    {
        if(iHigh(symbol, tf, bar + i) < centerHigh)
            leftCount++;
        else
            break;
    }
    
    // Check right side
    int rightCount = 0;
    for(int i = 1; i <= maxDepth; i++)
    {
        if(iHigh(symbol, tf, bar - i) < centerHigh)
            rightCount++;
        else
            break;
    }
    
    return (leftCount >= 2 && rightCount >= 2);
}

//+------------------------------------------------------------------+
//| Check if a swing low price has been broken                       |
//+------------------------------------------------------------------+
bool IsSwingBroken_Low(double swing_price, string symbol, ENUM_TIMEFRAMES tf, int swing_index, int current_index)
{
    for(int i = swing_index - 1; i >= current_index; i--)
    {
        if(iLow(symbol, tf, i) < swing_price)
            return true;
    }
    return false;
}

//+------------------------------------------------------------------+
//| Check if a swing high price has been broken                      |
//+------------------------------------------------------------------+
bool IsSwingBroken_High(double swing_price, string symbol, ENUM_TIMEFRAMES tf, int swing_index, int current_index)
{
    for(int i = swing_index - 1; i >= current_index; i--)
    {
        if(iHigh(symbol, tf, i) > swing_price)
            return true;
    }
    return false;
}

//+------------------------------------------------------------------+
//| Check if there's no lower low between two bar indices           |
//+------------------------------------------------------------------+
bool NoLowerLowBetween(int sw, int j, string symbol, ENUM_TIMEFRAMES tf)
{
    double swingLow = iLow(symbol, tf, sw);
    
    for(int i = sw - 1; i > j; i--)
    {
        if(iLow(symbol, tf, i) < swingLow)
            return false;
    }
    return true;
}

//+------------------------------------------------------------------+
//| Check if there's no higher high between two bar indices         |
//+------------------------------------------------------------------+
bool NoHigherHighBetween(int sw, int jj, string symbol, ENUM_TIMEFRAMES tf)
{
    double swingHigh = iHigh(symbol, tf, sw);
    
    for(int i = sw - 1; i > jj; i--)
    {
        if(iHigh(symbol, tf, i) > swingHigh)
            return false;
    }
    return true;
}
//+------------------------------------------------------------------+
