# Stop Hunt Strategy Implementation

## Overview

This document details the implementation of the Stop Hunt signal detection logic that replaces the previous Ichimoku-based strategy in the HHD68 Expert Advisor.

## Implementation Summary

### Core Algorithm

The Stop Hunt strategy implementation consists of 7 main steps, as specified in the requirements:

#### 1. Swing Detection (Depth >= 1)
**Function:** `FindSwingPoints()`
- Scans price history to identify swing highs and swing lows
- Uses configurable depth parameter (minimum 1)
- A swing high requires price to be higher than surrounding bars on both sides
- A swing low requires price to be lower than surrounding bars on both sides
- Returns array of swing points with their prices, times, and depth

**Implementation:**
```mql5
bool FindSwingPoints(const string sym, const ENUM_TIMEFRAMES tf, int lookback, int min_depth,
                     SwingPoint &swings[], int &swing_count)
```

#### 2. Stop Hunt Identification (SH1/SH2)
**Function:** `IdentifyStopHuntLevels()`
- Analyzes swing points to detect stop hunt patterns
- **SH1 (Swing High Hunt):** Price breaks above swing high, then reverses back below
- **SH2 (Swing Low Hunt):** Price breaks below swing low, then reverses back above
- These levels indicate where stop losses were likely hunted
- Returns array of identified SH levels

**Pattern Detection:**
- For each swing point, checks if price broke beyond it within the next 10 bars
- Then verifies if price reversed back through the level (stop hunt confirmation)
- Marks as SH1 or SH2 depending on whether it was a high or low swing

**Implementation:**
```mql5
bool IdentifyStopHuntLevels(const string sym, const ENUM_TIMEFRAMES tf,
                             SwingPoint &swings[], int swing_count,
                             StopHuntLevel &sh_levels[], int &sh_count)
```

#### 3. Key Level Drawing
**Integration:** Within `IdentifyStopHuntLevels()`
- Horizontal lines are conceptually drawn through Stop Hunt levels
- These serve as key price levels for trade entry
- In the implementation, the levels are stored for calculation purposes
- Visual drawing can be added in the UI update functions if needed

#### 4. Range Calculation
**Function:** `CalculateRetestZone()`
- Calculates the distance from Stop Hunt level to current price
- This range is used for Fibonacci retracement calculations
- Direction-aware: different calculation for buy vs sell signals

#### 5. Fibonacci Retest Zone (38.2% - 78.6%)
**Function:** `CalculateRetestZone()`
- Defines the optimal entry zone using Fibonacci levels
- **For BUY signals:** Zone is below current price
  - Upper bound: SH price - (range × 0.382)
  - Lower bound: SH price - (range × 0.786)
- **For SELL signals:** Zone is above current price
  - Lower bound: SH price + (range × 0.382)
  - Upper bound: SH price + (range × 0.786)
- Entry is only considered when price is within this zone

**Implementation:**
```mql5
bool CalculateRetestZone(double sh_price, double current_price, bool is_buy,
                         double &zone_low, double &zone_high)
```

#### 6. Volume Confirmation (< 80% of SMA(20))
**Function:** `CheckVolumeCondition()`
- Calculates 20-period Simple Moving Average of volume
- Checks if current bar volume is less than 80% of the SMA
- Low volume indicates lack of strong momentum, often seen before reversals
- This filters out high-momentum breakouts that may continue

**Implementation:**
```mql5
bool CheckVolumeCondition(const string sym, const ENUM_TIMEFRAMES tf, int bar_index)
```

**Calculation:**
1. Get last 21 bars of volume data (20 for SMA + 1 current)
2. Calculate SMA: sum of 20 bars / 20
3. Compare current volume to 80% of SMA
4. Return true if current < (SMA × 0.80)

#### 7. LTF BOS (Break of Structure)
**Function:** `CheckBOS_LTF()`
- Confirms trade setup on Lower Time Frame (LTF)
- Detects when price breaks the structure of the previous candle
- **For BUY:** Current close must be above previous candle's high
- **For SELL:** Current close must be below previous candle's low
- This provides final confirmation that the trade direction is valid

**Implementation:**
```mql5
bool CheckBOS_LTF(const string sym, const ENUM_TIMEFRAMES ltf, bool is_buy)
```

### Main Detection Function

**Function:** `DetectStopHuntSignal()`

