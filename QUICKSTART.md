# Quick Start Guide - Stop Hunt EA

## What Changed?

The EA now uses **Stop Hunt strategy** instead of Ichimoku indicators for trade signals.

## What is Stop Hunt Strategy?

**Stop Hunt** occurs when price:
1. Breaks beyond a key swing level (hunting stop losses)
2. Reverses back through that level
3. Creates a trading opportunity in the reversal direction

## Signal Requirements

A valid trade signal requires ALL of these:

✅ **Stop Hunt Level Detected** (SH1 or SH2)
- SH1 = Swing high was hunted → potential SELL
- SH2 = Swing low was hunted → potential BUY

✅ **Price in Retest Zone** (38.2% - 78.6% Fibonacci)
- Must be retracing back toward the SH level
- Not too close, not too far

✅ **Low Volume** (< 80% of 20-period average)
- Indicates weak momentum
- Often precedes reversals

✅ **Break of Structure on LTF** (Lower Time Frame)
- For BUY: Price closes above previous candle high
- For SELL: Price closes below previous candle low
- Confirms direction

✅ **Optional Filters** (if enabled)
- ADX > threshold
- RSI in oversold/overbought zones

## How to Use

### 1. Installation

```
1. Copy HHD68_STOPHUNT_v16.0-(MT5).mq5 to: 
   C:\Users\[YourName]\AppData\Roaming\MetaQuotes\Terminal\[BrokerID]\MQL5\Experts\

2. Open MetaEditor (F4 in MT5)

3. Find and open the EA file

4. Click "Compile" (F7)
   - Should compile without errors
   - Check for any warnings

5. Attach to chart:
   - Drag EA from Navigator onto chart
   - Or right-click chart → Expert Advisors → HHD68_STOPHUNT_v16.0
```

### 2. Basic Configuration

**Risk Settings (REQUIRED):**
- `riskPercent` = 1.0 (risk 1% per signal)
- `InpRiskAllocation_P1` = 40% (first position)
- `InpRiskAllocation_P2` = 30% (second position)
- `InpRiskAllocation_P3` = 30% (third position)

**Entry Mode:**
- `MODE_3_MARKET` = All 3 positions at market
- `MODE_2_MARKET_1_LIMIT` = 2 market, 1 limit order
- `MODE_1_MARKET_2_LIMIT` = 1 market, 2 limit orders

**Optional Filters:**
- `InpEnableADX` = true/false
- `InpADXMin` = 25.0
- `InpEnableRSI` = true/false
- `InpRSIOversold` = 30.0
- `InpRSIOverbought` = 70.0

**Dashboard:**
- `InpAutoTrade_FromDashboard` = true (auto-trade signals)
- `Symbols_Source` = Forex or Crypto
- `Dash_Use_M15/H1/H4/D1` = true/false

### 3. Chart Setup

**Recommended:**
- **HTF Chart**: H4 or D1 (for swing detection)
- **LTF Reference**: H1 or M15 (for BOS confirmation)
- EA analyzes both automatically

**Visual Indicators (Optional):**
You can add these to help visualize:
- Swing indicator (to see swings)
- Volume indicator
- Fibonacci tool (to check retest zones)

### 4. Enable Trading

```
1. Click "AutoTrading" button in MT5 toolbar (should turn green)
2. Check "Allow automated trading" in EA settings
3. Verify EA is active:
   - Smiley face in top-right corner
   - "Stop Hunt Zone" checklist visible
```

## Understanding the Dashboard

The checklist panel shows:

| Indicator | Meaning |
|-----------|---------|
| Stop Hunt Zone (BUY/SELL) | SH level detected, signal direction |
| Retest Zone (OK/--) | Price in Fibonacci zone |
| Volume Condition (OK/--) | Volume < 80% SMA(20) |
| BOS Confirmed (YES/--) | Break of structure on LTF |
| SH Level Valid (YES/--) | Overall SH setup valid |
| Swing Depth >= 1 (YES/--) | Valid swing found |

**Colors:**
- 🟢 Green = Condition met
- ⚪ Gray = Condition not met
- 🔴 Red = Filter failed (ADX/RSI)

## Troubleshooting

### "No signals detected"

