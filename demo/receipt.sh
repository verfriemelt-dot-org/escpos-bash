#!/usr/bin/env bash

source ../escpos

PRINTER=/dev/usb/lp5

escpos init
escpos speed 1
escpos align center
escpos barcode ACME1042
escpos feed 1
escpos linespacing 0 # minimal linespacing is always the font height during printing
escpos --font 1 print <<'EOF'
                                _                  
                               | |                
  __ _  ___ _ __ ___   ___  ___| |__   ___  _ __  
 / _` |/ __| '_ ` _ \ / _ \/ __| '_ \ / _ \| '_ \ 
| (_| | (__| | | | | |  __/\__ \ | | | (_) | |_) |
 \__,_|\___|_| |_| |_|\___||___/_| |_|\___/| .__/ 
                                           | |    
                                           |_|    
EOF
escpos linespacing # resets to default
escpos print '42 Market Street'
escpos print '10115 Berlin | +49 30 555 1042'
escpos print 'VAT ID: DE123456789'
escpos font 0
escpos align left
escpos print '------------------------------------------'
escpos font 1
escpos print 'Receipt: 1042'
escpos print 'Date: 2026-11-11 10:42 | Cashier: Alex'
escpos print '------------------------------------------------------'
printf '%-4s %-30s %8s %11s\n' 'QTY' 'ITEM' 'UNIT' 'TOTAL' \
    '2' 'Coffee' '2.90' '5.80' \
    '1' 'Sourdough bread' '3.49' '3.49' \
    '1' 'Whole milk' '1.19' '1.19' \
    '1' 'Apples (1 kg)' '2.49' '2.49' \
    '1' 'Black tea' '3.95' '3.95' | escpos print
escpos font 0
escpos print '------------------------------------------'
printf '%-29s %12s\n' 'Net amount' '15.26 EUR' \
    'VAT 7% included' '0.73 EUR' \
    'VAT 19% included' '0.93 EUR' | escpos print
escpos underline 1
escpos emphasize 1
printf '%-29s %12s\n' 'TOTAL (incl. VAT)' '16.92 EUR' | escpos print
escpos emphasize 0
escpos underline 0
printf '%-29s %12s\n' 'Cash received' '20.00 EUR' \
    'Change' '3.08 EUR' | escpos print
escpos print 'Prices include VAT.'

escpos feed 1
escpos align center
escpos emphasize 0
escpos qrcode 'https://example.com/receipts/1042'
escpos emphasize 1
escpos print 'Thank you for shopping at ACME!'
escpos cut