This is the primary function that orchestrates all 7 steps:

```mql5
int DetectStopHuntSignal(const string sym, const ENUM_TIMEFRAMES htf, const ENUM_TIMEFRAMES ltf)
{
   // Step 1: Find swings with depth >= 1
   // Step 2: Identify Stop Hunt levels (SH1/SH2)
   // Step 3 & 4: Calculate range from SH to current price
   // Step 5: Calculate Fibonacci retest zone
   // Step 6: Check volume condition
   // Step 7: Confirm BOS on LTF
   
   // Returns: 0 for BUY, 1 for SELL, -1 for no signal
}
```

**Signal Flow:**
1. Detects all swing points in the lookback period
2. Identifies which swings show stop hunt patterns
3. For each SH level:
   - Calculates Fibonacci retest zone
   - Checks if current price is in the zone
   - Verifies volume condition
   - Confirms BOS on lower timeframe
4. Returns first valid signal found, or -1 if none

## Integration Points

### Replaced Functions

#### 1. TF2_HTF_OK_At_Cached()
**Before:** Checked Ichimoku conditions (cloud, TK cross, Chikou span, etc.)
**After:** Calls `DetectStopHuntSignal()` and returns +1 for BUY, -1 for SELL, 0 for no signal

```mql5
int TF2_HTF_OK_At_Cached(const string sym, ENUM_TIMEFRAMES tf){
   ENUM_TIMEFRAMES ltf = TF2_MapLTF(tf);
   int signal = DetectStopHuntSignal(sym, tf, ltf);
   
   if(signal == 0) return +1;  // Buy signal
   if(signal == 1) return -1;  // Sell signal
   return 0;  // No signal
}
```

#### 2. TF2_HTF_OK_FromGlobals()
**Before:** Checked global Ichimoku state variables
**After:** Checks global Stop Hunt state variables

```mql5
int TF2_HTF_OK_FromGlobals(){
   if(!g_sh_in_retest_zone || !g_sh_volume_ok || !g_sh_bos_confirmed)
      return 0;
   
   return g_sh_signal_dir;
}
```

#### 3. Ichi_ComputeSignals_Current()
**Before:** Computed Ichimoku indicators for current chart
**After:** Computes Stop Hunt signals and updates global state

```mql5
void Ichi_ComputeSignals_Current(){
   string sym = _Symbol;
   ENUM_TIMEFRAMES tf = (ENUM_TIMEFRAMES)_Period;
   ENUM_TIMEFRAMES ltf = TF2_MapLTF(tf);
   
   // Reset global state
   g_sh_signal_dir = 0;
   g_sh_in_retest_zone = false;
   g_sh_volume_ok = false;
   g_sh_bos_confirmed = false;
   
   // Detect Stop Hunt signal
   int signal = DetectStopHuntSignal(sym, tf, ltf);
   
   // Update globals if signal found
   // ... (continues with ADX and RSI checks)
}
```

### New Global Variables

```mql5
// Stop Hunt global state variables
int g_sh_signal_dir = 0;           // +1 for buy, -1 for sell, 0 for no signal
bool g_sh_in_retest_zone = false;  // True if price is in Fibonacci retest zone
bool g_sh_volume_ok = false;        // True if volume condition met
bool g_sh_bos_confirmed = false;    // True if BOS confirmed on LTF
```

### UI Updates

The checklist panel labels have been updated to reflect Stop Hunt terminology:

| Old Label (Ichimoku) | New Label (Stop Hunt) |
|----------------------|----------------------|
| Cloud | Stop Hunt Zone |
| Tenkan - Kijun | Retest Zone |
| Chikou span | Volume Condition |
| Future cloud | BOS Confirmed |
| Distance <= X ATR14 | SH Level Valid |
| Kijun Trend | Swing Depth >= 1 |

### Preserved Features

The following components remain **unchanged** to maintain EA stability:

1. **Risk Management System**
   - Position sizing calculations
   - Daily loss limit
   - Risk allocation per position (P1, P2, P3)

2. **Order Entry Logic**
   - Entry mode selection (Market/Limit combinations)
   - Multiple position management
   - Magic number handling

3. **SL/TP Calculation**
   - ATR-based stop loss
   - Multiple take profit levels
   - Break-even protection