**Possible causes:**
1. **No Stop Hunt patterns** in recent history
   - Solution: Wait for market to hunt stops, or try different symbol
   
2. **Timeframe too low** (e.g., M5)
   - Solution: Use H4 or D1 for better swing detection
   
3. **Strict filters**
   - Solution: Disable ADX/RSI filters temporarily
   
4. **Insufficient data**
   - Solution: Ensure chart has at least 200 bars loaded

### "Signal shows but no trade"

**Check:**
1. **AutoTrading enabled?** (toolbar button green)
2. **Daily loss limit reached?** (check journal)
3. **Already have position** in this symbol?
4. **Spread too high?** (check spread filter settings)
5. **News event nearby?** (news filter active)

### "Compilation errors"

**Common issues:**
1. **Wrong MT version** - Requires MT5, not MT4
2. **Syntax errors** - Re-download file (may be corrupted)
3. **Missing libraries** - Should auto-install, restart MT5

## Risk Warning

### ⚠️ IMPORTANT

1. **Test on Demo First**
   - Run for at least 2 weeks on demo
   - Verify behavior matches expectations
   
2. **Start Small**
   - Use 0.5% or 1% risk when going live
   - Monitor first 10 trades closely
   
3. **Market Conditions**
   - Stop Hunt works best in ranging/consolidating markets
   - May underperform in strong trends
   - Different symbols behave differently

4. **No Strategy is Perfect**
   - Losing trades are normal
   - Follow your risk management plan
   - Don't override EA decisions emotionally

## Performance Tips

### Optimize Settings

**For Conservative Trading:**
- Enable both ADX and RSI filters
- Use higher ADX threshold (30+)
- Risk 0.5% per signal
- MODE_1_MARKET_2_LIMIT for gradual entries

**For Aggressive Trading:**
- Disable optional filters
- Risk 1-2% per signal  
- MODE_3_MARKET for immediate full position
- Monitor multiple symbols

### Best Symbols

**Recommended:**
- Major forex pairs (EURUSD, GBPUSD, USDJPY)
- Pairs with good liquidity
- Avoid exotic pairs (wide spreads)

**Timeframes:**
- **H4**: Good balance, 2-5 trades per week
- **D1**: More selective, 1-2 trades per week
- **H1**: More signals, requires monitoring

## Getting Help

### Debug Mode

Enable detailed logging:
```
InpEnableDebugPrints = true
```

Check MT5 Journal/Experts tabs for:
- Signal detection events
- Filter check results
- Entry/exit decisions

### Information to Provide

When reporting issues:
1. MT5 build number
2. Broker name
3. Symbol and timeframe used
4. EA input settings (screenshot)
5. Error message or unexpected behavior
6. Journal/Experts log (relevant portion)

## Next Steps

1. ✅ **Read**: `IMPLEMENTATION.md` for technical details
2. ✅ **Test**: Follow `TESTING.md` for systematic testing
3. ✅ **Backtest**: Use Strategy Tester, analyze results
4. ✅ **Demo**: Run for 2+ weeks on demo account
5. ✅ **Live**: Start with small size, monitor closely

## Strategy Tips

### Entry Timing

**Best setups:**
- Clear swing high/low with obvious stop hunt
- Price returns to Fibo zone with low volume
- Clean BOS on LTF without whipsaws
- Confluence with support/resistance

**Avoid:**
- Choppy, low-volume markets
- News events (use calendar filter)
- Very wide spreads (early Asian session)
- When major trend is too strong

### Position Management

The EA handles:
- ✅ Multiple entries (P1, P2, P3)
- ✅ Individual SL/TP per position
- ✅ Trailing stop
- ✅ Break-even protection
- ✅ Partial close at TP levels

**You should monitor:**
- Overall exposure (max symbols in play)
- Correlation between symbols
- Account drawdown
- News calendar

## Summary

The Stop Hunt EA is now ready to use. Remember:

1. **Test thoroughly** before live trading
2. **Understand the strategy** - know why it enters
3. **Respect risk management** - don't override it
4. **Be patient** - good setups take time to develop
5. **Monitor performance** - track results, adjust as needed

Good luck and trade safely! 🎯

