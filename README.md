# HHD68-SH (Stop Hunt Strategy)

## Overview
This Expert Advisor (EA) implements a Stop Hunt trading strategy for MT5, replacing the previous Ichimoku-based signal logic.

## Stop Hunt Strategy

The EA now uses the following signal detection methodology:

### Signal Detection Steps

1. **Swing Detection**: Identify swing points with depth >= 1
2. **Stop Hunt Identification**: Detect SH1/SH2 levels from swing points where price:
   - Breaks beyond the swing level
   - Reverses back through the level (stop hunt pattern)
3. **Key Level Drawing**: Draw horizontal lines at Stop Hunt levels
4. **Range Calculation**: Calculate the range from SH level to current price
5. **Retest Zone**: Define Fibonacci retest zone:
   - 38.2% - 78.6% retracement of the range
6. **Volume Confirmation**: Find swings with volume < 80% of SMA(20)
7. **LTF BOS (Break of Structure)**: Confirm on lower timeframe:
   - For BUY: Current close > previous candle high
   - For SELL: Current close < previous candle low

### Entry Conditions

All the following must be met:
- ✅ Stop Hunt level identified (SH1 or SH2)
- ✅ Price in Fibonacci retest zone (38.2% - 78.6%)
- ✅ Valid swing point after SH with low volume
- ✅ BOS confirmed on lower timeframe
- ✅ ADX > threshold (if enabled)
- ✅ RSI conditions met (if enabled)

### Risk Management

The EA maintains the same risk management system:
- Configurable risk allocation per position (P1, P2, P3)
- Daily loss limit protection
- Trailing stop loss with dynamic ratcheting
- Break-even protection
- Multiple position management

### Features Retained

- Multi-symbol dashboard
- Auto-trading from dashboard signals
- News filter
- Time filter
- Spread filter
- Multiple entry modes (Market/Limit combinations)
- Sophisticated SL/TP calculation

## Version History

### v16.0 (Current)
- **Major Change**: Replaced Ichimoku signal logic with Stop Hunt strategy
- Swing detection based on depth >= 1
- Stop Hunt level identification (SH1/SH2)
- Fibonacci retest zone calculation (38.2% - 78.6%)
- Volume analysis (< 80% SMA(20))
- BOS (Break of Structure) confirmation on LTF
- Updated UI labels to reflect Stop Hunt terminology
- Maintained all risk management features

### v15.1 (Previous)
- Ichimoku 2TF strategy with ADX and RSI filters
- Kijun trend confirmation
- Advanced trailing stop logic

## Installation

1. Copy `HHD68_STOPHUNT_v16.0-(MT5).mq5` to your MT5 `Experts` folder
2. Compile in MetaEditor
3. Attach to chart and configure inputs
4. Enable AutoTrading

## Configuration

Key inputs to configure:
- **Risk Management**: Risk percent, allocation per position
- **Filters**: ADX threshold, RSI levels
- **Entry Mode**: Market/Limit order combinations
- **Stop Loss**: ATR-based SL calculation
- **Dashboard**: Symbol lists, timeframes to monitor

## Author

hhd68