4. **Trailing Stop Logic**
   - Dynamic trailing based on price movement
   - Lock-in mechanism
   - Ratcheting protection

5. **Filters**
   - ADX filter (optional)
   - RSI filter (optional)
   - Spread filter
   - News filter
   - Time filter

6. **Dashboard**
   - Multi-symbol monitoring
   - Multi-timeframe scanning
   - Auto-trading from signals
   - Visual state indication

## Data Structures

### SwingPoint
```mql5
struct SwingPoint
{
   double price;        // Price level of the swing
   datetime time;       // Time of the swing formation
   int bar_index;       // Bar index in the series
   int depth;          // Depth of the swing (shoulders)
   bool is_high;       // true for swing high, false for swing low
};
```

### StopHuntLevel
```mql5
struct StopHuntLevel
{
   double price;        // Price level where stop hunt occurred
   datetime time;       // Time of stop hunt
   int bar_index;       // Bar index where SH was detected
   int swing_depth;     // Depth of the original swing
   bool is_sh1;        // true if this is SH1 (swing high hunt)
   bool is_sh2;        // true if this is SH2 (swing low hunt)
};
```

## Configuration Parameters

The Stop Hunt strategy uses these key parameters:

| Parameter | Default | Description |
|-----------|---------|-------------|
| Lookback bars | 200 | Number of bars to scan for swings |
| Minimum swing depth | 1 | Minimum shoulders for valid swing |
| Fibonacci low | 0.382 | Lower bound of retest zone (38.2%) |
| Fibonacci high | 0.786 | Upper bound of retest zone (78.6%) |
| Volume threshold | 0.80 | Percentage of SMA(20) for volume check |
| Volume SMA period | 20 | Period for volume SMA calculation |

## Performance Considerations

### Optimization Techniques

1. **Efficient Swing Detection**
   - Single pass through price data
   - Early exit when swing found
   - Array reuse to minimize allocations

2. **Cached Calculations**
   - Volume SMA calculated once per bar
   - Swing points cached between calls
   - Fibonacci levels pre-calculated

3. **Limited Lookback**
   - Default 200 bars prevents excessive processing
   - Configurable for different strategies
   - Stops at oldest available data if less than 200 bars

4. **Early Exit Logic**
   - Returns immediately when no swings found
   - Skips further processing when conditions not met
   - Checks lightest conditions first

### Memory Management

- Fixed-size arrays prevent dynamic allocations
- SwingPoint array: 100 elements
- StopHuntLevel array: 50 elements
- Automatic cleanup on scope exit

## Error Handling

The implementation includes robust error handling:

1. **Data Availability Checks**
   - Verifies sufficient bars before processing
   - Returns -1 if data unavailable
   - Logs errors for debugging

2. **Boundary Checks**
   - Array size limits enforced
   - Bar index validation
   - Price validity checks

3. **Fallback Behavior**
   - Graceful degradation when conditions not met
   - No signal generated if any step fails
   - Preserves EA stability

## Testing Recommendations

See `TESTING.md` for detailed testing procedures.

**Key areas to verify:**
1. Swing detection accuracy
2. Stop hunt pattern recognition
3. Fibonacci zone calculations
4. Volume condition filtering
5. BOS confirmation timing
6. Integration with existing features
7. Performance under various market conditions

## Future Enhancements

Potential improvements for future versions:

1. **Visual Indicators**
   - Draw SH levels on chart
   - Show Fibonacci retest zones
   - Highlight BOS candles

2. **Additional Filters**
   - Minimum distance between SH levels
   - Maximum time since SH
   - Confluence with round numbers

3. **Adaptive Parameters**
   - Dynamic Fibonacci levels
   - Volatility-adjusted volume threshold
   - Timeframe-specific swing depth

4. **Statistics**
   - Success rate per SH type
   - Average time to entry after SH
   - Win rate by retest zone level

## Conclusion

This implementation successfully replaces the Ichimoku signal logic with a comprehensive Stop Hunt strategy while preserving all existing risk management and order handling capabilities. The modular design allows for easy testing, maintenance, and future enhancements.

## References

- Original requirement: Replace Ichimoku with Stop Hunt logic
- 7-step methodology as specified in problem statement
- Fibonacci retracement levels: 38.2%, 78.6%
- Volume analysis: 80% of 20-period SMA
- BOS: Break of previous candle high/low on LTF

