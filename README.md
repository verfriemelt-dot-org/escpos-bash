# escpos-bash

A small Bash-only ESC/POS utility that writes directly to a printer device. It uses no external runtime dependencies.

Set `PRINTER` to your device path (defaults to `/dev/usb/lp1`):

```bash
PRINTER=/dev/usb/lp1 ./escpos print "Hello, printer"
printf 'Hello from stdin\n' | PRINTER=/dev/usb/lp1 ./escpos print
```

Commands include `init`, `feed LINES`, `font 0|1|2`, `cut`, and `status` (prints the printer status page on compatible Epson models). `command` translates control tokens such as `ESC @` and `ESC E 1`; `raw` sends supplied bytes unchanged:

```bash
PRINTER=/dev/usb/lp1 ./escpos command ESC E 1
PRINTER=/dev/usb/lp1 ./escpos raw $'\x1b@'
```

Global options can be placed before or after the command: `--init`/`-i`, `--feed-before LINES`/`-b`, `--font FONT`/`-f`, `--feed-after LINES`/`-a`, and `--cut`/`-c`. For example:

```bash
printf 'Receipt\n' | PRINTER=/dev/usb/lp1 ./escpos --feed-before 2 print --feed-after 4 --cut
```

Run `./escpos --help` for the full command list. Bash cannot represent NUL bytes in arguments or variables; use `command NUL` when sending that control byte.

Run the byte-output tests with:

```bash
bash tests/run.sh
```
