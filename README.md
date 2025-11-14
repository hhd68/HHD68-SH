# HHD68-SH

HHD68 Ichimoku Trading Expert Advisor for MetaTrader 5

## Overview

This repository contains an advanced automated trading Expert Advisor (EA) for MetaTrader 5 (MT5) that implements an Ichimoku-based trading strategy with multiple enhancements and filters.

## Features

### Core Strategy
- **Ichimoku Cloud Analysis**: Multi-timeframe Ichimoku analysis with customizable parameters
- **ADX Trend Filter**: Trend strength filtering using Average Directional Index
- **RSI Momentum Filter**: Momentum confirmation using Relative Strength Index
- **Kijun Trend Analysis**: Additional trend confirmation

### Risk Management
- **Multi-Position Management**: Supports up to 3 positions per symbol with different risk allocations
- **Dynamic Stop Loss**: Multiple SL calculation methods (ATR, Swing, Kumo)
- **Trailing Stop Loss**: Dynamic TSL with different offset levels for each position
- **Break-even Protection**: Automatic move to break-even after specified profit level
- **Daily Loss Limit**: Configurable daily loss protection

### Entry Modes
- 3 Market Orders
- 2 Market + 1 Limit Order
- 1 Market + 2 Limit Orders

### Trading Filters
- **Spread Filter**: Dynamic spread monitoring and filtering
- **Time Filter**: Configurable no-trade time periods
- **News Filter**: Automated news event filtering with customizable impact levels
- **Position Limits**: Maximum positions per symbol and total active symbols

### Advanced Features
- **Dashboard Display**: Real-time trading signals across multiple symbols and timeframes
- **Global Variable Management**: Persistent trade tracking across EA restarts
- **Automatic Position Management**: Smart handling of positions before news events and restricted hours
- **Expired Limit Order Cleanup**: Automatic cancellation of unfilled limit orders

## Configuration

The EA is highly configurable with numerous input parameters grouped into logical sections:

- Risk Allocation (Position 1, 2, 3 split)
- Trend Filters (ADX, RSI settings)
- SL/TP & Trade Management
- Dynamic Trailing Stop settings
- Auto Trading options
- Trading Filters (Spread, Time)
- News Filter (Automated event detection)

## File Information

- **Version**: 15.1
- **Language**: MQL5 (MetaTrader 5)
- **File**: `HHD68_ICHIMOKU_v5.7-(MT5)adx,rsi.mq5`
- **Magic Numbers**: 
  - 680019 (Position 1)
  - 680020 (Position 2)
  - 680021 (Position 3 - 10R position)

## Installation

1. Copy the `.mq5` file to your MetaTrader 5 data folder: `MQL5/Experts/`
2. Compile the file in MetaEditor or restart MT5 to auto-compile
3. Attach the EA to desired charts
4. Configure input parameters according to your risk tolerance and trading style

## Important Notes

- This EA is designed for Forex and Cryptocurrency markets
- Requires proper understanding of Ichimoku strategy and risk management
- Test thoroughly in demo environment before live trading
- Adjust risk parameters according to your account size and risk tolerance

## Disclaimer

Trading financial instruments involves risk. Past performance does not guarantee future results. Use this EA at your own risk.

## Author

hhd68 (Upgraded & Automated by Copilot)
