# 讀取股價資料
# 台積電2017年之股價資料
price <- read.csv("2330_price_2017.csv", header = T)

price$date <- as.Date(price$date)
price$volume <- ceiling(price$volume/1000)

# 畫k線圖
color_vec <- ifelse(price$close > price$open, "red", "green")
date_label <- seq(as.Date("2017/1/1"), as.Date("2017/12/31"), by = "quarter")

par(mar = c(5,5,2,5))
plot(x = price$date, y = price$open, main = "", xlab = "Date", ylab = "price",
     type = "n", xaxt = "n", ylim = c(2*min(price$low) - max(price$high), max(price$high)))
segments(x0 = price$date, y0 = price$open, x1 = price$date, y1 = price$close, col = color_vec, lwd = 4)
segments(x0 = price$date, y0 = price$low, x1 = price$date, y1 = price$high, col = color_vec, lwd = 1)
axis(1, date_label, format(date_label, "%Y%m"), cex.axis = .7)


# 新增成交量的資訊
par(new = T)
plot(x = price$date, y = price$volume, type = "h", xaxt = "n", yaxt = "n", xlab = "", ylab = "", ylim = c(0, 2.5*max(price$volume)), lwd = 2)
options(scipen=999)
axis(side = 4, at = seq(0, max(price$volume), by = 50000), labels = as.character(seq(0, max(price$volume), by = 50000), scipen = 999), las = 1)
getOption("scipen")
mtext(side = 4, line = 3, 'volume')
