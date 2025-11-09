# Testing Guide for Stop Hunt Strategy EA

## Overview
This document outlines the testing approach for the Stop Hunt strategy implementation in HHD68_STOPHUNT_v16.0-(MT5).mq5

## Unit Testing Approach

Since MQL5 doesn't have a built-in unit testing framework, manual testing should be performed in the MetaTrader 5 Strategy Tester.

### Test Cases

#### 1. Swing Detection Test
**Objective:** Verify that swing points are correctly identified with depth >= 1

**Setup:**
- Attach EA to chart with clear swing highs and lows
- Use visual mode in Strategy Tester
- Set lookback period to 200 bars

**Expected Results:**
- Swing highs should be identified where price forms peaks
- Swing lows should be identified where price forms valleys
- Minimum depth of 1 should be respected

**Validation:**
- Visual inspection of identified swings
- Compare with manual swing identification

#### 2. Stop Hunt Identification Test
**Objective:** Verify SH1/SH2 levels are correctly identified

**Setup:**
- Use historical data with clear stop hunt patterns
- Look for price movements that:
  - Break above swing high and reverse (SH1)
  - Break below swing low and reverse (SH2)

**Expected Results:**
- SH levels should be marked where price hunted stops
- Both SH1 (high) and SH2 (low) should be detected

**Validation:**
- Check EA logs for SH level identification
- Visual confirmation on chart

#### 3. Fibonacci Retest Zone Test
**Objective:** Verify retest zone calculation is correct

**Setup:**
- Identify a confirmed SH level
- Calculate expected Fibo levels manually:
  - 38.2% retracement
  - 78.6% retracement

**Expected Results:**
- Retest zone should be between 38.2% and 78.6%
- Zone should be correctly positioned relative to SH level

**Validation:**
- Compare EA calculated zone with manual calculation
- Margin of error should be < 0.1 pips

#### 4. Volume Condition Test
**Objective:** Verify volume < 80% of SMA(20) is correctly checked

**Setup:**
- Use data with varied volume patterns
- Calculate SMA(20) of volume manually for reference

**Expected Results:**
- Signal should only trigger when volume < 80% of SMA(20)
- High volume bars should be filtered out

**Validation:**
- Compare EA volume check with manual calculation
- Verify signal suppression on high volume

#### 5. BOS (Break of Structure) Test
**Objective:** Verify BOS confirmation on LTF

**Setup:**
- Set HTF to H4 or D1
- LTF should map to H1 or M15
- Look for clear break patterns

**Expected Results:**
- For BUY: Current close > previous candle high
- For SELL: Current close < previous candle low

**Validation:**
- Visual inspection on LTF chart
- Verify signal timing matches BOS

#### 6. Integration Test
**Objective:** Verify complete signal flow from detection to entry

**Test Scenarios:**

**Scenario A: Valid Buy Signal**
- SH2 identified (swing low hunt)
- Price in retest zone
- Volume < 80% SMA(20)
- BOS confirmed on LTF
- ADX > threshold (if enabled)
- RSI conditions met (if enabled)
- **Expected:** BUY order placed

**Scenario B: Valid Sell Signal**
- SH1 identified (swing high hunt)
- Price in retest zone
- Volume < 80% SMA(20)
- BOS confirmed on LTF
- ADX > threshold (if enabled)
- RSI conditions met (if enabled)
- **Expected:** SELL order placed

**Scenario C: Incomplete Conditions**
- SH level identified
- Price NOT in retest zone
- **Expected:** No order placed

**Scenario D: Failed Volume Check**
- All conditions met EXCEPT volume
- Volume > 80% SMA(20)
- **Expected:** No order placed

**Scenario E: Failed BOS**
- All conditions met EXCEPT BOS
- Price doesn't break structure on LTF
- **Expected:** No order placed

#### 7. Risk Management Test
**Objective:** Verify existing risk management still works

**Setup:**
- Configure risk percent (e.g., 1%)
- Set P1/P2/P3 allocations
- Enable daily loss limit

**Expected Results:**
- Position sizing calculated correctly
- Multiple positions opened according to entry mode
- Daily loss limit respected
- Trailing stop activates at configured levels

**Validation:**
- Check position sizes match calculated values
- Verify SL/TP levels
- Monitor trailing stop behavior
- Confirm daily loss limit blocks trades when exceeded

#### 8. Dashboard Test
**Objective:** Verify dashboard shows Stop Hunt signals

**Setup:**
- Enable dashboard
- Monitor multiple symbols and timeframes

**Expected Results:**
- Dashboard cells show BUY/SELL when conditions met
- Clicking cell switches to that symbol
- UI labels show Stop Hunt conditions:
  - "Stop Hunt Zone"
  - "Retest Zone"
  - "Volume Condition"
  - "BOS Confirmed"
  - "SH Level Valid"
  - "Swing Depth >= 1"

**Validation:**
- Visual inspection of dashboard
- Verify label text matches implementation

## Performance Testing

### Backtesting
- Period: At least 1 year of historical data
- Symbols: Major forex pairs (EURUSD, GBPUSD, USDJPY)
- Timeframes: H4, D1
- Quality: 99% tick data quality

**Metrics to Track:**
- Win rate
- Profit factor
- Maximum drawdown
- Average trade duration
- Signal frequency

### Forward Testing
- Duration: At least 1 month
- Real-time data
- Demo account first
- Monitor for slippage and execution issues

## Manual Verification Checklist

- [ ] EA compiles without errors in MetaEditor
- [ ] Visual mode shows Stop Hunt levels on chart
- [ ] Swing points are correctly identified
- [ ] Fibonacci zones calculated accurately
- [ ] Volume condition works correctly
- [ ] BOS detection works on LTF
- [ ] Orders placed only when all conditions met
- [ ] Risk management functions correctly
- [ ] Dashboard updates properly
- [ ] No memory leaks or crashes
- [ ] Trailing stop works as before
- [ ] News filter still operational
- [ ] Time filter still operational

## Known Limitations

1. **MQL5 Compilation Required**: Code must be compiled in MetaEditor before testing
2. **Tick Data Quality**: Backtest accuracy depends on historical data quality
3. **LTF Mapping**: Ensure LTF mapping logic is appropriate for your timeframes
4. **Volume Data**: Some brokers provide tick volume, not real volume

## Debugging Tips

1. **Enable Debug Prints**: Set `InpEnableDebugPrints = true` to see detailed logs
2. **Visual Mode**: Use Strategy Tester visual mode to watch EA in action
3. **Journal Tab**: Check MT5 journal for errors or warnings
4. **Expert Tab**: Review all EA log messages
5. **Chart Objects**: Stop Hunt levels should be drawn as horizontal lines

## Next Steps After Testing

1. Compile EA in MetaEditor
2. Run all test cases systematically
3. Document any issues or unexpected behavior
4. Fine-tune parameters based on backtest results
5. Conduct forward testing on demo
6. Monitor live (with small size) before full deployment

## Contact

If issues are found, document:
- MT5 build number
- Broker name
- Symbol and timeframe
- Exact steps to reproduce
- Screenshots if applicable
- Log files

