# HHD68-SH EA (Expert Advisor)

Advanced MetaTrader 5 Expert Advisor with Ichimoku strategy and Stop Hunt detection system.

## Features

### Core Trading System
- **Multi-Timeframe Analysis**: HTF (Higher Timeframe) and LTF (Lower Timeframe) confirmation
- **Ichimoku Cloud Indicators**: Full Ichimoku system implementation
- **Stop Hunt Detection**: Advanced pattern recognition for stop hunt signals
- **Sequential Checklist**: 6-item validation system for trade entry

### Stop Hunt Detection (Latest Update)
The EA now includes a sophisticated Stop Hunt detection system with:
1. Stop Hunt pattern identification
2. Retest zone confirmation
3. Low volume swing detection
4. LTF Break of Structure confirmation
5. ADX trend strength validation
6. RSI momentum alignment

See [CHANGELOG_CHECKLIST_UPDATE.md](CHANGELOG_CHECKLIST_UPDATE.md) for detailed documentation.

### Risk Management
- Dynamic position sizing based on account risk
- Trailing stop loss (TSL) system
- Daily loss limit protection
- Break-even protection

### Trade Management
- Multiple entry modes (Market, Limit orders)
- Three-position scaling system (TP1, TP2, TP3)
- Automatic order management
- Position monitoring and adjustment

## Installation

1. Copy `HHD68_ICHIMOKU_v5.7-(MT5)adx,rsi.mq5` to your MetaTrader 5 `Experts` folder
2. Compile the EA in MetaEditor
3. Attach to your desired chart
4. Configure input parameters according to your strategy

## Configuration

### Key Input Parameters

#### Stop Hunt Detection
- `InpSH_LookbackBars` (default: 200) - Lookback period for Stop Hunt detection
- `InpSH_RetestBars` (default: 50) - Bars to search for retest zones
- `InpSH_VolumThreshold` (default: 0.7) - Volume threshold for low volume swings
- `InpSH_BOSLookforward` (default: 10) - Bars to search for BOS on LTF

#### Risk Management
- `riskPercent` (default: 0.45%) - Risk per trade
- `dailyLossPercent` (default: 1.3%) - Maximum daily loss limit
- `InpEnableDailyLossLimit` (default: true) - Enable/disable daily loss limit

#### Trend Filters
- `InpADXPeriod` (default: 14) - ADX period for LTF
- `InpADXMin` (default: 22.0) - Minimum ADX for trend strength
- `InpRSIPeriod` (default: 14) - RSI period for LTF
- `InpEnableADX` (default: true) - Enable ADX filter
- `InpEnableRSI` (default: true) - Enable RSI filter

## Usage

### Checklist System
The EA displays a checklist panel showing:
1. ✓ Stop Hunt Detected
2. ✓ Retest Zone
3. ✓ Swing with low Volume
4. ✓ LTF BOS Confirmed
5. ✓ LTF ADX
6. ✓ LTF RSI

All items must be checked for trade signal confirmation.

### Dashboard
- Multi-symbol monitoring
- Real-time signal scanning
- Automatic trade execution (when enabled)
- Visual status indicators

## Requirements

- MetaTrader 5 platform
- Minimum account balance: Recommended $1000+
- Symbol requirements: Works with Forex and Crypto
- Data requirements: Historical data for indicator calculations

## Version History

- **v15.1** - Stop Hunt detection system implementation
- **v15.0** - Critical fixes for trade locking
- **v14.9** - Trailing stop improvements
- **v14.8** - Safety distance for SL
- Earlier versions - Ichimoku base system

## Support & Documentation

- [CHANGELOG_CHECKLIST_UPDATE.md](CHANGELOG_CHECKLIST_UPDATE.md) - Detailed update documentation
- For issues and questions, use GitHub Issues

## Disclaimer

Trading involves substantial risk. This EA is provided as-is without warranties. Always test thoroughly on a demo account before live trading. Past performance does not guarantee future results.

## License

Copyright © hhd68. All rights reserved.
