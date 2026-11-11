# escpos-bash

A small Bash-only ESC/POS utility that writes directly to a printer device. It uses no external runtime dependencies.

Set `PRINTER` to your device path (defaults to `/dev/usb/lp1`):

```bash
PRINTER=/dev/usb/lp1 ./escpos print "Hello, printer"
printf 'Hello from stdin\n' | PRINTER=/dev/usb/lp1 ./escpos print
```

Commands include `init`, `feed LINES`, `font 0|1|2`, `linespacing [UNITS]` (0-255 motion units; no value restores the printer default), `speed 0-14` (0 restores the printer default; 1 is slowest and 14 fastest on the TM-T88V), `emphasize 0|1`, `italic 0|1` (model support varies), `underline 0|1|2`, `align left|center|right`, `barcode DATA` (Code 39), `qrcode DATA` (Model 2, size 6, error correction L), `cut [LINES]` (feed the requested number of lines, 6 by default, then full cut), and `status` (prints the printer status page on compatible Epson models). `command` translates control tokens such as `ESC @` and `ESC E 1`; `raw` sends supplied bytes unchanged:

Print speed is model-dependent and can be limited by the printer's print-control mode and operating conditions. If a level near the configured maximum appears to have no effect, try a lower level such as `speed 1`; use `speed 0` to restore the printer's configured default.

```bash
PRINTER=/dev/usb/lp1 ./escpos command ESC E 1
PRINTER=/dev/usb/lp1 ./escpos raw $'\x1b@'
```

Global options can be placed before or after the command: `--init`/`-i`, `--feed-before LINES`/`-b`, `--align ALIGN`, `--emphasize 0|1`, `--italic 0|1`, `--underline 0|1|2`, `--font FONT`/`-f`, `--feed-after LINES`/`-a`, and `--cut`/`-c`. Alignment, emphasis, italic, underline, and font options are applied before the command, regardless of where they appear. For example:

```bash
printf 'Receipt\n' | PRINTER=/dev/usb/lp1 ./escpos --feed-before 2 print --feed-after 4 --cut
```

## ACME Shop receipt example

The shop, transaction, and tax figures are illustrative. On the TM-T88V with 80 mm paper, Font 0 fits 42 characters per line and Font 1 fits 56. This example uses Font 1 for the item table and Font 0 for the rest. It prints a centered Code 39 barcode and QR code:

```bash
export PRINTER=/dev/usb/lp5
./escpos init
./escpos speed 1
./escpos align center
./escpos barcode ACME1042
./escpos feed 1
./escpos linespacing 0
./escpos --font 1 print <<'EOF'
                                _                  
                               | |                
  __ _  ___ _ __ ___   ___  ___| |__   ___  _ __  
 / _` |/ __| '_ ` _ \ / _ \/ __| '_ \ / _ \| '_ \ 
| (_| | (__| | | | | |  __/\__ \ | | | (_) | |_) |
 \__,_|\___|_| |_| |_|\___||___/_| |_|\___/| .__/ 
                                           | |    
                                           |_|    
EOF
./escpos linespacing 40
./escpos print '42 Market Street'
./escpos print '10115 Berlin | +49 30 555 1042'
./escpos print 'VAT ID: DE123456789'
./escpos font 0
./escpos align left
./escpos print '------------------------------------------'
./escpos font 1
./escpos print 'Receipt: 1042'
./escpos print 'Date: 2026-11-11 10:42 | Cashier: Alex'
./escpos print '------------------------------------------------------'
printf '%-4s %-30s %8s %11s\n' 'QTY' 'ITEM' 'UNIT' 'TOTAL' \
    '2' 'Coffee' '2.90' '5.80' \
    '1' 'Sourdough bread' '3.49' '3.49' \
    '1' 'Whole milk' '1.19' '1.19' \
    '1' 'Apples (1 kg)' '2.49' '2.49' \
    '1' 'Black tea' '3.95' '3.95' | ./escpos print
./escpos font 0
./escpos print '------------------------------------------'
printf '%-29s %12s\n' 'Net amount' '15.26 EUR' \
    'VAT 7% included' '0.73 EUR' \
    'VAT 19% included' '0.93 EUR' | ./escpos print
./escpos underline 1
./escpos emphasize 1
printf '%-29s %12s\n' 'TOTAL (incl. VAT)' '16.92 EUR' | ./escpos print
./escpos emphasize 0
./escpos underline 0
printf '%-29s %12s\n' 'Cash received' '20.00 EUR' \
    'Change' '3.08 EUR' | ./escpos print
./escpos print 'Prices include VAT.'

./escpos feed 1
./escpos align center
./escpos emphasize 0
./escpos qrcode 'https://example.com/receipts/1042'
./escpos emphasize 1
./escpos print 'Thank you for shopping at ACME!'
./escpos cut 8
```

Run `./escpos --help` for the full command list. Bash cannot represent NUL bytes in arguments or variables; use `command NUL` when sending that control byte.

Run the byte-output tests with:

```bash
bash tests/run.sh
```
