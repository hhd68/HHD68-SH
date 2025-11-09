# HHD68-SH (Stop Hunt Strategy EA for MT5)

## 📥 Download

**Main File**: [`HHD68_STOPHUNT_v16.0-(MT5).mq5`](HHD68_STOPHUNT_v16.0-(MT5).mq5) ⬅️ **Click để tải xuống / Click to download**

---

## Hướng Dẫn Nhanh / Quick Guide

### 🇻🇳 Tiếng Việt

**Cài đặt đơn giản:**
1. Tải file `HHD68_STOPHUNT_v16.0-(MT5).mq5` ở trên
2. Copy vào thư mục `Experts` của MT5
3. Mở MetaEditor (F4) và compile (F7)
4. Kéo EA vào biểu đồ
5. Bật AutoTrading

**Đọc thêm**: [QUICKSTART.md](QUICKSTART.md) - Hướng dẫn chi tiết bằng tiếng Anh

### 🇬🇧 English

**Simple Installation:**
1. Download `HHD68_STOPHUNT_v16.0-(MT5).mq5` above
2. Copy to MT5 `Experts` folder
3. Open MetaEditor (F4) and compile (F7)
4. Drag EA to chart
5. Enable AutoTrading

**Read more**: [QUICKSTART.md](QUICKSTART.md) - Detailed setup guide

---

## Overview
This Expert Advisor (EA) implements a Stop Hunt trading strategy for MT5, replacing the previous Ichimoku-based signal logic.

## Chiến Lược / Strategy

**Stop Hunt** - Phát hiện và giao dịch khi giá "săn stoploss" và đảo chiều

### Tín Hiệu Vào Lệnh / Entry Signal

EA tự động tìm các điều kiện sau:
1. ✅ Phát hiện Stop Hunt (SH1/SH2)
2. ✅ Giá trong vùng Fibonacci (38.2-78.6%)
3. ✅ Volume thấp (< 80% trung bình)
4. ✅ Break of Structure trên khung nhỏ
5. ✅ ADX & RSI (nếu bật)

### Quản Lý Rủi Ro / Risk Management

- Chia lệnh thành 3 phần (P1, P2, P3)
- Giới hạn lỗ theo ngày
- Trailing stop tự động
- Break-even protection

### Tính Năng / Features

- Dashboard đa symbol và timeframe
- Auto-trading từ dashboard
- Bộ lọc: News, Time, Spread, ADX, RSI
- SL/TP dựa trên ATR

---

## 📚 Tài Liệu / Documentation

| File | Mô tả / Description |
|------|---------------------|
| [QUICKSTART.md](QUICKSTART.md) | Hướng dẫn cài đặt và sử dụng / Setup & usage guide |
| [IMPLEMENTATION.md](IMPLEMENTATION.md) | Chi tiết kỹ thuật / Technical details |
| [TESTING.md](TESTING.md) | Kiểm tra EA / Testing procedures |
| [CHANGELOG.md](CHANGELOG.md) | Lịch sử phiên bản / Version history |

---

## ⚠️ Cảnh Báo / Warning

- Test trên demo trước khi live / Test on demo before live
- Bắt đầu với rủi ro nhỏ / Start with small risk
- Không phải EA nào cũng lời / No EA is perfect

## 👤 Tác Giả / Author

hhd68

