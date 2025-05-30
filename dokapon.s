;I/O registers

TEST        = $f0
DSP_CTRL    = $f1
DSP_ADDR    = $f2
DSP_DATA    = $f3
PORT0       = $f4
PORT1       = $f5
PORT2       = $f6
PORT3       = $f7
TMP0        = $f8  ; Unused
TMP1        = $f9  ; Unused
TIMER0      = $fa
TIMER1      = $fb
TIMER2      = $fc  ; Unused
HW_COUNTER0 = $fd
HW_COUNTER1 = $fe
HW_COUNTER2 = $ff


; Global DSP Registers

DSP_MVOLL   = $0c
DSP_MVOLR   = $1c
DSP_EVOLL   = $2c
DSP_EVOLR   = $3c
DSP_KON	    = $4c
DSP_KOF	    = $5c
DSP_FLG	    = $6c
DSP_ENDX    = $7c
DSP_EFB	    = $0d
DSP_PMON    = $2d
DSP_NON	    = $3d
DSP_EON	    = $4d
DSP_DIR	    = $5d
DSP_ESA	    = $6d
DSP_EDL	    = $7d
DSP_C0	    = $0f
DSP_C1	    = $1f
DSP_C2	    = $2f
DSP_C3	    = $3f
DSP_C4	    = $4f
DSP_C5	    = $5f
DSP_C6	    = $6f
DSP_C7 	    = $7f

; Work area defines

;; Sequencer engine
TRACK_NUM    = $0235
OUTPUT_CHAN  = $0265
NOTE_NUM     = $0285

0800: 00        nop
0801: 22 00     set1  $00
0803: 25 aa a7  and   a,$a7aa
0806: 64 bf     cmp   a,$bf
0808: c0        di
0809: de 40 df  cbne  $40+x,$07eb
080c: c0        di
080d: df        daa   a
080e: 40        setp
080f: e0        clrv
0810: 00        nop
0811: 00        nop
0812: 56 31 30  eor   a,$3031+y
0815: 38 c0 20  and   $20,#$c0
0818: cd ff     mov   x,#$ff
081a: bd        mov   sp,x
081b: e8 00     mov   a,#$00
081d: 5d        mov   x,a

081e: af        mov   (x)+,a
081f: c8 e0     cmp   x,#$e0
0821: d0 fb     bne   $081e

; Wipe out work area
0823: e8 00     mov   a,#$00
0825: 5d        mov   x,a
0826: d5 00 01  mov   $0100+x,a  ; Loop from here
0829: d5 00 02  mov   $0200+x,a
082c: d5 00 03  mov   $0300+x,a
082f: d5 00 04  mov   $0400+x,a
0832: d5 00 05  mov   $0500+x,a
0835: d5 00 06  mov   $0600+x,a
0838: d5 00 07  mov   $0700+x,a
083b: 3d        inc   x
083c: d0 e8     bne   $0826

083e: 3f 48 1e  call  $1e48
0841: 3f 04 09  call  $0904
0844: 8f 68 f6  mov   PORT2,#$68
0847: 8f 09 f7  mov   PORT3,#$09
084a: 3f 59 08  call  $0859
084d: 3f 7c 08  call  $087c
0850: 3f 65 0e  call  $0e65
0853: 3f 05 0a  call  $0a05
0856: 5f 4a 08  jmp   $084a
0859: e4 f4     mov   a,PORT0
085b: 44 19     eor   a,$19
085d: 10 0b     bpl   $086a
085f: e4 f4     mov   a,PORT0
0861: c4 19     mov   $19,a
0863: c4 f4     mov   PORT0,a
0865: 08 80     or    a,#$80
0867: c5 00 02  mov   $0200,a
086a: e4 f5     mov   a,PORT1
086c: 44 1a     eor   a,$1a
086e: 10 0b     bpl   $087b
0870: e4 f5     mov   a,PORT1
0872: c4 1a     mov   $1a,a
0874: c4 f5     mov   PORT1,a
0876: 08 80     or    a,#$80
0878: c5 02 02  mov   $0202,a
087b: 6f        ret
087c: e5 00 02  mov   a,$0200
087f: 30 01     bmi   $0882
0881: 6f        ret
0882: 28 7f     and   a,#$7f
0884: c5 00 02  mov   $0200,a
0887: 28 3f     and   a,#$3f
0889: 68 37     cmp   a,#$37
088b: 90 19     bcc   $08a6
088d: a8 37     sbc   a,#$37
088f: 1c        asl   a
0890: 5d        mov   x,a
0891: 1f 94 08  jmp   ($0894+x)
0894: ce        pop   x
0895: 08 ef     or    a,#$ef
0897: 08 eb     or    a,#$eb
0899: 08 e7     or    a,#$e7
089b: 08 e3     or    a,#$e3
089d: 08 f7     or    a,#PORT3
089f: 08 f3     or    a,#DSP_DATA
08a1: 08 fb     or    a,#$fb
08a3: 08 04     or    a,#$04
08a5: 09 3f c9  or    ($c9),($3f)
08a8: 08 68     or    a,#$68
08aa: ff        stop
08ab: d0 01     bne   $08ae
08ad: 6f        ret
08ae: 8f 00 17  mov   $17,#$00
08b1: 2d        push  a
08b2: c5 01 02  mov   $0201,a
08b5: e5 00 02  mov   a,$0200
08b8: 28 40     and   a,#$40
08ba: ae        pop   a
08bb: f0 03     beq   $08c0
08bd: 8f ff 17  mov   $17,#$ff
08c0: 65 65 bf  cmp   a,$bf65
08c3: b0 03     bcs   $08c8
08c5: 5f 67 09  jmp   $0967
08c8: 6f        ret
08c9: fd        mov   y,a
08ca: f6 c0 de  mov   a,$dec0+y
08cd: 6f        ret
08ce: 3f 04 09  call  $0904
08d1: 8f f0 f1  mov   $f1,#$f0
08d4: 8f 00 f4  mov   PORT0,#$00
08d7: 8f 00 f5  mov   PORT1,#$00
08da: 8f 00 f6  mov   PORT2,#$00
08dd: 8f 00 f7  mov   PORT3,#$00
08e0: 5f c0 ff  jmp   $ffc0
08e3: 8f fe 66  mov   $66,#$fe
08e6: 6f        ret
08e7: 8f 02 66  mov   $66,#$02
08ea: 6f        ret
08eb: 8f f0 68  mov   $68,#$f0
08ee: 6f        ret
08ef: 8f 03 68  mov   $68,#$03
08f2: 6f        ret
08f3: 8f 00 65  mov   $65,#$00
08f6: 6f        ret
08f7: 8f ff 65  mov   $65,#$ff
08fa: 6f        ret
08fb: 3f 04 09  call  $0904
08fe: 3f 27 20  call  $2027
0901: 5f 16 08  jmp   $0816
0904: 3f 74 1f  call  $1f74
0907: e8 00     mov   a,#$00
0909: c5 01 02  mov   $0201,a
090c: c5 00 02  mov   $0200,a
090f: c4 17     mov   $17,a
0911: e8 80     mov   a,#$80
0913: c5 03 02  mov   $0203,a
0916: e8 ff     mov   a,#$ff
0918: c4 67     mov   $67,a
091a: c4 69     mov   $69,a
091c: c4 3f     mov   $3f,a
091e: c5 04 02  mov   $0204,a
0921: e5 10 08  mov   a,$0810
0924: 05 11 08  or    a,$0811
0927: c4 65     mov   $65,a
0929: e8 00     mov   a,#$00
092b: c4 66     mov   $66,a
092d: c4 68     mov   $68,a
092f: c4 34     mov   $34,a
0931: c4 30     mov   $30,a
0933: c4 20     mov   $20,a
0935: c4 21     mov   $21,a
0937: c4 22     mov   $22,a
0939: c4 23     mov   $23,a
093b: c4 24     mov   $24,a
093d: c4 25     mov   $25,a
093f: c4 26     mov   $26,a
0941: c4 27     mov   $27,a
0943: c4 3c     mov   $3c,a
0945: c4 3d     mov   $3d,a
0947: cd 0f     mov   x,#$0f
0949: d5 15 02  mov   $0215+x,a
094c: 1d        dec   x
094d: 10 fa     bpl   $0949
094f: cd 07     mov   x,#$07
0951: 7d        mov   a,x
0952: 9f        xcn   a
0953: 2d        push  a
0954: 08 07     or    a,#$07
0956: c4 f2     mov   $f2,a
0958: 8f 9e f3  mov   DSP_DATA,#$9e
095b: ae        pop   a
095c: 08 05     or    a,#$05
095e: c4 f2     mov   $f2,a
0960: 8f 00 f3  mov   DSP_DATA,#$00
0963: 1d        dec   x
0964: 10 eb     bpl   $0951
0966: 6f        ret
0967: 2d        push  a
0968: 3f 11 09  call  $0911
096b: 3f 6a 1e  call  $1e6a
096e: 3f 74 1f  call  $1f74
0971: e8 00     mov   a,#$00
0973: c5 a5 02  mov   $02a5,a
0976: c5 a6 02  mov   $02a6,a
0979: c5 a7 02  mov   $02a7,a
097c: c5 a8 02  mov   $02a8,a
097f: c5 a9 02  mov   $02a9,a
0982: c5 ab 02  mov   $02ab,a
0985: c5 aa 02  mov   $02aa,a
0988: 9c        dec   a
0989: c4 3f     mov   $3f,a
098b: bc        inc   a
098c: c4 3c     mov   $3c,a
098e: c4 3d     mov   $3d,a
0990: ae        pop   a
0991: 1c        asl   a
0992: 5d        mov   x,a
0993: f5 66 bf  mov   a,$bf66+x
0996: c4 02     mov   $02,a
0998: f5 67 bf  mov   a,$bf67+x
099b: c4 03     mov   $03,a
099d: 8d 00     mov   y,#$00
099f: cd 00     mov   x,#$00
09a1: 8d 00     mov   y,#$00
09a3: f7 02     mov   a,($02)+y
09a5: c4 04     mov   $04,a
09a7: 3a 02     incw  $02
09a9: f7 02     mov   a,($02)+y
09ab: 68 ff     cmp   a,#$ff
09ad: f0 3c     beq   $09eb
09af: c4 05     mov   $05,a
09b1: 3a 02     incw  $02
09b3: e4 03     mov   a,$03
09b5: fd        mov   y,a
09b6: d5 15 02  mov   $0215+x,a
09b9: e4 02     mov   a,$02
09bb: d5 05 02  mov   $0205+x,a
09be: 7a 04     addw  ya,$04
09c0: da 02     movw  $02,ya
09c2: 40        setp
09c3: e8 00     mov   a,#$00
09c5: d4 06     mov   $06+x,a
09c7: d4 16     mov   $16+x,a
09c9: d4 26     mov   $26+x,a
09cb: d4 36     mov   $36+x,a
09cd: 20        clrp
09ce: d5 45 02  mov   $0245+x,a
09d1: d5 35 02  mov   $0235+x,a
09d4: d5 55 02  mov   $0255+x,a
09d7: d5 25 02  mov   $0225+x,a
09da: d5 75 02  mov   $0275+x,a
09dd: d5 85 02  mov   $0285+x,a
09e0: d5 95 02  mov   $0295+x,a
09e3: 3d        inc   x
09e4: c8 10     cmp   x,#$10
09e6: d0 b9     bne   $09a1
09e8: 5f f8 09  jmp   $09f8
09eb: e8 00     mov   a,#$00
09ed: d5 15 02  mov   $0215+x,a
09f0: d5 05 02  mov   $0205+x,a
09f3: 3d        inc   x
09f4: c8 10     cmp   x,#$10
09f6: d0 f3     bne   $09eb
09f8: e8 00     mov   a,#$00
09fa: c5 ac 02  mov   $02ac,a
09fd: 9c        dec   a
09fe: c5 04 02  mov   $0204,a
0a01: c5 03 02  mov   $0203,a
0a04: 6f        ret
0a05: fa fe 6b  mov   ($6b),($fe)
0a08: e4 fd     mov   a,$fd
0a0a: f0 62     beq   $0a6e
0a0c: ab 63     inc   $63
0a0e: 60        clrc
0a0f: e4 66     mov   a,$66
0a11: 30 08     bmi   $0a1b
0a13: 84 67     adc   a,$67
0a15: 90 0a     bcc   $0a21
0a17: e8 ff     mov   a,#$ff
0a19: 2f 06     bra   $0a21
0a1b: 84 67     adc   a,$67
0a1d: b0 02     bcs   $0a21
0a1f: e8 00     mov   a,#$00
0a21: c4 67     mov   $67,a
0a23: e5 03 02  mov   a,$0203
0a26: 60        clrc
0a27: 85 04 02  adc   a,$0204
0a2a: c5 04 02  mov   $0204,a
0a2d: 90 39     bcc   $0a68
0a2f: e8 00     mov   a,#$00
0a31: c4 16     mov   $16,a
0a33: c4 6d     mov   $6d,a
0a35: cd 0f     mov   x,#$0f
0a37: f5 15 02  mov   a,$0215+x
0a3a: f0 0b     beq   $0a47
0a3c: 3f 72 0a  call  $0a72
0a3f: f5 15 02  mov   a,$0215+x
0a42: f0 03     beq   $0a47
0a44: 8f ff 16  mov   $16,#$ff
0a47: 1d        dec   x
0a48: 10 ed     bpl   $0a37
0a4a: 3f cc 1c  call  $1ccc
0a4d: e4 18     mov   a,$18
0a4f: 10 07     bpl   $0a58
0a51: 28 7f     and   a,#$7f
0a53: c4 18     mov   $18,a
0a55: 5f 65 0a  jmp   $0a65
0a58: e4 16     mov   a,$16
0a5a: d0 0c     bne   $0a68
0a5c: e4 17     mov   a,$17
0a5e: f0 08     beq   $0a68
0a60: e5 01 02  mov   a,$0201
0a63: 28 3f     and   a,#$3f
0a65: 3f 91 09  call  $0991
0a68: 3f 04 0f  call  $0f04
0a6b: 3f 9c 1e  call  $1e9c
0a6e: 3f 9d 0a  call  $0a9d
0a71: 6f        ret
0a72: f5 25 02  mov   a,$0225+x
0a75: f0 06     beq   $0a7d
0a77: 9c        dec   a
0a78: d5 25 02  mov   $0225+x,a
0a7b: d0 0f     bne   $0a8c
0a7d: 4d        push  x
0a7e: 3f ab 18  call  $18ab
0a81: ce        pop   x
0a82: f5 15 02  mov   a,$0215+x
0a85: f0 05     beq   $0a8c
0a87: f5 25 02  mov   a,$0225+x
0a8a: f0 f1     beq   $0a7d
0a8c: 6f        ret
0a8d: e4 00     mov   a,$00
0a8f: 68 a0     cmp   a,#$a0
0a91: 90 01     bcc   $0a94
0a93: 6f        ret
0a94: 28 0f     and   a,#$0f
0a96: 5d        mov   x,a
0a97: e4 02     mov   a,$02
0a99: 3f 1c 0e  call  $0e1c
0a9c: 6f        ret
0a9d: 3f a5 0d  call  $0da5
0aa0: e4 3f     mov   a,$3f
0aa2: 48 ff     eor   a,#$ff
0aa4: 24 3d     and   a,$3d
0aa6: c4 12     mov   $12,a
0aa8: e4 30     mov   a,$30
0aaa: 04 40     or    a,$40
0aac: c4 13     mov   $13,a
0aae: cd 07     mov   x,#$07
0ab0: e4 3c     mov   a,$3c
0ab2: d8 15     mov   $15,x
0ab4: 0b 13     asl   $13
0ab6: 90 05     bcc   $0abd
0ab8: 1c        asl   a
0ab9: 2d        push  a
0aba: 5f d8 0a  jmp   $0ad8
0abd: 1c        asl   a
0abe: 2d        push  a
0abf: b0 0c     bcs   $0acd
0ac1: 7d        mov   a,x
0ac2: 9f        xcn   a
0ac3: 08 08     or    a,#$08
0ac5: c4 f2     mov   $f2,a
0ac7: e4 f3     mov   a,DSP_DATA
0ac9: 68 02     cmp   a,#$02
0acb: 90 0b     bcc   $0ad8
0acd: 3f fd 0a  call  $0afd
0ad0: 3f 50 0c  call  $0c50
0ad3: 3f 2f 0b  call  $0b2f
0ad6: f8 15     mov   x,$15
0ad8: f4 41     mov   a,$41+x
0ada: 28 0f     and   a,#$0f
0adc: fd        mov   y,a
0add: f6 2f 03  mov   a,$032f+y
0ae0: 68 01     cmp   a,#$01
0ae2: 2b 33     rol   $33
0ae4: ae        pop   a
0ae5: 0b 14     asl   $14
0ae7: 0b 12     asl   $12
0ae9: 1d        dec   x
0aea: 10 c6     bpl   $0ab2
0aec: 29 30 34  and   ($34),($30)
0aef: e4 30     mov   a,$30
0af1: 48 ff     eor   a,#$ff
0af3: 24 33     and   a,$33
0af5: 04 34     or    a,$34
0af7: c4 33     mov   $33,a
0af9: 3f cc 0d  call  $0dcc
0afc: 6f        ret
0afd: f4 51     mov   a,$51+x
0aff: c4 61     mov   $61,a
0b01: f4 59     mov   a,$59+x
0b03: c4 62     mov   $62,a
0b05: 8d 0d     mov   y,#$0d
0b07: f7 61     mov   a,($61)+y
0b09: c4 0e     mov   $0e,a
0b0b: 8d 0e     mov   y,#$0e
0b0d: f7 61     mov   a,($61)+y
0b0f: c4 0f     mov   $0f,a
0b11: e4 12     mov   a,$12
0b13: 10 01     bpl   $0b16
0b15: 6f        ret
0b16: 8d 01     mov   y,#$01
0b18: f7 61     mov   a,($61)+y
0b1a: c4 0c     mov   $0c,a
0b1c: 8d 00     mov   y,#$00
0b1e: f7 61     mov   a,($61)+y
0b20: c4 0d     mov   $0d,a
0b22: 8d 08     mov   y,#$08
0b24: f7 61     mov   a,($61)+y
0b26: c4 10     mov   $10,a
0b28: 8d 07     mov   y,#$07
0b2a: f7 61     mov   a,($61)+y
0b2c: c4 11     mov   $11,a
0b2e: 6f        ret
0b2f: 3f d2 0b  call  $0bd2
0b32: f5 6a 21  mov   a,$216a+x
0b35: 2d        push  a
0b36: f4 41     mov   a,$41+x
0b38: 5d        mov   x,a
0b39: 28 70     and   a,#$70
0b3b: 9f        xcn   a
0b3c: fd        mov   y,a
0b3d: fc        inc   y
0b3e: f6 c9 0b  mov   a,$0bc9+y
0b41: fd        mov   y,a
0b42: e4 67     mov   a,$67
0b44: cf        mul   ya
0b45: 7d        mov   a,x
0b46: 28 0f     and   a,#$0f
0b48: 5d        mov   x,a
0b49: 60        clrc
0b4a: f5 ef 02  mov   a,$02ef+x
0b4d: 95 ff 03  adc   a,$03ff+x
0b50: cf        mul   ya
0b51: cb 0c     mov   $0c,y
0b53: d8 0d     mov   $0d,x
0b55: f5 1f 03  mov   a,$031f+x
0b58: 2d        push  a
0b59: 48 ff     eor   a,#$ff
0b5b: 28 7f     and   a,#$7f
0b5d: 68 40     cmp   a,#$40
0b5f: 90 02     bcc   $0b63
0b61: e8 3f     mov   a,#$3f
0b63: 1c        asl   a
0b64: c4 04     mov   $04,a
0b66: ae        pop   a
0b67: 68 40     cmp   a,#$40
0b69: 90 02     bcc   $0b6d
0b6b: e8 3f     mov   a,#$3f
0b6d: 1c        asl   a
0b6e: c4 05     mov   $05,a
0b70: e4 65     mov   a,$65
0b72: f0 0a     beq   $0b7e
0b74: 60        clrc
0b75: e4 04     mov   a,$04
0b77: 84 05     adc   a,$05
0b79: 5c        lsr   a
0b7a: c4 04     mov   $04,a
0b7c: c4 05     mov   $05,a
0b7e: e4 04     mov   a,$04
0b80: cf        mul   ya
0b81: e8 00     mov   a,#$00
0b83: 04 02     or    a,$02
0b85: da f2     movw  $f2,ya
0b87: e4 05     mov   a,$05
0b89: eb 0c     mov   y,$0c
0b8b: cf        mul   ya
0b8c: ab f2     inc   $f2
0b8e: cb f3     mov   DSP_DATA,y
0b90: f8 0d     mov   x,$0d
0b92: ab f2     inc   $f2
0b94: fa 00 f3  mov   ($f3),($00)
0b97: ab f2     inc   $f2
0b99: fa 01 f3  mov   ($f3),($01)
0b9c: ae        pop   a
0b9d: 24 3c     and   a,$3c
0b9f: d0 01     bne   $0ba2
0ba1: 6f        ret
0ba2: ab f2     inc   $f2
0ba4: 8d 0c     mov   y,#$0c
0ba6: f7 61     mov   a,($61)+y
0ba8: 5d        mov   x,a
0ba9: f5 40 e0  mov   a,$e040+x
0bac: c4 f3     mov   DSP_DATA,a
0bae: f8 0d     mov   x,$0d
0bb0: ab f2     inc   $f2
0bb2: 8d 05     mov   y,#$05
0bb4: f7 61     mov   a,($61)+y
0bb6: c4 f3     mov   DSP_DATA,a
0bb8: ab f2     inc   $f2
0bba: 8d 04     mov   y,#$04
0bbc: f7 61     mov   a,($61)+y
0bbe: c4 f3     mov   DSP_DATA,a
0bc0: ab f2     inc   $f2
0bc2: 8d 06     mov   y,#$06
0bc4: f7 61     mov   a,($61)+y
0bc6: c4 f3     mov   DSP_DATA,a
0bc8: 6f        ret
0bc9: 00        nop
0bca: 40        setp
0bcb: 62 84     set3  $84
0bcd: a6        sbc   a,(x)
0bce: b8 ca ec  sbc   $ec,#$ca
0bd1: ff        stop
0bd2: 4d        push  x
0bd3: f4 49     mov   a,$49+x
0bd5: c4 00     mov   $00,a
0bd7: 7d        mov   a,x
0bd8: fd        mov   y,a
0bd9: 9f        xcn   a
0bda: c4 02     mov   $02,a
0bdc: f4 41     mov   a,$41+x
0bde: 28 0f     and   a,#$0f
0be0: 5d        mov   x,a
0be1: 60        clrc
0be2: e4 0e     mov   a,$0e
0be4: 96 df 03  adc   a,$03df+y
0be7: c4 0e     mov   $0e,a
0be9: e4 0f     mov   a,$0f
0beb: 96 ef 03  adc   a,$03ef+y
0bee: c4 0f     mov   $0f,a
0bf0: 80        setc
0bf1: f5 cf 02  mov   a,$02cf+x
0bf4: a8 40     sbc   a,#$40
0bf6: c4 04     mov   $04,a
0bf8: 68 80     cmp   a,#$80
0bfa: a4 04     sbc   a,$04
0bfc: 48 ff     eor   a,#$ff
0bfe: c4 05     mov   $05,a
0c00: f5 cf 03  mov   a,$03cf+x
0c03: fd        mov   y,a
0c04: f5 bf 03  mov   a,$03bf+x
0c07: 7a 0e     addw  ya,$0e
0c09: 7a 04     addw  ya,$04
0c0b: c4 04     mov   $04,a
0c0d: dd        mov   a,y
0c0e: 60        clrc
0c0f: 84 00     adc   a,$00
0c11: 8d 00     mov   y,#$00
0c13: cd 0c     mov   x,#$0c
0c15: 9e        div   ya,x
0c16: 2d        push  a
0c17: dd        mov   a,y
0c18: 5d        mov   x,a
0c19: f5 7e 21  mov   a,$217e+x
0c1c: eb 04     mov   y,$04
0c1e: cf        mul   ya
0c1f: cb 0c     mov   $0c,y
0c21: 8f 00 0d  mov   $0d,#$00
0c24: f5 72 21  mov   a,$2172+x
0c27: eb 04     mov   y,$04
0c29: cf        mul   ya
0c2a: 7a 0c     addw  ya,$0c
0c2c: 60        clrc
0c2d: 95 96 21  adc   a,$2196+x
0c30: c4 00     mov   $00,a
0c32: dd        mov   a,y
0c33: 95 8a 21  adc   a,$218a+x
0c36: c4 01     mov   $01,a
0c38: ae        pop   a
0c39: 48 ff     eor   a,#$ff
0c3b: 80        setc
0c3c: 88 06     adc   a,#$06
0c3e: f0 0e     beq   $0c4e
0c40: 68 06     cmp   a,#$06
0c42: b0 0a     bcs   $0c4e
0c44: fd        mov   y,a
0c45: e4 01     mov   a,$01
0c47: 5c        lsr   a
0c48: 6b 00     ror   $00
0c4a: fe fb     dbnz  y,$0c47
0c4c: c4 01     mov   $01,a
0c4e: ce        pop   x
0c4f: 6f        ret
0c50: e4 12     mov   a,$12
0c52: 10 01     bpl   $0c55
0c54: 6f        ret
0c55: 7d        mov   a,x
0c56: fd        mov   y,a
0c57: f4 41     mov   a,$41+x
0c59: 28 0f     and   a,#$0f
0c5b: 5d        mov   x,a
0c5c: 6d        push  y
0c5d: 3f 2e 0d  call  $0d2e
0c60: ee        pop   y
0c61: 3f 97 0c  call  $0c97
0c64: 3f 6a 0c  call  $0c6a
0c67: f8 15     mov   x,$15
0c69: 6f        ret
0c6a: f5 bf 02  mov   a,$02bf+x
0c6d: bc        inc   a
0c6e: 1c        asl   a
0c6f: fd        mov   y,a
0c70: f5 6f 03  mov   a,$036f+x
0c73: 10 21     bpl   $0c96
0c75: 28 7f     and   a,#$7f
0c77: d5 6f 03  mov   $036f+x,a
0c7a: 80        setc
0c7b: a8 40     sbc   a,#$40
0c7d: 1c        asl   a
0c7e: 10 0e     bpl   $0c8e
0c80: 48 ff     eor   a,#$ff
0c82: bc        inc   a
0c83: cf        mul   ya
0c84: da 04     movw  $04,ya
0c86: e8 00     mov   a,#$00
0c88: fd        mov   y,a
0c89: 9a 04     subw  ya,$04
0c8b: 5f 8f 0c  jmp   $0c8f
0c8e: cf        mul   ya
0c8f: d5 bf 03  mov   $03bf+x,a
0c92: dd        mov   a,y
0c93: d5 cf 03  mov   $03cf+x,a
0c96: 6f        ret
0c97: e4 0c     mov   a,$0c
0c99: d0 03     bne   $0c9e
0c9b: 5f 21 0d  jmp   $0d21
0c9e: e4 6b     mov   a,$6b
0ca0: d0 03     bne   $0ca5
0ca2: 5f 20 0d  jmp   $0d20
0ca5: e4 63     mov   a,$63
0ca7: 28 01     and   a,#$01
0ca9: d0 03     bne   $0cae
0cab: 5f 20 0d  jmp   $0d20
0cae: f5 af 02  mov   a,$02af+x
0cb1: d0 2d     bne   $0ce0
0cb3: f6 17 04  mov   a,$0417+y
0cb6: f0 07     beq   $0cbf
0cb8: 9c        dec   a
0cb9: d6 17 04  mov   $0417+y,a
0cbc: 5f 21 0d  jmp   $0d21
0cbf: f6 1f 04  mov   a,$041f+y
0cc2: f0 1c     beq   $0ce0
0cc4: 60        clrc
0cc5: f6 47 04  mov   a,$0447+y
0cc8: 96 2f 04  adc   a,$042f+y
0ccb: d6 47 04  mov   $0447+y,a
0cce: f6 3f 04  mov   a,$043f+y
0cd1: 96 27 04  adc   a,$0427+y
0cd4: d6 3f 04  mov   $043f+y,a
0cd7: f6 1f 04  mov   a,$041f+y
0cda: 9c        dec   a
0cdb: d6 1f 04  mov   $041f+y,a
0cde: d0 05     bne   $0ce5
0ce0: e4 0c     mov   a,$0c
0ce2: d6 3f 04  mov   $043f+y,a
0ce5: 60        clrc
0ce6: f6 0f 04  mov   a,$040f+y
0ce9: 84 0d     adc   a,$0d
0ceb: d6 0f 04  mov   $040f+y,a
0cee: c4 06     mov   $06,a
0cf0: 1c        asl   a
0cf1: 1c        asl   a
0cf2: 90 02     bcc   $0cf6
0cf4: 48 ff     eor   a,#$ff
0cf6: 2d        push  a
0cf7: f6 3f 04  mov   a,$043f+y
0cfa: ee        pop   y
0cfb: 68 f1     cmp   a,#$f1
0cfd: 90 06     bcc   $0d05
0cff: 28 0f     and   a,#$0f
0d01: cf        mul   ya
0d02: 5f 09 0d  jmp   $0d09
0d05: cf        mul   ya
0d06: dd        mov   a,y
0d07: 8d 00     mov   y,#$00
0d09: aa 06 e0  mov1  c,$0006,7
0d0c: 90 07     bcc   $0d15
0d0e: da 06     movw  $06,ya
0d10: 8d 00     mov   y,#$00
0d12: dd        mov   a,y
0d13: 9a 06     subw  ya,$06
0d15: 4d        push  x
0d16: f8 15     mov   x,$15
0d18: d5 df 03  mov   $03df+x,a
0d1b: dd        mov   a,y
0d1c: d5 ef 03  mov   $03ef+x,a
0d1f: ce        pop   x
0d20: 6f        ret
0d21: 4d        push  x
0d22: f8 15     mov   x,$15
0d24: e8 00     mov   a,#$00
0d26: d5 df 03  mov   $03df+x,a
0d29: d5 ef 03  mov   $03ef+x,a
0d2c: ce        pop   x
0d2d: 6f        ret
0d2e: e4 10     mov   a,$10
0d30: f0 69     beq   $0d9b
0d32: e4 6b     mov   a,$6b
0d34: f0 65     beq   $0d9b
0d36: e4 63     mov   a,$63
0d38: 28 01     and   a,#$01
0d3a: d0 5f     bne   $0d9b
0d3c: f5 af 02  mov   a,$02af+x
0d3f: d0 2d     bne   $0d6e
0d41: f6 57 04  mov   a,$0457+y
0d44: f0 07     beq   $0d4d
0d46: 9c        dec   a
0d47: d6 57 04  mov   $0457+y,a
0d4a: 5f 9b 0d  jmp   $0d9b
0d4d: f6 5f 04  mov   a,$045f+y
0d50: f0 1c     beq   $0d6e
0d52: 60        clrc
0d53: f6 87 04  mov   a,$0487+y
0d56: 96 6f 04  adc   a,$046f+y
0d59: d6 87 04  mov   $0487+y,a
0d5c: f6 7f 04  mov   a,$047f+y
0d5f: 96 67 04  adc   a,$0467+y
0d62: d6 7f 04  mov   $047f+y,a
0d65: f6 5f 04  mov   a,$045f+y
0d68: 9c        dec   a
0d69: d6 5f 04  mov   $045f+y,a
0d6c: d0 05     bne   $0d73
0d6e: e4 10     mov   a,$10
0d70: d6 7f 04  mov   $047f+y,a
0d73: 60        clrc
0d74: f6 4f 04  mov   a,$044f+y
0d77: 84 11     adc   a,$11
0d79: d6 4f 04  mov   $044f+y,a
0d7c: c4 06     mov   $06,a
0d7e: 1c        asl   a
0d7f: 1c        asl   a
0d80: 90 02     bcc   $0d84
0d82: 48 ff     eor   a,#$ff
0d84: 2d        push  a
0d85: f6 7f 04  mov   a,$047f+y
0d88: ee        pop   y
0d89: cf        mul   ya
0d8a: dd        mov   a,y
0d8b: aa 06 e0  mov1  c,$0006,7
0d8e: 90 03     bcc   $0d93
0d90: 48 ff     eor   a,#$ff
0d92: bc        inc   a
0d93: 4d        push  x
0d94: f8 15     mov   x,$15
0d96: d5 ff 03  mov   $03ff+x,a
0d99: ce        pop   x
0d9a: 6f        ret
0d9b: 4d        push  x
0d9c: f8 15     mov   x,$15
0d9e: e8 00     mov   a,#$00
0da0: d5 ff 03  mov   $03ff+x,a
0da3: ce        pop   x
0da4: 6f        ret
0da5: e4 30     mov   a,$30
0da7: 48 ff     eor   a,#$ff
0da9: 2d        push  a
0daa: 24 3d     and   a,$3d
0dac: 04 31     or    a,$31
0dae: c4 3e     mov   $3e,a
0db0: ae        pop   a
0db1: 24 3f     and   a,$3f
0db3: 04 32     or    a,$32
0db5: c4 40     mov   $40,a
0db7: c4 12     mov   $12,a
0db9: cd 07     mov   x,#$07
0dbb: 0b 12     asl   $12
0dbd: 90 09     bcc   $0dc8
0dbf: 7d        mov   a,x
0dc0: 9f        xcn   a
0dc1: 08 07     or    a,#$07
0dc3: c4 f2     mov   $f2,a
0dc5: 8f 9e f3  mov   DSP_DATA,#$9e
0dc8: 1d        dec   x
0dc9: 10 f0     bpl   $0dbb
0dcb: 6f        ret
0dcc: 8f 4d f2  mov   $f2,#$4d
0dcf: fa 33 f3  mov   ($f3),($33)
0dd2: e4 40     mov   a,$40
0dd4: 48 ff     eor   a,#$ff
0dd6: 24 3e     and   a,$3e
0dd8: 8d 4c     mov   y,#$4c
0dda: 3f 1d 20  call  $201d
0ddd: e4 3f     mov   a,$3f
0ddf: 48 ff     eor   a,#$ff
0de1: 24 3d     and   a,$3d
0de3: 4e 3d 00  tclr1 $003d
0de6: e4 32     mov   a,$32
0de8: 48 ff     eor   a,#$ff
0dea: 24 31     and   a,$31
0dec: 4e 31 00  tclr1 $0031
0def: 8f 00 3f  mov   $3f,#$00
0df2: 8f 00 32  mov   $32,#$00
0df5: 6f        ret
0df6: 28 7f     and   a,#$7f
0df8: 3f 06 0e  call  $0e06
0dfb: e4 12     mov   a,$12
0dfd: d5 9f 03  mov   $039f+x,a
0e00: e4 13     mov   a,$13
0e02: d5 af 03  mov   $03af+x,a
0e05: 6f        ret
0e06: fd        mov   y,a
0e07: f6 c0 df  mov   a,$dfc0+y
0e0a: 68 ff     cmp   a,#$ff
0e0c: d0 01     bne   $0e0f
0e0e: bc        inc   a
0e0f: 1c        asl   a
0e10: fd        mov   y,a
0e11: f6 00 22  mov   a,$2200+y
0e14: c4 12     mov   $12,a
0e16: f6 01 22  mov   a,$2201+y
0e19: c4 13     mov   $13,a
0e1b: 6f        ret
0e1c: 2d        push  a
0e1d: f5 9f 03  mov   a,$039f+x
0e20: c4 0e     mov   $0e,a
0e22: f5 af 03  mov   a,$03af+x
0e25: c4 0f     mov   $0f,a
0e27: ae        pop   a
0e28: 8d 0f     mov   y,#$0f
0e2a: 77 0e     cmp   a,($0e)+y
0e2c: 90 26     bcc   $0e54
0e2e: 8d 1f     mov   y,#$1f
0e30: 77 0e     cmp   a,($0e)+y
0e32: 90 20     bcc   $0e54
0e34: 8d 2f     mov   y,#$2f
0e36: 77 0e     cmp   a,($0e)+y
0e38: 90 1a     bcc   $0e54
0e3a: 8d 3f     mov   y,#$3f
0e3c: 77 0e     cmp   a,($0e)+y
0e3e: 90 14     bcc   $0e54
0e40: 8d 4f     mov   y,#$4f
0e42: 77 0e     cmp   a,($0e)+y
0e44: 90 0e     bcc   $0e54
0e46: 8d 5f     mov   y,#$5f
0e48: 77 0e     cmp   a,($0e)+y
0e4a: 90 08     bcc   $0e54
0e4c: 8d 6f     mov   y,#$6f
0e4e: 77 0e     cmp   a,($0e)+y
0e50: 90 02     bcc   $0e54
0e52: 8d 7f     mov   y,#$7f
0e54: dd        mov   a,y
0e55: 28 f0     and   a,#$f0
0e57: 60        clrc
0e58: 84 0e     adc   a,$0e
0e5a: d5 7f 03  mov   $037f+x,a
0e5d: e8 00     mov   a,#$00
0e5f: 84 0f     adc   a,$0f
0e61: d5 8f 03  mov   $038f+x,a
0e64: 6f        ret
0e65: e8 ff     mov   a,#$ff
0e67: c4 06     mov   $06,a
0e69: e5 02 02  mov   a,$0202
0e6c: 30 01     bmi   $0e6f
0e6e: 6f        ret
0e6f: 28 7f     and   a,#$7f
0e71: c5 02 02  mov   $0202,a
0e74: fd        mov   y,a
0e75: f6 40 df  mov   a,$df40+y
0e78: 68 ff     cmp   a,#$ff
0e7a: d0 01     bne   $0e7d
0e7c: 6f        ret
0e7d: 65 ab a7  cmp   a,$a7ab
0e80: 90 01     bcc   $0e83
0e82: 6f        ret
0e83: 1c        asl   a
0e84: fd        mov   y,a
0e85: f6 ac a7  mov   a,$a7ac+y
0e88: c4 04     mov   $04,a
0e8a: f6 ad a7  mov   a,$a7ad+y
0e8d: c4 05     mov   $05,a
0e8f: 8d 00     mov   y,#$00
0e91: f7 04     mov   a,($04)+y
0e93: c4 07     mov   $07,a
0e95: fc        inc   y
0e96: f7 04     mov   a,($04)+y
0e98: 68 08     cmp   a,#$08
0e9a: 90 02     bcc   $0e9e
0e9c: e8 07     mov   a,#$07
0e9e: c5 b4 0e  mov   $0eb4,a
0ea1: e5 02 02  mov   a,$0202
0ea4: 08 80     or    a,#$80
0ea6: cd 00     mov   x,#$00
0ea8: 74 28     cmp   a,$28+x
0eaa: f0 23     beq   $0ecf
0eac: 3d        inc   x
0ead: c8 08     cmp   x,#$08
0eaf: d0 f7     bne   $0ea8
0eb1: 8d 00     mov   y,#$00
0eb3: cd 02     mov   x,#$02
0eb5: e8 ff     mov   a,#$ff
0eb7: 3e 06     cmp   x,$06
0eb9: f0 08     beq   $0ec3
0ebb: 74 20     cmp   a,$20+x
0ebd: 90 04     bcc   $0ec3
0ebf: 7d        mov   a,x
0ec0: fd        mov   y,a
0ec1: f4 20     mov   a,$20+x
0ec3: 1d        dec   x
0ec4: 10 f1     bpl   $0eb7
0ec6: 64 07     cmp   a,$07
0ec8: f0 03     beq   $0ecd
0eca: 90 01     bcc   $0ecd
0ecc: 6f        ret
0ecd: dd        mov   a,y
0ece: 5d        mov   x,a
0ecf: e4 07     mov   a,$07
0ed1: d4 20     mov   $20+x,a
0ed3: e5 02 02  mov   a,$0202
0ed6: 08 80     or    a,#$80
0ed8: d4 28     mov   $28+x,a
0eda: 60        clrc
0edb: e4 04     mov   a,$04
0edd: 88 02     adc   a,#$02
0edf: d5 8f 04  mov   $048f+x,a
0ee2: e4 05     mov   a,$05
0ee4: 88 00     adc   a,#$00
0ee6: d5 97 04  mov   $0497+x,a
0ee9: f5 6a 21  mov   a,$216a+x
0eec: 2d        push  a
0eed: 04 30     or    a,$30
0eef: c4 30     mov   $30,a
0ef1: ae        pop   a
0ef2: 48 ff     eor   a,#$ff
0ef4: 24 34     and   a,$34
0ef6: c4 34     mov   $34,a
0ef8: e8 00     mov   a,#$00
0efa: d5 67 05  mov   $0567+x,a
0efd: d5 5f 05  mov   $055f+x,a
0f00: 3f 44 18  call  $1844
0f03: 6f        ret
0f04: 60        clrc
0f05: e4 68     mov   a,$68
0f07: 30 08     bmi   $0f11
0f09: 84 69     adc   a,$69
0f0b: 90 0a     bcc   $0f17
0f0d: e8 ff     mov   a,#$ff
0f0f: 2f 06     bra   $0f17
0f11: 84 69     adc   a,$69
0f13: b0 02     bcs   $0f17
0f15: e8 00     mov   a,#$00
0f17: c4 69     mov   $69,a
0f19: 3f 5a 18  call  $185a
0f1c: e4 30     mov   a,$30
0f1e: cd 07     mov   x,#$07
0f20: 1c        asl   a
0f21: 90 03     bcc   $0f26
0f23: 3f 2a 0f  call  $0f2a
0f26: 1d        dec   x
0f27: 10 f7     bpl   $0f20
0f29: 6f        ret
0f2a: 2d        push  a
0f2b: 4d        push  x
0f2c: 8f 09 f2  mov   $f2,#$09
0f2f: e4 6c     mov   a,$6c
0f31: 84 f3     adc   a,DSP_DATA
0f33: c4 6c     mov   $6c,a
0f35: 7d        mov   a,x
0f36: 9f        xcn   a
0f37: c4 00     mov   $00,a
0f39: 7d        mov   a,x
0f3a: c4 12     mov   $12,a
0f3c: 1c        asl   a
0f3d: 1c        asl   a
0f3e: 1c        asl   a
0f3f: 84 12     adc   a,$12
0f41: c4 12     mov   $12,a
0f43: f5 8f 04  mov   a,$048f+x
0f46: c4 02     mov   $02,a
0f48: f5 97 04  mov   a,$0497+x
0f4b: c4 03     mov   $03,a
0f4d: 8d 00     mov   y,#$00
0f4f: dd        mov   a,y
0f50: 8d 00     mov   y,#$00
0f52: 7a 02     addw  ya,$02
0f54: da 02     movw  $02,ya
0f56: 8d 00     mov   y,#$00
0f58: 4d        push  x
0f59: f7 02     mov   a,($02)+y
0f5b: fc        inc   y
0f5c: 28 7f     and   a,#$7f
0f5e: 1c        asl   a
0f5f: 5d        mov   x,a
0f60: 1f 63 0f  jmp   ($0f63+x)
0f63: 93 12 b5  bbc4  $12,$0f1b
0f66: 12 e0     clr0  $e0
0f68: 12 05     clr0  $05
0f6a: 13 35 13  bbc0  $35,$0f80
0f6d: 77 13     cmp   a,($13)+y
0f6f: 99        adc   (x),(y)
0f70: 13 b6 13  bbc0  $b6,$0f86
0f73: db 13     mov   $13+x,y
0f75: fc        inc   y
0f76: 13 12 14  bbc0  $12,$0f8d
0f79: 21        tcall 2
0f7a: 14 43     or    a,$43+x
0f7c: 14 51     or    a,$51+x
0f7e: 14 62     or    a,$62+x
0f80: 14 76     or    a,$76+x
0f82: 14 84     or    a,$84+x
0f84: 14 95     or    a,$95+x
0f86: 14 1a     or    a,$1a+x
0f88: 18 ba 14  or    $14,#$ba
0f8b: d8 14     mov   $14,x
0f8d: f3 14 18  bbc7  $14,$0fa8
0f90: 15 3d 15  or    a,$153d+x
0f93: 5b 15     lsr   $15+x
0f95: 90 15     bcc   $0fac
0f97: a5 15 bb  sbc   a,$bb15
0f9a: 15 d1 15  or    a,$15d1+x
0f9d: e7 15     mov   a,($15+x)
0f9f: fb 15     mov   y,$15+x
0fa1: 0f        brk
0fa2: 16 25 16  or    a,$1625+y
0fa5: 55 16 85  eor   a,$8516+x
0fa8: 16 ae 16  or    a,$16ae+y
0fab: ec 16 11  mov   y,$1116
0fae: 17 36     or    a,($36)+y
0fb0: 17 5b     or    a,($5b)+y
0fb2: 17 6e     or    a,($6e)+y
0fb4: 17 8a     or    a,($8a)+y
0fb6: 17 9a     or    a,($9a)+y
0fb8: 17 aa     or    a,($aa)+y
0fba: 17 ba     or    a,($ba)+y
0fbc: 17 ca     or    a,($ca)+y
0fbe: 17 da     or    a,($da)+y
0fc0: 17 ea     or    a,($ea)+y
0fc2: 17 fd     or    a,($fd)+y
0fc4: 17 83     or    a,($83)+y
0fc6: 12 66     clr0  $66
0fc8: 12 26     clr0  $26
0fca: 11        tcall 1
0fcb: 53 11 89  bbc2  $11,$0f57
0fce: 11        tcall 1
0fcf: b9        sbc   (x),(y)
0fd0: 11        tcall 1
0fd1: e1        tcall 14
0fd2: 11        tcall 1
0fd3: 11        tcall 1
0fd4: 12 3b     clr0  $3b
0fd6: 12 e8     clr0  $e8
0fd8: 10 fc     bpl   $0fd6
0fda: 10 d6     bpl   $0fb2
0fdc: 10 bd     bpl   $0f9b
0fde: 10 a3     bpl   $0f83
0fe0: 10 89     bpl   $0f6b
0fe2: 10 c8     bpl   $0fac
0fe4: 14 10     or    a,$10+x
0fe6: 11        tcall 1
0fe7: 68 10     cmp   a,#$10
0fe9: 4d        push  x
0fea: 10 32     bpl   $101e
0fec: 10 0b     bpl   $0ff9
0fee: 10 f3     bpl   $0fe3
0ff0: 0f        brk
0ff1: fe 0f     dbnz  y,$1002
0ff3: ce        pop   x
0ff4: f5 6a 21  mov   a,$216a+x
0ff7: 04 34     or    a,$34
0ff9: c4 34     mov   $34,a
0ffb: 5f 4f 0f  jmp   $0f4f
0ffe: ce        pop   x
0fff: f5 6a 21  mov   a,$216a+x
1002: 48 ff     eor   a,#$ff
1004: 24 34     and   a,$34
1006: c4 34     mov   $34,a
1008: 5f 4f 0f  jmp   $0f4f
100b: f7 02     mov   a,($02)+y
100d: fc        inc   y
100e: 60        clrc
100f: 84 12     adc   a,$12
1011: 5d        mov   x,a
1012: e4 6c     mov   a,$6c
1014: 1c        asl   a
1015: 1c        asl   a
1016: 80        setc
1017: 84 6c     adc   a,$6c
1019: c4 6c     mov   $6c,a
101b: 0d        push  psw
101c: d5 77 05  mov   $0577+x,a
101f: ae        pop   a
1020: ce        pop   x
1021: 28 83     and   a,#$83
1023: c4 04     mov   $04,a
1025: f5 6f 05  mov   a,$056f+x
1028: 28 7c     and   a,#$7c
102a: 04 04     or    a,$04
102c: d5 6f 05  mov   $056f+x,a
102f: 5f 4f 0f  jmp   $0f4f
1032: ce        pop   x
1033: 4d        push  x
1034: f5 6f 05  mov   a,$056f+x
1037: 2d        push  a
1038: f7 02     mov   a,($02)+y
103a: fc        inc   y
103b: 60        clrc
103c: 84 12     adc   a,$12
103e: 5d        mov   x,a
103f: f5 77 05  mov   a,$0577+x
1042: 8e        pop   psw
1043: 3c        rol   a
1044: 0d        push  psw
1045: d5 77 05  mov   $0577+x,a
1048: ae        pop   a
1049: ce        pop   x
104a: 5f 21 10  jmp   $1021
104d: ce        pop   x
104e: 4d        push  x
104f: f5 6f 05  mov   a,$056f+x
1052: 2d        push  a
1053: f7 02     mov   a,($02)+y
1055: fc        inc   y
1056: 60        clrc
1057: 84 12     adc   a,$12
1059: 5d        mov   x,a
105a: f5 77 05  mov   a,$0577+x
105d: 8e        pop   psw
105e: 7c        ror   a
105f: 0d        push  psw
1060: d5 77 05  mov   $0577+x,a
1063: ae        pop   a
1064: ce        pop   x
1065: 5f 21 10  jmp   $1021
1068: f7 02     mov   a,($02)+y
106a: fc        inc   y
106b: 60        clrc
106c: 84 12     adc   a,$12
106e: 5d        mov   x,a
106f: f5 77 05  mov   a,$0577+x
1072: 37 02     and   a,($02)+y
1074: 0d        push  psw
1075: fc        inc   y
1076: ae        pop   a
1077: ce        pop   x
1078: 28 82     and   a,#$82
107a: c4 04     mov   $04,a
107c: f5 6f 05  mov   a,$056f+x
107f: 28 7d     and   a,#$7d
1081: 04 04     or    a,$04
1083: d5 6f 05  mov   $056f+x,a
1086: 5f 4f 0f  jmp   $0f4f
1089: f7 02     mov   a,($02)+y
108b: fc        inc   y
108c: c4 04     mov   $04,a
108e: f7 02     mov   a,($02)+y
1090: fc        inc   y
1091: 60        clrc
1092: 84 12     adc   a,$12
1094: 5d        mov   x,a
1095: f5 77 05  mov   a,$0577+x
1098: 0d        push  psw
1099: f8 04     mov   x,$04
109b: d5 bf 05  mov   $05bf+x,a
109e: ae        pop   a
109f: ce        pop   x
10a0: 5f 78 10  jmp   $1078
10a3: f7 02     mov   a,($02)+y
10a5: fc        inc   y
10a6: 60        clrc
10a7: 84 12     adc   a,$12
10a9: c4 04     mov   $04,a
10ab: f7 02     mov   a,($02)+y
10ad: fc        inc   y
10ae: 5d        mov   x,a
10af: f5 bf 05  mov   a,$05bf+x
10b2: 0d        push  psw
10b3: f8 04     mov   x,$04
10b5: d5 77 05  mov   $0577+x,a
10b8: ae        pop   a
10b9: ce        pop   x
10ba: 5f 78 10  jmp   $1078
10bd: f7 02     mov   a,($02)+y
10bf: fc        inc   y
10c0: 60        clrc
10c1: 5d        mov   x,a
10c2: e4 1d     mov   a,$1d
10c4: 0d        push  psw
10c5: d5 bf 05  mov   $05bf+x,a
10c8: e4 1e     mov   a,$1e
10ca: d5 c0 05  mov   $05c0+x,a
10cd: 28 7f     and   a,#$7f
10cf: c4 1e     mov   $1e,a
10d1: ae        pop   a
10d2: ce        pop   x
10d3: 5f 78 10  jmp   $1078
10d6: ce        pop   x
10d7: d8 06     mov   $06,x
10d9: f7 02     mov   a,($02)+y
10db: fc        inc   y
10dc: 28 7f     and   a,#$7f
10de: 4d        push  x
10df: 6d        push  y
10e0: 3f 71 0e  call  $0e71
10e3: ee        pop   y
10e4: ce        pop   x
10e5: 5f 4f 0f  jmp   $0f4f
10e8: f7 02     mov   a,($02)+y
10ea: fc        inc   y
10eb: 60        clrc
10ec: 84 12     adc   a,$12
10ee: 5d        mov   x,a
10ef: f5 77 05  mov   a,$0577+x
10f2: 1c        asl   a
10f3: 0d        push  psw
10f4: d5 77 05  mov   $0577+x,a
10f7: ae        pop   a
10f8: ce        pop   x
10f9: 5f 21 10  jmp   $1021
10fc: f7 02     mov   a,($02)+y
10fe: fc        inc   y
10ff: 60        clrc
1100: 84 12     adc   a,$12
1102: 5d        mov   x,a
1103: f5 77 05  mov   a,$0577+x
1106: 5c        lsr   a
1107: 0d        push  psw
1108: d5 77 05  mov   $0577+x,a
110b: ae        pop   a
110c: ce        pop   x
110d: 5f 21 10  jmp   $1021
1110: f7 02     mov   a,($02)+y
1112: fc        inc   y
1113: 60        clrc
1114: 84 12     adc   a,$12
1116: 5d        mov   x,a
1117: f5 77 05  mov   a,$0577+x
111a: 68 80     cmp   a,#$80
111c: 7c        ror   a
111d: 0d        push  psw
111e: d5 77 05  mov   $0577+x,a
1121: ae        pop   a
1122: ce        pop   x
1123: 5f 21 10  jmp   $1021
1126: e8 02     mov   a,#$02
1128: 04 00     or    a,$00
112a: c4 f2     mov   $f2,a
112c: f7 02     mov   a,($02)+y
112e: fc        inc   y
112f: 60        clrc
1130: 84 12     adc   a,$12
1132: 5d        mov   x,a
1133: f5 78 05  mov   a,$0578+x
1136: c4 04     mov   $04,a
1138: f5 77 05  mov   a,$0577+x
113b: ce        pop   x
113c: d5 9f 04  mov   $049f+x,a
113f: d5 af 04  mov   $04af+x,a
1142: c4 f3     mov   DSP_DATA,a
1144: ab f2     inc   $f2
1146: e4 04     mov   a,$04
1148: d5 a7 04  mov   $04a7+x,a
114b: d5 b7 04  mov   $04b7+x,a
114e: c4 f3     mov   DSP_DATA,a
1150: 5f 4f 0f  jmp   $0f4f
1153: e8 03     mov   a,#$03
1155: 04 00     or    a,$00
1157: c4 f2     mov   $f2,a
1159: f7 02     mov   a,($02)+y
115b: fc        inc   y
115c: 60        clrc
115d: 84 12     adc   a,$12
115f: 5d        mov   x,a
1160: f5 78 05  mov   a,$0578+x
1163: c4 04     mov   $04,a
1165: f5 77 05  mov   a,$0577+x
1168: ce        pop   x
1169: 60        clrc
116a: 95 9f 04  adc   a,$049f+x
116d: d5 9f 04  mov   $049f+x,a
1170: d5 af 04  mov   $04af+x,a
1173: 2d        push  a
1174: e4 04     mov   a,$04
1176: 95 a7 04  adc   a,$04a7+x
1179: d5 a7 04  mov   $04a7+x,a
117c: d5 b7 04  mov   $04b7+x,a
117f: c4 f3     mov   DSP_DATA,a
1181: 8b f2     dec   $f2
1183: ae        pop   a
1184: c4 f3     mov   DSP_DATA,a
1186: 5f 4f 0f  jmp   $0f4f
1189: e8 03     mov   a,#$03
118b: 04 00     or    a,$00
118d: c4 f2     mov   $f2,a
118f: f7 02     mov   a,($02)+y
1191: fc        inc   y
1192: 60        clrc
1193: 84 12     adc   a,$12
1195: 5d        mov   x,a
1196: f5 78 05  mov   a,$0578+x
1199: c4 04     mov   $04,a
119b: f5 77 05  mov   a,$0577+x
119e: ce        pop   x
119f: 60        clrc
11a0: 95 af 04  adc   a,$04af+x
11a3: d5 af 04  mov   $04af+x,a
11a6: 2d        push  a
11a7: e4 04     mov   a,$04
11a9: 95 b7 04  adc   a,$04b7+x
11ac: d5 b7 04  mov   $04b7+x,a
11af: c4 f3     mov   DSP_DATA,a
11b1: ae        pop   a
11b2: 8b f2     dec   $f2
11b4: c4 f3     mov   DSP_DATA,a
11b6: 5f 4f 0f  jmp   $0f4f
11b9: f7 02     mov   a,($02)+y
11bb: fc        inc   y
11bc: 60        clrc
11bd: 84 12     adc   a,$12
11bf: 5d        mov   x,a
11c0: f5 78 05  mov   a,$0578+x
11c3: c4 04     mov   $04,a
11c5: f5 77 05  mov   a,$0577+x
11c8: ce        pop   x
11c9: d5 bf 04  mov   $04bf+x,a
11cc: d5 cf 04  mov   $04cf+x,a
11cf: c4 06     mov   $06,a
11d1: e4 04     mov   a,$04
11d3: d5 c7 04  mov   $04c7+x,a
11d6: d5 d7 04  mov   $04d7+x,a
11d9: c4 07     mov   $07,a
11db: 3f 6e 18  call  $186e
11de: 5f 4f 0f  jmp   $0f4f
11e1: f7 02     mov   a,($02)+y
11e3: fc        inc   y
11e4: 60        clrc
11e5: 84 12     adc   a,$12
11e7: 5d        mov   x,a
11e8: f5 78 05  mov   a,$0578+x
11eb: c4 04     mov   $04,a
11ed: f5 77 05  mov   a,$0577+x
11f0: ce        pop   x
11f1: 60        clrc
11f2: 95 bf 04  adc   a,$04bf+x
11f5: d5 bf 04  mov   $04bf+x,a
11f8: d5 cf 04  mov   $04cf+x,a
11fb: c4 06     mov   $06,a
11fd: e4 04     mov   a,$04
11ff: 60        clrc
1200: 95 c7 04  adc   a,$04c7+x
1203: d5 c7 04  mov   $04c7+x,a
1206: d5 d7 04  mov   $04d7+x,a
1209: c4 07     mov   $07,a
120b: 3f 6e 18  call  $186e
120e: 5f 4f 0f  jmp   $0f4f
1211: f7 02     mov   a,($02)+y
1213: fc        inc   y
1214: 60        clrc
1215: 84 12     adc   a,$12
1217: 5d        mov   x,a
1218: f5 78 05  mov   a,$0578+x
121b: c4 04     mov   $04,a
121d: f5 77 05  mov   a,$0577+x
1220: ce        pop   x
1221: 60        clrc
1222: 95 cf 04  adc   a,$04cf+x
1225: d5 cf 04  mov   $04cf+x,a
1228: c4 06     mov   $06,a
122a: e4 04     mov   a,$04
122c: 60        clrc
122d: 95 d7 04  adc   a,$04d7+x
1230: d5 d7 04  mov   $04d7+x,a
1233: c4 07     mov   $07,a
1235: 3f 6e 18  call  $186e
1238: 5f 4f 0f  jmp   $0f4f
123b: ce        pop   x
123c: f5 67 05  mov   a,$0567+x
123f: d0 16     bne   $1257
1241: 4d        push  x
1242: f7 02     mov   a,($02)+y
1244: 60        clrc
1245: 84 12     adc   a,$12
1247: 5d        mov   x,a
1248: f5 77 05  mov   a,$0577+x
124b: d0 02     bne   $124f
124d: e8 01     mov   a,#$01
124f: ce        pop   x
1250: d5 67 05  mov   $0567+x,a
1253: dc        dec   y
1254: 5f 33 18  jmp   $1833
1257: dc        dec   y
1258: 9c        dec   a
1259: d5 67 05  mov   $0567+x,a
125c: f0 03     beq   $1261
125e: 5f 33 18  jmp   $1833
1261: fc        inc   y
1262: fc        inc   y
1263: 5f 4f 0f  jmp   $0f4f
1266: f7 02     mov   a,($02)+y
1268: fc        inc   y
1269: 60        clrc
126a: 84 12     adc   a,$12
126c: 5d        mov   x,a
126d: 8f 6c f2  mov   $f2,#$6c
1270: e4 f3     mov   a,DSP_DATA
1272: 28 e0     and   a,#$e0
1274: c4 04     mov   $04,a
1276: f5 77 05  mov   a,$0577+x
1279: 28 1f     and   a,#$1f
127b: 04 04     or    a,$04
127d: c4 f3     mov   DSP_DATA,a
127f: ce        pop   x
1280: 5f 4f 0f  jmp   $0f4f
1283: ce        pop   x
1284: 8f 6c f2  mov   $f2,#$6c
1287: e4 f3     mov   a,DSP_DATA
1289: 28 e0     and   a,#$e0
128b: 17 02     or    a,($02)+y
128d: fc        inc   y
128e: c4 f3     mov   DSP_DATA,a
1290: 5f 4f 0f  jmp   $0f4f
1293: ce        pop   x
1294: e8 02     mov   a,#$02
1296: 04 00     or    a,$00
1298: c4 f2     mov   $f2,a
129a: f7 02     mov   a,($02)+y
129c: fc        inc   y
129d: d5 9f 04  mov   $049f+x,a
12a0: d5 af 04  mov   $04af+x,a
12a3: c4 f3     mov   DSP_DATA,a
12a5: ab f2     inc   $f2
12a7: f7 02     mov   a,($02)+y
12a9: fc        inc   y
12aa: d5 a7 04  mov   $04a7+x,a
12ad: d5 b7 04  mov   $04b7+x,a
12b0: c4 f3     mov   DSP_DATA,a
12b2: 5f 4f 0f  jmp   $0f4f
12b5: ce        pop   x
12b6: e8 03     mov   a,#$03
12b8: 04 00     or    a,$00
12ba: c4 f2     mov   $f2,a
12bc: f7 02     mov   a,($02)+y
12be: fc        inc   y
12bf: 60        clrc
12c0: 95 9f 04  adc   a,$049f+x
12c3: d5 9f 04  mov   $049f+x,a
12c6: d5 af 04  mov   $04af+x,a
12c9: 2d        push  a
12ca: f7 02     mov   a,($02)+y
12cc: 95 a7 04  adc   a,$04a7+x
12cf: d5 a7 04  mov   $04a7+x,a
12d2: d5 b7 04  mov   $04b7+x,a
12d5: fc        inc   y
12d6: c4 f3     mov   DSP_DATA,a
12d8: 8b f2     dec   $f2
12da: ae        pop   a
12db: c4 f3     mov   DSP_DATA,a
12dd: 5f 4f 0f  jmp   $0f4f
12e0: ce        pop   x
12e1: e8 03     mov   a,#$03
12e3: 04 00     or    a,$00
12e5: c4 f2     mov   $f2,a
12e7: f7 02     mov   a,($02)+y
12e9: fc        inc   y
12ea: 60        clrc
12eb: 95 af 04  adc   a,$04af+x
12ee: d5 af 04  mov   $04af+x,a
12f1: 2d        push  a
12f2: f7 02     mov   a,($02)+y
12f4: 95 b7 04  adc   a,$04b7+x
12f7: d5 b7 04  mov   $04b7+x,a
12fa: c4 f3     mov   DSP_DATA,a
12fc: fc        inc   y
12fd: ae        pop   a
12fe: 8b f2     dec   $f2
1300: c4 f3     mov   DSP_DATA,a
1302: 5f 4f 0f  jmp   $0f4f
1305: ce        pop   x
1306: f5 5f 05  mov   a,$055f+x
1309: bc        inc   a
130a: d5 5f 05  mov   $055f+x,a
130d: 4d        push  x
130e: d8 01     mov   $01,x
1310: 9c        dec   a
1311: 1c        asl   a
1312: 1c        asl   a
1313: 1c        asl   a
1314: 04 01     or    a,$01
1316: 5d        mov   x,a
1317: f7 02     mov   a,($02)+y
1319: fc        inc   y
131a: d5 1f 05  mov   $051f+x,a
131d: f7 02     mov   a,($02)+y
131f: fc        inc   y
1320: d5 3f 05  mov   $053f+x,a
1323: dd        mov   a,y
1324: 60        clrc
1325: 84 02     adc   a,$02
1327: d5 df 04  mov   $04df+x,a
132a: e8 00     mov   a,#$00
132c: 84 03     adc   a,$03
132e: d5 ff 04  mov   $04ff+x,a
1331: ce        pop   x
1332: 5f 4f 0f  jmp   $0f4f
1335: ce        pop   x
1336: 4d        push  x
1337: f5 5f 05  mov   a,$055f+x
133a: 9c        dec   a
133b: d8 01     mov   $01,x
133d: 1c        asl   a
133e: 1c        asl   a
133f: 1c        asl   a
1340: 04 01     or    a,$01
1342: 5d        mov   x,a
1343: f5 1f 05  mov   a,$051f+x
1346: 15 3f 05  or    a,$053f+x
1349: f0 21     beq   $136c
134b: 80        setc
134c: f5 1f 05  mov   a,$051f+x
134f: a8 01     sbc   a,#$01
1351: d5 1f 05  mov   $051f+x,a
1354: f5 3f 05  mov   a,$053f+x
1357: a8 00     sbc   a,#$00
1359: d5 3f 05  mov   $053f+x,a
135c: f5 df 04  mov   a,$04df+x
135f: c4 02     mov   $02,a
1361: f5 ff 04  mov   a,$04ff+x
1364: c4 03     mov   $03,a
1366: 8d 00     mov   y,#$00
1368: ce        pop   x
1369: 5f 33 18  jmp   $1833
136c: ce        pop   x
136d: f5 5f 05  mov   a,$055f+x
1370: 9c        dec   a
1371: d5 5f 05  mov   $055f+x,a
1374: 5f 33 18  jmp   $1833
1377: ce        pop   x
1378: f7 02     mov   a,($02)+y
137a: fc        inc   y
137b: c4 04     mov   $04,a
137d: f7 02     mov   a,($02)+y
137f: c4 05     mov   $05,a
1381: 6d        push  y
1382: ba 02     movw  ya,$02
1384: 7a 04     addw  ya,$04
1386: da 04     movw  $04,ya
1388: ae        pop   a
1389: 80        setc
138a: 84 04     adc   a,$04
138c: c4 02     mov   $02,a
138e: e8 00     mov   a,#$00
1390: 84 05     adc   a,$05
1392: c4 03     mov   $03,a
1394: 8d 00     mov   y,#$00
1396: 5f 4f 0f  jmp   $0f4f
1399: ce        pop   x
139a: f7 02     mov   a,($02)+y
139c: fc        inc   y
139d: d5 bf 04  mov   $04bf+x,a
13a0: d5 cf 04  mov   $04cf+x,a
13a3: c4 06     mov   $06,a
13a5: f7 02     mov   a,($02)+y
13a7: fc        inc   y
13a8: d5 c7 04  mov   $04c7+x,a
13ab: d5 d7 04  mov   $04d7+x,a
13ae: c4 07     mov   $07,a
13b0: 3f 6e 18  call  $186e
13b3: 5f 4f 0f  jmp   $0f4f
13b6: ce        pop   x
13b7: f7 02     mov   a,($02)+y
13b9: fc        inc   y
13ba: 60        clrc
13bb: 95 bf 04  adc   a,$04bf+x
13be: d5 bf 04  mov   $04bf+x,a
13c1: d5 cf 04  mov   $04cf+x,a
13c4: c4 06     mov   $06,a
13c6: f7 02     mov   a,($02)+y
13c8: fc        inc   y
13c9: 60        clrc
13ca: 95 c7 04  adc   a,$04c7+x
13cd: d5 c7 04  mov   $04c7+x,a
13d0: d5 d7 04  mov   $04d7+x,a
13d3: c4 07     mov   $07,a
13d5: 3f 6e 18  call  $186e
13d8: 5f 4f 0f  jmp   $0f4f
13db: ce        pop   x
13dc: f7 02     mov   a,($02)+y
13de: fc        inc   y
13df: 60        clrc
13e0: 95 cf 04  adc   a,$04cf+x
13e3: d5 cf 04  mov   $04cf+x,a
13e6: c4 06     mov   $06,a
13e8: ab f2     inc   $f2
13ea: f7 02     mov   a,($02)+y
13ec: fc        inc   y
13ed: 60        clrc
13ee: 95 d7 04  adc   a,$04d7+x
13f1: d5 d7 04  mov   $04d7+x,a
13f4: c4 07     mov   $07,a
13f6: 3f 6e 18  call  $186e
13f9: 5f 4f 0f  jmp   $0f4f
13fc: ce        pop   x
13fd: e8 06     mov   a,#$06
13ff: 04 00     or    a,$00
1401: c4 f2     mov   $f2,a
1403: f7 02     mov   a,($02)+y
1405: fc        inc   y
1406: c4 f3     mov   DSP_DATA,a
1408: 8b f2     dec   $f2
140a: f7 02     mov   a,($02)+y
140c: fc        inc   y
140d: c4 f3     mov   DSP_DATA,a
140f: 5f 4f 0f  jmp   $0f4f
1412: ce        pop   x
1413: e8 07     mov   a,#$07
1415: 04 00     or    a,$00
1417: c4 f2     mov   $f2,a
1419: f7 02     mov   a,($02)+y
141b: fc        inc   y
141c: c4 f3     mov   DSP_DATA,a
141e: 5f 4f 0f  jmp   $0f4f
1421: ce        pop   x
1422: e8 04     mov   a,#$04
1424: 04 00     or    a,$00
1426: c4 f2     mov   $f2,a
1428: e4 12     mov   a,$12
142a: 2d        push  a
142b: f7 02     mov   a,($02)+y
142d: fc        inc   y
142e: 6d        push  y
142f: 3f 06 0e  call  $0e06
1432: 8d 0c     mov   y,#$0c
1434: f7 12     mov   a,($12)+y
1436: fd        mov   y,a
1437: f6 40 e0  mov   a,$e040+y
143a: c4 f3     mov   DSP_DATA,a
143c: ee        pop   y
143d: ae        pop   a
143e: c4 12     mov   $12,a
1440: 5f 4f 0f  jmp   $0f4f
1443: ce        pop   x
1444: 8f 2d f2  mov   $f2,#$2d
1447: f5 6a 21  mov   a,$216a+x
144a: 04 f3     or    a,DSP_DATA
144c: c4 f3     mov   DSP_DATA,a
144e: 5f 4f 0f  jmp   $0f4f
1451: ce        pop   x
1452: f5 6a 21  mov   a,$216a+x
1455: 2d        push  a
1456: 04 31     or    a,$31
1458: c4 31     mov   $31,a
145a: ae        pop   a
145b: 04 32     or    a,$32
145d: c4 32     mov   $32,a
145f: 5f 4f 0f  jmp   $0f4f
1462: ce        pop   x
1463: f5 6a 21  mov   a,$216a+x
1466: 04 32     or    a,$32
1468: c4 32     mov   $32,a
146a: 7d        mov   a,x
146b: 9f        xcn   a
146c: 08 05     or    a,#$05
146e: c4 f2     mov   $f2,a
1470: 8f 00 f3  mov   DSP_DATA,#$00
1473: 5f 4f 0f  jmp   $0f4f
1476: ce        pop   x
1477: f7 02     mov   a,($02)+y
1479: fc        inc   y
147a: c4 f2     mov   $f2,a
147c: f7 02     mov   a,($02)+y
147e: fc        inc   y
147f: c4 f3     mov   DSP_DATA,a
1481: 5f 4f 0f  jmp   $0f4f
1484: ce        pop   x
1485: f7 02     mov   a,($02)+y
1487: fc        inc   y
1488: c4 f2     mov   $f2,a
148a: f7 02     mov   a,($02)+y
148c: fc        inc   y
148d: 60        clrc
148e: 84 f3     adc   a,DSP_DATA
1490: c4 f3     mov   DSP_DATA,a
1492: 5f 4f 0f  jmp   $0f4f
1495: ce        pop   x
1496: f5 67 05  mov   a,$0567+x
1499: f0 03     beq   $149e
149b: 5f ab 14  jmp   $14ab
149e: f7 02     mov   a,($02)+y
14a0: d0 02     bne   $14a4
14a2: e8 01     mov   a,#$01
14a4: d5 67 05  mov   $0567+x,a
14a7: dc        dec   y
14a8: 5f 33 18  jmp   $1833
14ab: dc        dec   y
14ac: 9c        dec   a
14ad: d5 67 05  mov   $0567+x,a
14b0: f0 03     beq   $14b5
14b2: 5f 33 18  jmp   $1833
14b5: fc        inc   y
14b6: fc        inc   y
14b7: 5f 4f 0f  jmp   $0f4f
14ba: ce        pop   x
14bb: 8f 3d f2  mov   $f2,#$3d
14be: f5 6a 21  mov   a,$216a+x
14c1: 04 f3     or    a,DSP_DATA
14c3: c4 f3     mov   DSP_DATA,a
14c5: 5f 4f 0f  jmp   $0f4f
14c8: ce        pop   x
14c9: 8f 3d f2  mov   $f2,#$3d
14cc: f5 6a 21  mov   a,$216a+x
14cf: 48 ff     eor   a,#$ff
14d1: 24 f3     and   a,DSP_DATA
14d3: c4 f3     mov   DSP_DATA,a
14d5: 5f 4f 0f  jmp   $0f4f
14d8: f7 02     mov   a,($02)+y
14da: fc        inc   y
14db: 60        clrc
14dc: 84 12     adc   a,$12
14de: 5d        mov   x,a
14df: e4 1d     mov   a,$1d
14e1: 0d        push  psw
14e2: d5 77 05  mov   $0577+x,a
14e5: e4 1e     mov   a,$1e
14e7: d5 78 05  mov   $0578+x,a
14ea: 28 7f     and   a,#$7f
14ec: c4 1e     mov   $1e,a
14ee: ae        pop   a
14ef: ce        pop   x
14f0: 5f 78 10  jmp   $1078
14f3: f7 02     mov   a,($02)+y
14f5: fc        inc   y
14f6: 60        clrc
14f7: 84 12     adc   a,$12
14f9: 5d        mov   x,a
14fa: f7 02     mov   a,($02)+y
14fc: fc        inc   y
14fd: 60        clrc
14fe: 95 77 05  adc   a,$0577+x
1501: 0d        push  psw
1502: d5 77 05  mov   $0577+x,a
1505: ae        pop   a
1506: ce        pop   x
1507: 28 cb     and   a,#$cb
1509: c4 04     mov   $04,a
150b: f5 6f 05  mov   a,$056f+x
150e: 28 34     and   a,#$34
1510: 04 04     or    a,$04
1512: d5 6f 05  mov   $056f+x,a
1515: 5f 4f 0f  jmp   $0f4f
1518: f7 02     mov   a,($02)+y
151a: fc        inc   y
151b: 60        clrc
151c: 84 12     adc   a,$12
151e: 5d        mov   x,a
151f: 80        setc
1520: f5 77 05  mov   a,$0577+x
1523: b7 02     sbc   a,($02)+y
1525: 0d        push  psw
1526: fc        inc   y
1527: d5 77 05  mov   $0577+x,a
152a: ae        pop   a
152b: ce        pop   x
152c: 28 cb     and   a,#$cb
152e: c4 04     mov   $04,a
1530: f5 6f 05  mov   a,$056f+x
1533: 28 34     and   a,#$34
1535: 04 04     or    a,$04
1537: d5 6f 05  mov   $056f+x,a
153a: 5f 4f 0f  jmp   $0f4f
153d: f7 02     mov   a,($02)+y
153f: fc        inc   y
1540: 60        clrc
1541: 84 12     adc   a,$12
1543: 5d        mov   x,a
1544: f7 02     mov   a,($02)+y
1546: fc        inc   y
1547: 6d        push  y
1548: fd        mov   y,a
1549: f5 77 05  mov   a,$0577+x
154c: cf        mul   ya
154d: 0d        push  psw
154e: d5 77 05  mov   $0577+x,a
1551: dd        mov   a,y
1552: d5 78 05  mov   $0578+x,a
1555: ae        pop   a
1556: ee        pop   y
1557: ce        pop   x
1558: 5f 78 10  jmp   $1078
155b: f7 02     mov   a,($02)+y
155d: fc        inc   y
155e: 60        clrc
155f: 84 12     adc   a,$12
1561: 5d        mov   x,a
1562: f7 02     mov   a,($02)+y
1564: fc        inc   y
1565: 6d        push  y
1566: 2d        push  a
1567: f5 78 05  mov   a,$0578+x
156a: fd        mov   y,a
156b: f5 77 05  mov   a,$0577+x
156e: d8 04     mov   $04,x
1570: ce        pop   x
1571: 9e        div   ya,x
1572: 0d        push  psw
1573: f8 04     mov   x,$04
1575: d5 77 05  mov   $0577+x,a
1578: dd        mov   a,y
1579: d5 78 05  mov   $0578+x,a
157c: ae        pop   a
157d: ee        pop   y
157e: ce        pop   x
157f: 28 ca     and   a,#$ca
1581: c4 04     mov   $04,a
1583: f5 6f 05  mov   a,$056f+x
1586: 28 35     and   a,#$35
1588: 04 04     or    a,$04
158a: d5 6f 05  mov   $056f+x,a
158d: 5f 4f 0f  jmp   $0f4f
1590: f7 02     mov   a,($02)+y
1592: fc        inc   y
1593: 60        clrc
1594: 84 12     adc   a,$12
1596: 5d        mov   x,a
1597: f5 77 05  mov   a,$0577+x
159a: 48 ff     eor   a,#$ff
159c: 0d        push  psw
159d: d5 77 05  mov   $0577+x,a
15a0: ae        pop   a
15a1: ce        pop   x
15a2: 5f 78 10  jmp   $1078
15a5: f7 02     mov   a,($02)+y
15a7: fc        inc   y
15a8: 60        clrc
15a9: 84 12     adc   a,$12
15ab: 5d        mov   x,a
15ac: f5 77 05  mov   a,$0577+x
15af: 37 02     and   a,($02)+y
15b1: 0d        push  psw
15b2: fc        inc   y
15b3: d5 77 05  mov   $0577+x,a
15b6: ae        pop   a
15b7: ce        pop   x
15b8: 5f 78 10  jmp   $1078
15bb: f7 02     mov   a,($02)+y
15bd: fc        inc   y
15be: 60        clrc
15bf: 84 12     adc   a,$12
15c1: 5d        mov   x,a
15c2: f5 77 05  mov   a,$0577+x
15c5: 17 02     or    a,($02)+y
15c7: 0d        push  psw
15c8: fc        inc   y
15c9: d5 77 05  mov   $0577+x,a
15cc: ae        pop   a
15cd: ce        pop   x
15ce: 5f 78 10  jmp   $1078
15d1: f7 02     mov   a,($02)+y
15d3: fc        inc   y
15d4: 60        clrc
15d5: 84 12     adc   a,$12
15d7: 5d        mov   x,a
15d8: f5 77 05  mov   a,$0577+x
15db: 57 02     eor   a,($02)+y
15dd: 0d        push  psw
15de: fc        inc   y
15df: d5 77 05  mov   $0577+x,a
15e2: ae        pop   a
15e3: ce        pop   x
15e4: 5f 78 10  jmp   $1078
15e7: f7 02     mov   a,($02)+y
15e9: fc        inc   y
15ea: 60        clrc
15eb: 84 12     adc   a,$12
15ed: 5d        mov   x,a
15ee: f5 77 05  mov   a,$0577+x
15f1: bc        inc   a
15f2: 0d        push  psw
15f3: d5 77 05  mov   $0577+x,a
15f6: ae        pop   a
15f7: ce        pop   x
15f8: 5f 78 10  jmp   $1078
15fb: f7 02     mov   a,($02)+y
15fd: fc        inc   y
15fe: 60        clrc
15ff: 84 12     adc   a,$12
1601: 5d        mov   x,a
1602: f5 77 05  mov   a,$0577+x
1605: 9c        dec   a
1606: 0d        push  psw
1607: d5 77 05  mov   $0577+x,a
160a: ae        pop   a
160b: ce        pop   x
160c: 5f 78 10  jmp   $1078
160f: f7 02     mov   a,($02)+y
1611: fc        inc   y
1612: 60        clrc
1613: 84 12     adc   a,$12
1615: 5d        mov   x,a
1616: f5 77 05  mov   a,$0577+x
1619: 48 ff     eor   a,#$ff
161b: bc        inc   a
161c: 0d        push  psw
161d: d5 77 05  mov   $0577+x,a
1620: ae        pop   a
1621: ce        pop   x
1622: 5f 78 10  jmp   $1078
1625: f7 02     mov   a,($02)+y
1627: fc        inc   y
1628: 60        clrc
1629: 84 12     adc   a,$12
162b: 5d        mov   x,a
162c: f5 77 05  mov   a,$0577+x
162f: c4 04     mov   $04,a
1631: f7 02     mov   a,($02)+y
1633: fc        inc   y
1634: 60        clrc
1635: 84 12     adc   a,$12
1637: 5d        mov   x,a
1638: 60        clrc
1639: f5 77 05  mov   a,$0577+x
163c: 84 04     adc   a,$04
163e: 0d        push  psw
163f: d5 77 05  mov   $0577+x,a
1642: ae        pop   a
1643: ce        pop   x
1644: 28 cb     and   a,#$cb
1646: c4 04     mov   $04,a
1648: f5 6f 05  mov   a,$056f+x
164b: 28 34     and   a,#$34
164d: 04 04     or    a,$04
164f: d5 6f 05  mov   $056f+x,a
1652: 5f 4f 0f  jmp   $0f4f
1655: f7 02     mov   a,($02)+y
1657: fc        inc   y
1658: 60        clrc
1659: 84 12     adc   a,$12
165b: 5d        mov   x,a
165c: f5 77 05  mov   a,$0577+x
165f: c4 04     mov   $04,a
1661: f7 02     mov   a,($02)+y
1663: fc        inc   y
1664: 60        clrc
1665: 84 12     adc   a,$12
1667: 5d        mov   x,a
1668: 80        setc
1669: f5 77 05  mov   a,$0577+x
166c: a4 04     sbc   a,$04
166e: 0d        push  psw
166f: d5 77 05  mov   $0577+x,a
1672: ae        pop   a
1673: ce        pop   x
1674: 28 cb     and   a,#$cb
1676: c4 04     mov   $04,a
1678: f5 6f 05  mov   a,$056f+x
167b: 28 34     and   a,#$34
167d: 04 04     or    a,$04
167f: d5 6f 05  mov   $056f+x,a
1682: 5f 4f 0f  jmp   $0f4f
1685: f7 02     mov   a,($02)+y
1687: fc        inc   y
1688: 60        clrc
1689: 84 12     adc   a,$12
168b: 5d        mov   x,a
168c: f5 77 05  mov   a,$0577+x
168f: c4 04     mov   $04,a
1691: f7 02     mov   a,($02)+y
1693: fc        inc   y
1694: 60        clrc
1695: 84 12     adc   a,$12
1697: 5d        mov   x,a
1698: f5 77 05  mov   a,$0577+x
169b: 6d        push  y
169c: fd        mov   y,a
169d: e4 04     mov   a,$04
169f: cf        mul   ya
16a0: 0d        push  psw
16a1: d5 77 05  mov   $0577+x,a
16a4: dd        mov   a,y
16a5: d5 78 05  mov   $0578+x,a
16a8: ae        pop   a
16a9: ee        pop   y
16aa: ce        pop   x
16ab: 5f 78 10  jmp   $1078
16ae: f7 02     mov   a,($02)+y
16b0: fc        inc   y
16b1: 60        clrc
16b2: 84 12     adc   a,$12
16b4: 5d        mov   x,a
16b5: f7 02     mov   a,($02)+y
16b7: fc        inc   y
16b8: 6d        push  y
16b9: 60        clrc
16ba: 84 12     adc   a,$12
16bc: 2d        push  a
16bd: f5 78 05  mov   a,$0578+x
16c0: fd        mov   y,a
16c1: f5 77 05  mov   a,$0577+x
16c4: d8 04     mov   $04,x
16c6: ce        pop   x
16c7: 2d        push  a
16c8: f5 77 05  mov   a,$0577+x
16cb: 5d        mov   x,a
16cc: ae        pop   a
16cd: 9e        div   ya,x
16ce: 0d        push  psw
16cf: f8 04     mov   x,$04
16d1: d5 77 05  mov   $0577+x,a
16d4: dd        mov   a,y
16d5: d5 78 05  mov   $0578+x,a
16d8: ae        pop   a
16d9: ee        pop   y
16da: ce        pop   x
16db: 28 ca     and   a,#$ca
16dd: c4 04     mov   $04,a
16df: f5 6f 05  mov   a,$056f+x
16e2: 28 35     and   a,#$35
16e4: 04 04     or    a,$04
16e6: d5 6f 05  mov   $056f+x,a
16e9: 5f 4f 0f  jmp   $0f4f
16ec: f7 02     mov   a,($02)+y
16ee: fc        inc   y
16ef: 60        clrc
16f0: 84 12     adc   a,$12
16f2: 5d        mov   x,a
16f3: f5 77 05  mov   a,$0577+x
16f6: d8 05     mov   $05,x
16f8: c4 04     mov   $04,a
16fa: f7 02     mov   a,($02)+y
16fc: fc        inc   y
16fd: 60        clrc
16fe: 84 12     adc   a,$12
1700: 5d        mov   x,a
1701: f5 77 05  mov   a,$0577+x
1704: 24 04     and   a,$04
1706: 0d        push  psw
1707: f8 05     mov   x,$05
1709: d5 77 05  mov   $0577+x,a
170c: ae        pop   a
170d: ce        pop   x
170e: 5f 78 10  jmp   $1078
1711: f7 02     mov   a,($02)+y
1713: fc        inc   y
1714: 60        clrc
1715: 84 12     adc   a,$12
1717: 5d        mov   x,a
1718: f5 77 05  mov   a,$0577+x
171b: d8 05     mov   $05,x
171d: c4 04     mov   $04,a
171f: f7 02     mov   a,($02)+y
1721: fc        inc   y
1722: 60        clrc
1723: 84 12     adc   a,$12
1725: 5d        mov   x,a
1726: f5 77 05  mov   a,$0577+x
1729: 04 04     or    a,$04
172b: 0d        push  psw
172c: f8 05     mov   x,$05
172e: d5 77 05  mov   $0577+x,a
1731: ae        pop   a
1732: ce        pop   x
1733: 5f 78 10  jmp   $1078
1736: f7 02     mov   a,($02)+y
1738: fc        inc   y
1739: 60        clrc
173a: 84 12     adc   a,$12
173c: 5d        mov   x,a
173d: f5 77 05  mov   a,$0577+x
1740: d8 05     mov   $05,x
1742: c4 04     mov   $04,a
1744: f7 02     mov   a,($02)+y
1746: fc        inc   y
1747: 60        clrc
1748: 84 12     adc   a,$12
174a: 5d        mov   x,a
174b: f5 77 05  mov   a,$0577+x
174e: 44 04     eor   a,$04
1750: 0d        push  psw
1751: f8 05     mov   x,$05
1753: d5 77 05  mov   $0577+x,a
1756: ae        pop   a
1757: ce        pop   x
1758: 5f 78 10  jmp   $1078
175b: f7 02     mov   a,($02)+y
175d: fc        inc   y
175e: 60        clrc
175f: 84 12     adc   a,$12
1761: 5d        mov   x,a
1762: f5 77 05  mov   a,$0577+x
1765: 77 02     cmp   a,($02)+y
1767: 0d        push  psw
1768: fc        inc   y
1769: ae        pop   a
176a: ce        pop   x
176b: 5f 21 10  jmp   $1021
176e: f7 02     mov   a,($02)+y
1770: fc        inc   y
1771: 60        clrc
1772: 84 12     adc   a,$12
1774: 5d        mov   x,a
1775: f5 77 05  mov   a,$0577+x
1778: 2d        push  a
1779: f7 02     mov   a,($02)+y
177b: fc        inc   y
177c: 60        clrc
177d: 84 12     adc   a,$12
177f: 5d        mov   x,a
1780: ae        pop   a
1781: 75 77 05  cmp   a,$0577+x
1784: 0d        push  psw
1785: ae        pop   a
1786: ce        pop   x
1787: 5f 21 10  jmp   $1021
178a: ce        pop   x
178b: f5 6f 05  mov   a,$056f+x
178e: 2d        push  a
178f: 8e        pop   psw
1790: d0 03     bne   $1795
1792: 5f 78 13  jmp   $1378
1795: fc        inc   y
1796: fc        inc   y
1797: 5f 4f 0f  jmp   $0f4f
179a: ce        pop   x
179b: f5 6f 05  mov   a,$056f+x
179e: 2d        push  a
179f: 8e        pop   psw
17a0: f0 03     beq   $17a5
17a2: 5f 78 13  jmp   $1378
17a5: fc        inc   y
17a6: fc        inc   y
17a7: 5f 4f 0f  jmp   $0f4f
17aa: ce        pop   x
17ab: f5 6f 05  mov   a,$056f+x
17ae: 2d        push  a
17af: 8e        pop   psw
17b0: 30 03     bmi   $17b5
17b2: 5f 78 13  jmp   $1378
17b5: fc        inc   y
17b6: fc        inc   y
17b7: 5f 4f 0f  jmp   $0f4f
17ba: ce        pop   x
17bb: f5 6f 05  mov   a,$056f+x
17be: 2d        push  a
17bf: 8e        pop   psw
17c0: 10 03     bpl   $17c5
17c2: 5f 78 13  jmp   $1378
17c5: fc        inc   y
17c6: fc        inc   y
17c7: 5f 4f 0f  jmp   $0f4f
17ca: ce        pop   x
17cb: f5 6f 05  mov   a,$056f+x
17ce: 2d        push  a
17cf: 8e        pop   psw
17d0: b0 03     bcs   $17d5
17d2: 5f 78 13  jmp   $1378
17d5: fc        inc   y
17d6: fc        inc   y
17d7: 5f 4f 0f  jmp   $0f4f
17da: ce        pop   x
17db: f5 6f 05  mov   a,$056f+x
17de: 2d        push  a
17df: 8e        pop   psw
17e0: 90 03     bcc   $17e5
17e2: 5f 78 13  jmp   $1378
17e5: fc        inc   y
17e6: fc        inc   y
17e7: 5f 4f 0f  jmp   $0f4f
17ea: f7 02     mov   a,($02)+y
17ec: fc        inc   y
17ed: 60        clrc
17ee: 84 12     adc   a,$12
17f0: 5d        mov   x,a
17f1: f7 02     mov   a,($02)+y
17f3: 0d        push  psw
17f4: d5 77 05  mov   $0577+x,a
17f7: fc        inc   y
17f8: ae        pop   a
17f9: ce        pop   x
17fa: 5f 78 10  jmp   $1078
17fd: f7 02     mov   a,($02)+y
17ff: fc        inc   y
1800: 60        clrc
1801: 84 12     adc   a,$12
1803: c4 04     mov   $04,a
1805: f7 02     mov   a,($02)+y
1807: fc        inc   y
1808: 60        clrc
1809: 84 12     adc   a,$12
180b: 5d        mov   x,a
180c: f5 77 05  mov   a,$0577+x
180f: 0d        push  psw
1810: f8 04     mov   x,$04
1812: d5 77 05  mov   $0577+x,a
1815: ae        pop   a
1816: ce        pop   x
1817: 5f 78 10  jmp   $1078
181a: ce        pop   x
181b: 3f 44 18  call  $1844
181e: f5 6a 21  mov   a,$216a+x
1821: 48 ff     eor   a,#$ff
1823: 2d        push  a
1824: 24 30     and   a,$30
1826: c4 30     mov   $30,a
1828: ae        pop   a
1829: 24 34     and   a,$34
182b: c4 34     mov   $34,a
182d: e8 00     mov   a,#$00
182f: d4 20     mov   $20+x,a
1831: d4 28     mov   $28+x,a
1833: dd        mov   a,y
1834: 8d 00     mov   y,#$00
1836: 7a 02     addw  ya,$02
1838: da 02     movw  $02,ya
183a: d5 8f 04  mov   $048f+x,a
183d: dd        mov   a,y
183e: d5 97 04  mov   $0497+x,a
1841: ce        pop   x
1842: ae        pop   a
1843: 6f        ret
1844: 8f 2d f2  mov   $f2,#$2d
1847: f5 6a 21  mov   a,$216a+x
184a: 48 ff     eor   a,#$ff
184c: 2d        push  a
184d: 24 f3     and   a,DSP_DATA
184f: c4 f3     mov   DSP_DATA,a
1851: ae        pop   a
1852: 8f 3d f2  mov   $f2,#$3d
1855: 24 f3     and   a,DSP_DATA
1857: c4 f3     mov   DSP_DATA,a
1859: 6f        ret
185a: ba f6     movw  ya,PORT2
185c: dd        mov   a,y
185d: 44 1c     eor   a,$1c
185f: 10 0c     bpl   $186d
1861: ba f6     movw  ya,PORT2
1863: da 1b     movw  $1b,ya
1865: da f6     movw  PORT2,ya
1867: da 1d     movw  $1d,ya
1869: 18 80 1e  or    $1e,#$80
186c: 6f        ret
186d: 6f        ret
186e: 6d        push  y
186f: e4 65     mov   a,$65
1871: f0 1a     beq   $188d
1873: e4 06     mov   a,$06
1875: 10 03     bpl   $187a
1877: 48 ff     eor   a,#$ff
1879: bc        inc   a
187a: c4 06     mov   $06,a
187c: e4 07     mov   a,$07
187e: 10 03     bpl   $1883
1880: 48 ff     eor   a,#$ff
1882: bc        inc   a
1883: c4 07     mov   $07,a
1885: 60        clrc
1886: 84 06     adc   a,$06
1888: 5c        lsr   a
1889: c4 06     mov   $06,a
188b: c4 07     mov   $07,a
188d: eb 69     mov   y,$69
188f: e4 06     mov   a,$06
1891: cf        mul   ya
1892: cb 06     mov   $06,y
1894: eb 69     mov   y,$69
1896: e4 07     mov   a,$07
1898: cf        mul   ya
1899: cb 07     mov   $07,y
189b: e8 00     mov   a,#$00
189d: 04 00     or    a,$00
189f: c4 f2     mov   $f2,a
18a1: fa 06 f3  mov   ($f3),($06)
18a4: ab f2     inc   $f2
18a6: fa 07 f3  mov   ($f3),($07)
18a9: ee        pop   y
18aa: 6f        ret
18ab: f5 55 02  mov   a,$0255+x
18ae: f0 0c     beq   $18bc
18b0: c4 00     mov   $00,a
18b2: e8 00     mov   a,#$00
18b4: d5 55 02  mov   $0255+x,a
18b7: e4 00     mov   a,$00
18b9: 5f c1 18  jmp   $18c1
18bc: 3f a8 1b  call  $1ba8
18bf: c4 00     mov   $00,a
18c1: 5c        lsr   a
18c2: 9f        xcn   a
18c3: 28 07     and   a,#$07
18c5: 1c        asl   a
18c6: 4d        push  x
18c7: 5d        mov   x,a
18c8: 1f cb 18  jmp   ($18cb+x)
18cb: db 18     mov   $18+x,y
18cd: 02 19     set0  $19
18cf: 1f 19 2c  jmp   ($2c19+x)
18d2: 19        or    (x),(y)
18d3: 3b 19     rol   $19+x
18d5: 5d        mov   x,a
18d6: 19        or    (x),(y)
18d7: 7d        mov   a,x
18d8: 19        or    (x),(y)
18d9: 4c 19 ce  lsr   $ce19
18dc: e4 00     mov   a,$00
18de: 28 1f     and   a,#$1f
18e0: 68 10     cmp   a,#$10
18e2: 90 02     bcc   $18e6
18e4: 08 e0     or    a,#$e0
18e6: 60        clrc
18e7: 95 85 02  adc   a,$0285+x
18ea: d5 85 02  mov   $0285+x,a
18ed: c4 02     mov   $02,a
18ef: f5 35 02  mov   a,$0235+x
18f2: c4 00     mov   $00,a
18f4: 4d        push  x
18f5: 3f 94 0a  call  $0a94
18f8: ce        pop   x
18f9: f5 65 02  mov   a,$0265+x
18fc: c4 04     mov   $04,a
18fe: 3f b6 1c  call  $1cb6
1901: 6f        ret
1902: ce        pop   x
1903: e4 00     mov   a,$00
1905: 28 1f     and   a,#$1f
1907: 68 10     cmp   a,#$10
1909: 90 02     bcc   $190d
190b: 08 e0     or    a,#$e0
190d: 60        clrc
190e: 95 85 02  adc   a,$0285+x
1911: d5 85 02  mov   $0285+x,a
1914: c4 02     mov   $02,a
1916: f5 35 02  mov   a,$0235+x
1919: c4 00     mov   $00,a
191b: 3f bf 1d  call  $1dbf
191e: 6f        ret
191f: ce        pop   x
1920: e4 00     mov   a,$00
1922: 28 1f     and   a,#$1f
1924: bc        inc   a
1925: d5 25 02  mov   $0225+x,a
1928: d5 75 02  mov   $0275+x,a
192b: 6f        ret
192c: ce        pop   x
192d: e4 00     mov   a,$00
192f: 28 1f     and   a,#$1f
1931: bc        inc   a
1932: d5 25 02  mov   $0225+x,a
1935: e8 20     mov   a,#$20
1937: d5 55 02  mov   $0255+x,a
193a: 6f        ret
193b: ce        pop   x
193c: f5 75 02  mov   a,$0275+x
193f: d5 25 02  mov   $0225+x,a
1942: e4 00     mov   a,$00
1944: 28 1f     and   a,#$1f
1946: 08 20     or    a,#$20
1948: d5 55 02  mov   $0255+x,a
194b: 6f        ret
194c: ce        pop   x
194d: f5 75 02  mov   a,$0275+x
1950: d5 25 02  mov   $0225+x,a
1953: e4 00     mov   a,$00
1955: 28 1f     and   a,#$1f
1957: 08 a0     or    a,#$a0
1959: d5 55 02  mov   $0255+x,a
195c: 6f        ret
195d: ce        pop   x
195e: e4 00     mov   a,$00
1960: 28 1f     and   a,#$1f
1962: 68 10     cmp   a,#$10
1964: 90 02     bcc   $1968
1966: 08 e0     or    a,#$e0
1968: 60        clrc
1969: 95 95 02  adc   a,$0295+x
196c: d5 95 02  mov   $0295+x,a
196f: 08 80     or    a,#$80
1971: c4 04     mov   $04,a
1973: f5 35 02  mov   a,$0235+x
1976: 5d        mov   x,a
1977: e4 04     mov   a,$04
1979: d5 6f 03  mov   $036f+x,a
197c: 6f        ret
197d: e4 00     mov   a,$00
197f: 28 1f     and   a,#$1f
1981: 68 18     cmp   a,#$18
1983: 90 03     bcc   $1988
1985: 5f a1 1b  jmp   $1ba1
1988: 1c        asl   a
1989: 5d        mov   x,a
198a: 1f 8d 19  jmp   ($198d+x)
198d: bf        mov   a,(x)+
198e: 19        or    (x),(y)
198f: cf        mul   ya
1990: 19        or    (x),(y)
1991: 36 1a 46  and   a,$461a+y
1994: 1a 56     decw  $56
1996: 1a 66     decw  $66
1998: 1a 8c     decw  $8c
199a: 1a 8c     decw  $8c
199c: 1a 9c     decw  $9c
199e: 1a bc     decw  $bc
19a0: 1a 05     decw  $05
19a2: 1b 15     asl   $15+x
19a4: 1b 1d     asl   $1d+x
19a6: 1b 1f     asl   $1f+x
19a8: 1b 1f     asl   $1f+x
19aa: 1b 29     asl   $29+x
19ac: 1b 31     asl   $31+x
19ae: 1b 4d     asl   $4d+x
19b0: 1b bd     asl   $bd+x
19b2: 19        or    (x),(y)
19b3: 5f 1b 72  jmp   $721b
19b6: 1b 85     asl   $85+x
19b8: 1b 87     asl   $87+x
19ba: 1b 9a     asl   $9a+x
19bc: 1b ce     asl   $ce+x
19be: 6f        ret
19bf: ce        pop   x
19c0: 3f a8 1b  call  $1ba8
19c3: c4 04     mov   $04,a
19c5: f5 35 02  mov   a,$0235+x
19c8: 5d        mov   x,a
19c9: e4 04     mov   a,$04
19cb: d5 af 02  mov   $02af+x,a
19ce: 6f        ret
19cf: ce        pop   x
19d0: 3f a8 1b  call  $1ba8
19d3: c4 04     mov   $04,a
19d5: f5 35 02  mov   a,$0235+x
19d8: 5d        mov   x,a
19d9: f5 df 02  mov   a,$02df+x
19dc: f0 3d     beq   $1a1b
19de: 68 07     cmp   a,#$07
19e0: f0 3f     beq   $1a21
19e2: 68 08     cmp   a,#$08
19e4: f0 41     beq   $1a27
19e6: 68 09     cmp   a,#$09
19e8: f0 46     beq   $1a30
19ea: 9c        dec   a
19eb: 28 07     and   a,#$07
19ed: fd        mov   y,a
19ee: e4 04     mov   a,$04
19f0: ad 03     cmp   y,#$03
19f2: d0 0d     bne   $1a01
19f4: 2d        push  a
19f5: 80        setc
19f6: a5 aa 02  sbc   a,$02aa
19f9: 28 7f     and   a,#$7f
19fb: ae        pop   a
19fc: d0 01     bne   $19ff
19fe: 6f        ret
19ff: 08 80     or    a,#$80
1a01: d6 a7 02  mov   $02a7+y,a
1a04: ad 05     cmp   y,#$05
1a06: f0 01     beq   $1a09
1a08: 6f        ret
1a09: e5 ac 02  mov   a,$02ac
1a0c: 28 7f     and   a,#$7f
1a0e: 3f c9 08  call  $08c9
1a11: 68 ff     cmp   a,#$ff
1a13: d0 01     bne   $1a16
1a15: 6f        ret
1a16: 08 80     or    a,#$80
1a18: c4 18     mov   $18,a
1a1a: 6f        ret
1a1b: e4 04     mov   a,$04
1a1d: d5 bf 02  mov   $02bf+x,a
1a20: 6f        ret
1a21: e4 04     mov   a,$04
1a23: d5 cf 02  mov   $02cf+x,a
1a26: 6f        ret
1a27: e4 04     mov   a,$04
1a29: 1c        asl   a
1a2a: 80        setc
1a2b: a8 80     sbc   a,#$80
1a2d: c4 66     mov   $66,a
1a2f: 6f        ret
1a30: e4 04     mov   a,$04
1a32: 1c        asl   a
1a33: c4 67     mov   $67,a
1a35: 6f        ret
1a36: ce        pop   x
1a37: 3f a8 1b  call  $1ba8
1a3a: c4 04     mov   $04,a
1a3c: f5 35 02  mov   a,$0235+x
1a3f: 5d        mov   x,a
1a40: e4 04     mov   a,$04
1a42: d5 ef 02  mov   $02ef+x,a
1a45: 6f        ret
1a46: ce        pop   x
1a47: 3f a8 1b  call  $1ba8
1a4a: c4 04     mov   $04,a
1a4c: f5 35 02  mov   a,$0235+x
1a4f: 5d        mov   x,a
1a50: e4 04     mov   a,$04
1a52: d5 1f 03  mov   $031f+x,a
1a55: 6f        ret
1a56: ce        pop   x
1a57: 3f a8 1b  call  $1ba8
1a5a: c4 04     mov   $04,a
1a5c: f5 35 02  mov   a,$0235+x
1a5f: 5d        mov   x,a
1a60: e4 04     mov   a,$04
1a62: d5 2f 03  mov   $032f+x,a
1a65: 6f        ret
1a66: ce        pop   x
1a67: 3f a8 1b  call  $1ba8
1a6a: c4 04     mov   $04,a
1a6c: f5 35 02  mov   a,$0235+x
1a6f: 5d        mov   x,a
1a70: e4 04     mov   a,$04
1a72: d5 3f 03  mov   $033f+x,a
1a75: 28 40     and   a,#$40
1a77: f0 01     beq   $1a7a
1a79: 6f        ret
1a7a: f5 4f 03  mov   a,$034f+x
1a7d: 3f 25 1e  call  $1e25
1a80: 4e 3c 00  tclr1 $003c
1a83: 4e 3d 00  tclr1 $003d
1a86: e8 00     mov   a,#$00
1a88: d5 4f 03  mov   $034f+x,a
1a8b: 6f        ret
1a8c: ce        pop   x
1a8d: 3f a8 1b  call  $1ba8
1a90: c4 04     mov   $04,a
1a92: f5 35 02  mov   a,$0235+x
1a95: 5d        mov   x,a
1a96: e4 04     mov   a,$04
1a98: d5 df 02  mov   $02df+x,a
1a9b: 6f        ret
1a9c: ce        pop   x
1a9d: f5 35 02  mov   a,$0235+x
1aa0: 5d        mov   x,a
1aa1: e8 00     mov   a,#$00
1aa3: d5 3f 03  mov   $033f+x,a
1aa6: e8 00     mov   a,#$00
1aa8: d5 2f 03  mov   $032f+x,a
1aab: d5 ef 02  mov   $02ef+x,a
1aae: d5 af 02  mov   $02af+x,a
1ab1: e8 c0     mov   a,#$c0
1ab3: d5 6f 03  mov   $036f+x,a
1ab6: e8 40     mov   a,#$40
1ab8: d5 cf 02  mov   $02cf+x,a
1abb: 6f        ret
1abc: ce        pop   x
1abd: e4 3c     mov   a,$3c
1abf: c4 08     mov   $08,a
1ac1: f5 35 02  mov   a,$0235+x
1ac4: c4 00     mov   $00,a
1ac6: cd 07     mov   x,#$07
1ac8: 8d 00     mov   y,#$00
1aca: 0b 08     asl   $08
1acc: 90 0e     bcc   $1adc
1ace: f4 41     mov   a,$41+x
1ad0: 28 0f     and   a,#$0f
1ad2: 64 00     cmp   a,$00
1ad4: d0 06     bne   $1adc
1ad6: 80        setc
1ad7: 2b 06     rol   $06
1ad9: 5f df 1a  jmp   $1adf
1adc: 60        clrc
1add: 2b 06     rol   $06
1adf: 1d        dec   x
1ae0: 10 e8     bpl   $1aca
1ae2: f8 00     mov   x,$00
1ae4: f5 3f 03  mov   a,$033f+x
1ae7: 28 40     and   a,#$40
1ae9: d0 14     bne   $1aff
1aeb: e4 06     mov   a,$06
1aed: 15 4f 03  or    a,$034f+x
1af0: 3f 25 1e  call  $1e25
1af3: 4e 3d 00  tclr1 $003d
1af6: 4e 3c 00  tclr1 $003c
1af9: e8 00     mov   a,#$00
1afb: d5 4f 03  mov   $034f+x,a
1afe: 6f        ret
1aff: e4 06     mov   a,$06
1b01: d5 4f 03  mov   $034f+x,a
1b04: 6f        ret
1b05: ce        pop   x
1b06: 3f a8 1b  call  $1ba8
1b09: c4 02     mov   $02,a
1b0b: f5 35 02  mov   a,$0235+x
1b0e: 5d        mov   x,a
1b0f: e4 02     mov   a,$02
1b11: 3f f6 0d  call  $0df6
1b14: 6f        ret
1b15: ce        pop   x
1b16: 3f a8 1b  call  $1ba8
1b19: c5 03 02  mov   $0203,a
1b1c: 6f        ret
1b1d: ce        pop   x
1b1e: 6f        ret
1b1f: ce        pop   x
1b20: e8 00     mov   a,#$00
1b22: d5 15 02  mov   $0215+x,a
1b25: d5 05 02  mov   $0205+x,a
1b28: 6f        ret
1b29: ce        pop   x
1b2a: 3f a8 1b  call  $1ba8
1b2d: d5 35 02  mov   $0235+x,a
1b30: 6f        ret
1b31: ce        pop   x
1b32: 3f a8 1b  call  $1ba8
1b35: d5 85 02  mov   $0285+x,a
1b38: c4 02     mov   $02,a
1b3a: f5 35 02  mov   a,$0235+x
1b3d: c4 00     mov   $00,a
1b3f: 4d        push  x
1b40: 3f 94 0a  call  $0a94
1b43: ce        pop   x
1b44: f5 65 02  mov   a,$0265+x
1b47: c4 04     mov   $04,a
1b49: 3f b6 1c  call  $1cb6
1b4c: 6f        ret
1b4d: ce        pop   x
1b4e: 3f a8 1b  call  $1ba8
1b51: d5 85 02  mov   $0285+x,a
1b54: c4 02     mov   $02,a
1b56: f5 35 02  mov   a,$0235+x
1b59: c4 00     mov   $00,a
1b5b: 3f bf 1d  call  $1dbf
1b5e: 6f        ret
1b5f: ce        pop   x
1b60: 3f a8 1b  call  $1ba8
1b63: d5 85 02  mov   $0285+x,a
1b66: f5 75 02  mov   a,$0275+x
1b69: d5 25 02  mov   $0225+x,a
1b6c: e8 20     mov   a,#$20
1b6e: d5 55 02  mov   $0255+x,a
1b71: 6f        ret
1b72: ce        pop   x
1b73: 3f a8 1b  call  $1ba8
1b76: d5 95 02  mov   $0295+x,a
1b79: f5 75 02  mov   a,$0275+x
1b7c: d5 25 02  mov   $0225+x,a
1b7f: e8 a0     mov   a,#$a0
1b81: d5 55 02  mov   $0255+x,a
1b84: 6f        ret
1b85: ce        pop   x
1b86: 6f        ret
1b87: ce        pop   x
1b88: 3f a8 1b  call  $1ba8
1b8b: d5 95 02  mov   $0295+x,a
1b8e: 08 80     or    a,#$80
1b90: 2d        push  a
1b91: f5 35 02  mov   a,$0235+x
1b94: 5d        mov   x,a
1b95: ae        pop   a
1b96: d5 6f 03  mov   $036f+x,a
1b99: 6f        ret
1b9a: ce        pop   x
1b9b: e8 ff     mov   a,#$ff
1b9d: d5 25 02  mov   $0225+x,a
1ba0: 6f        ret
1ba1: ce        pop   x
1ba2: 28 07     and   a,#$07
1ba4: d5 65 02  mov   $0265+x,a
1ba7: 6f        ret
1ba8: 40        setp
1ba9: f4 06     mov   a,$06+x
1bab: 4d        push  x
1bac: 1c        asl   a
1bad: 5d        mov   x,a
1bae: 1f b1 1b  jmp   ($1bb1+x)
1bb1: bb 1b     inc   $1b+x
1bb3: c2 1b     set6  $1b
1bb5: c9 1b d0  mov   $d01b,x
1bb8: 1b d7     asl   $d7+x
1bba: 1b ce     asl   $ce+x
1bbc: 3f dd 1b  call  $1bdd
1bbf: 5f a8 1b  jmp   $1ba8
1bc2: ce        pop   x
1bc3: 3f fc 1b  call  $1bfc
1bc6: 5f db 1b  jmp   $1bdb
1bc9: ce        pop   x
1bca: 3f 08 1c  call  $1c08
1bcd: 5f a8 1b  jmp   $1ba8
1bd0: ce        pop   x
1bd1: 3f 2c 1c  call  $1c2c
1bd4: 5f db 1b  jmp   $1bdb
1bd7: ce        pop   x
1bd8: 3f 77 1c  call  $1c77
1bdb: 20        clrp
1bdc: 6f        ret
1bdd: 3f 9a 1c  call  $1c9a
1be0: f7 00     mov   a,($00)+y
1be2: fc        inc   y
1be3: 17 00     or    a,($00)+y
1be5: f0 0c     beq   $1bf3
1be7: fc        inc   y
1be8: e8 02     mov   a,#$02
1bea: d4 06     mov   $06+x,a
1bec: e8 00     mov   a,#$00
1bee: d4 56     mov   $56+x,a
1bf0: 5f f8 1b  jmp   $1bf8
1bf3: fc        inc   y
1bf4: e8 01     mov   a,#$01
1bf6: d4 06     mov   $06+x,a
1bf8: 3f a7 1c  call  $1ca7
1bfb: 6f        ret
1bfc: 3f 9a 1c  call  $1c9a
1bff: f7 00     mov   a,($00)+y
1c01: fc        inc   y
1c02: 2d        push  a
1c03: 3f a7 1c  call  $1ca7
1c06: ae        pop   a
1c07: 6f        ret
1c08: 3f 9a 1c  call  $1c9a
1c0b: f4 16     mov   a,$16+x
1c0d: d0 0e     bne   $1c1d
1c0f: f7 00     mov   a,($00)+y
1c11: fc        inc   y
1c12: 48 ff     eor   a,#$ff
1c14: d4 36     mov   $36+x,a
1c16: e8 08     mov   a,#$08
1c18: d4 16     mov   $16+x,a
1c1a: 3f a7 1c  call  $1ca7
1c1d: 1b 36     asl   $36+x
1c1f: e8 00     mov   a,#$00
1c21: 88 03     adc   a,#$03
1c23: d4 06     mov   $06+x,a
1c25: e8 ff     mov   a,#$ff
1c27: d4 26     mov   $26+x,a
1c29: 9b 16     dec   $16+x
1c2b: 6f        ret
1c2c: 3f 9a 1c  call  $1c9a
1c2f: f4 26     mov   a,$26+x
1c31: 10 18     bpl   $1c4b
1c33: f7 00     mov   a,($00)+y
1c35: fc        inc   y
1c36: c4 02     mov   $02,a
1c38: 9f        xcn   a
1c39: 5c        lsr   a
1c3a: 28 07     and   a,#$07
1c3c: 60        clrc
1c3d: 88 02     adc   a,#$02
1c3f: d4 26     mov   $26+x,a
1c41: 38 1f 02  and   $02,#$1f
1c44: f4 56     mov   a,$56+x
1c46: 60        clrc
1c47: a4 02     sbc   a,$02
1c49: d4 46     mov   $46+x,a
1c4b: 3f a7 1c  call  $1ca7
1c4e: f4 66     mov   a,$66+x
1c50: c4 02     mov   $02,a
1c52: f4 76     mov   a,$76+x
1c54: c4 03     mov   $03,a
1c56: f4 46     mov   a,$46+x
1c58: bb 46     inc   $46+x
1c5a: 28 1f     and   a,#$1f
1c5c: fd        mov   y,a
1c5d: f7 02     mov   a,($02)+y
1c5f: c4 04     mov   $04,a
1c61: f4 56     mov   a,$56+x
1c63: bb 56     inc   $56+x
1c65: 28 1f     and   a,#$1f
1c67: fd        mov   y,a
1c68: e4 04     mov   a,$04
1c6a: d7 02     mov   ($02)+y,a
1c6c: 9b 26     dec   $26+x
1c6e: 10 04     bpl   $1c74
1c70: e8 02     mov   a,#$02
1c72: d4 06     mov   $06+x,a
1c74: e4 04     mov   a,$04
1c76: 6f        ret
1c77: 3f 9a 1c  call  $1c9a
1c7a: e8 02     mov   a,#$02
1c7c: d4 06     mov   $06+x,a
1c7e: f4 66     mov   a,$66+x
1c80: c4 02     mov   $02,a
1c82: f4 76     mov   a,$76+x
1c84: c4 03     mov   $03,a
1c86: f7 00     mov   a,($00)+y
1c88: fc        inc   y
1c89: c4 04     mov   $04,a
1c8b: 3f a7 1c  call  $1ca7
1c8e: f4 56     mov   a,$56+x
1c90: bb 56     inc   $56+x
1c92: 28 1f     and   a,#$1f
1c94: fd        mov   y,a
1c95: e4 04     mov   a,$04
1c97: d7 02     mov   ($02)+y,a
1c99: 6f        ret
1c9a: f5 05 02  mov   a,$0205+x
1c9d: c4 00     mov   $00,a
1c9f: f5 15 02  mov   a,$0215+x
1ca2: c4 01     mov   $01,a
1ca4: 8d 00     mov   y,#$00
1ca6: 6f        ret
1ca7: 60        clrc
1ca8: dd        mov   a,y
1ca9: 84 00     adc   a,$00
1cab: d5 05 02  mov   $0205+x,a
1cae: e8 00     mov   a,#$00
1cb0: 84 01     adc   a,$01
1cb2: d5 15 02  mov   $0215+x,a
1cb5: 6f        ret
1cb6: f8 6d     mov   x,$6d
1cb8: e4 00     mov   a,$00
1cba: 28 0f     and   a,#$0f
1cbc: d4 6e     mov   $6e+x,a
1cbe: e4 02     mov   a,$02
1cc0: d4 6f     mov   $6f+x,a
1cc2: e4 04     mov   a,$04
1cc4: d4 70     mov   $70+x,a
1cc6: 3d        inc   x
1cc7: 3d        inc   x
1cc8: 3d        inc   x
1cc9: d8 6d     mov   $6d,x
1ccb: 6f        ret
1ccc: f8 6d     mov   x,$6d
1cce: f0 1e     beq   $1cee
1cd0: cd 00     mov   x,#$00
1cd2: f4 6e     mov   a,$6e+x
1cd4: c4 00     mov   $00,a
1cd6: f4 6f     mov   a,$6f+x
1cd8: c4 02     mov   $02,a
1cda: f4 70     mov   a,$70+x
1cdc: c4 04     mov   $04,a
1cde: 68 ff     cmp   a,#$ff
1ce0: f0 05     beq   $1ce7
1ce2: 4d        push  x
1ce3: 3f ef 1c  call  $1cef
1ce6: ce        pop   x
1ce7: 3d        inc   x
1ce8: 3d        inc   x
1ce9: 3d        inc   x
1cea: 3e 6d     cmp   x,$6d
1cec: d0 e4     bne   $1cd2
1cee: 6f        ret
1cef: 38 0f 00  and   $00,#$0f
1cf2: cd 07     mov   x,#$07
1cf4: fa 3c 06  mov   ($06),($3c)
1cf7: 0b 06     asl   $06
1cf9: 90 0e     bcc   $1d09
1cfb: f4 41     mov   a,$41+x
1cfd: 28 0f     and   a,#$0f
1cff: 64 00     cmp   a,$00
1d01: d0 06     bne   $1d09
1d03: f4 49     mov   a,$49+x
1d05: 64 02     cmp   a,$02
1d07: f0 0e     beq   $1d17
1d09: 1d        dec   x
1d0a: 10 eb     bpl   $1cf7
1d0c: cd 07     mov   x,#$07
1d0e: e4 3c     mov   a,$3c
1d10: 1c        asl   a
1d11: 90 04     bcc   $1d17
1d13: 1d        dec   x
1d14: 10 fa     bpl   $1d10
1d16: 6f        ret
1d17: f5 6a 21  mov   a,$216a+x
1d1a: 0e 3d 00  tset1 $003d
1d1d: 0e 3c 00  tset1 $003c
1d20: 0e 3f 00  tset1 $003f
1d23: e4 04     mov   a,$04
1d25: 9f        xcn   a
1d26: 04 00     or    a,$00
1d28: d4 41     mov   $41+x,a
1d2a: e4 02     mov   a,$02
1d2c: d4 49     mov   $49+x,a
1d2e: eb 00     mov   y,$00
1d30: f6 7f 03  mov   a,$037f+y
1d33: d4 51     mov   $51+x,a
1d35: c4 61     mov   $61,a
1d37: f6 8f 03  mov   a,$038f+y
1d3a: d4 59     mov   $59+x,a
1d3c: c4 62     mov   $62,a
1d3e: e8 00     mov   a,#$00
1d40: d5 0f 04  mov   $040f+x,a
1d43: 8d 01     mov   y,#$01
1d45: f7 61     mov   a,($61)+y
1d47: f0 35     beq   $1d7e
1d49: c4 0e     mov   $0e,a
1d4b: 8d 02     mov   y,#$02
1d4d: f7 61     mov   a,($61)+y
1d4f: d5 17 04  mov   $0417+x,a
1d52: 8d 03     mov   y,#$03
1d54: f7 61     mov   a,($61)+y
1d56: d5 1f 04  mov   $041f+x,a
1d59: f0 23     beq   $1d7e
1d5b: d8 00     mov   $00,x
1d5d: 5d        mov   x,a
1d5e: e4 0e     mov   a,$0e
1d60: 8d 00     mov   y,#$00
1d62: 9e        div   ya,x
1d63: c4 01     mov   $01,a
1d65: dd        mov   a,y
1d66: 5d        mov   x,a
1d67: 8d 01     mov   y,#$01
1d69: e8 00     mov   a,#$00
1d6b: 9e        div   ya,x
1d6c: f8 00     mov   x,$00
1d6e: d5 2f 04  mov   $042f+x,a
1d71: e4 01     mov   a,$01
1d73: d5 27 04  mov   $0427+x,a
1d76: e8 00     mov   a,#$00
1d78: d5 47 04  mov   $0447+x,a
1d7b: d5 3f 04  mov   $043f+x,a
1d7e: e8 00     mov   a,#$00
1d80: d5 4f 04  mov   $044f+x,a
1d83: 8d 08     mov   y,#$08
1d85: f7 61     mov   a,($61)+y
1d87: f0 35     beq   $1dbe
1d89: c4 0e     mov   $0e,a
1d8b: 8d 09     mov   y,#$09
1d8d: f7 61     mov   a,($61)+y
1d8f: d5 57 04  mov   $0457+x,a
1d92: 8d 0a     mov   y,#$0a
1d94: f7 61     mov   a,($61)+y
1d96: d5 5f 04  mov   $045f+x,a
1d99: f0 23     beq   $1dbe
1d9b: d8 00     mov   $00,x
1d9d: 5d        mov   x,a
1d9e: e4 0e     mov   a,$0e
1da0: 8d 00     mov   y,#$00
1da2: 9e        div   ya,x
1da3: c4 01     mov   $01,a
1da5: dd        mov   a,y
1da6: 5d        mov   x,a
1da7: 8d 01     mov   y,#$01
1da9: e8 00     mov   a,#$00
1dab: 9e        div   ya,x
1dac: f8 00     mov   x,$00
1dae: d5 6f 04  mov   $046f+x,a
1db1: e4 01     mov   a,$01
1db3: d5 67 04  mov   $0467+x,a
1db6: e8 00     mov   a,#$00
1db8: d5 87 04  mov   $0487+x,a
1dbb: d5 7f 04  mov   $047f+x,a
1dbe: 6f        ret
1dbf: 38 0f 00  and   $00,#$0f
1dc2: f8 6d     mov   x,$6d
1dc4: f0 18     beq   $1dde
1dc6: e4 00     mov   a,$00
1dc8: 74 6e     cmp   a,$6e+x
1dca: d0 0d     bne   $1dd9
1dcc: e4 02     mov   a,$02
1dce: 74 6f     cmp   a,$6f+x
1dd0: d0 07     bne   $1dd9
1dd2: e8 ff     mov   a,#$ff
1dd4: d4 70     mov   $70+x,a
1dd6: 5f de 1d  jmp   $1dde
1dd9: 1d        dec   x
1dda: 1d        dec   x
1ddb: 1d        dec   x
1ddc: 10 e8     bpl   $1dc6
1dde: fa 3c 06  mov   ($06),($3c)
1de1: 8f 80 08  mov   $08,#$80
1de4: eb 02     mov   y,$02
1de6: cd 07     mov   x,#$07
1de8: 0b 06     asl   $06
1dea: 90 0d     bcc   $1df9
1dec: f4 41     mov   a,$41+x
1dee: 28 0f     and   a,#$0f
1df0: 64 00     cmp   a,$00
1df2: d0 05     bne   $1df9
1df4: dd        mov   a,y
1df5: 74 49     cmp   a,$49+x
1df7: f0 06     beq   $1dff
1df9: 4b 08     lsr   $08
1dfb: 1d        dec   x
1dfc: 10 ea     bpl   $1de8
1dfe: 6f        ret
1dff: f4 41     mov   a,$41+x
1e01: 28 0f     and   a,#$0f
1e03: fd        mov   y,a
1e04: f6 3f 03  mov   a,$033f+y
1e07: 28 40     and   a,#$40
1e09: d0 11     bne   $1e1c
1e0b: e4 08     mov   a,$08
1e0d: 3f 25 1e  call  $1e25
1e10: 4e 3c 00  tclr1 $003c
1e13: 4e 3d 00  tclr1 $003d
1e16: e8 00     mov   a,#$00
1e18: d6 4f 03  mov   $034f+y,a
1e1b: 6f        ret
1e1c: e4 08     mov   a,$08
1e1e: 16 4f 03  or    a,$034f+y
1e21: d6 4f 03  mov   $034f+y,a
1e24: 6f        ret
1e25: 2d        push  a
1e26: c4 08     mov   $08,a
1e28: fa 30 09  mov   ($09),($30)
1e2b: cd 07     mov   x,#$07
1e2d: 0b 09     asl   $09
1e2f: 90 05     bcc   $1e36
1e31: 0b 08     asl   $08
1e33: 5f 43 1e  jmp   $1e43
1e36: 0b 08     asl   $08
1e38: 90 09     bcc   $1e43
1e3a: 7d        mov   a,x
1e3b: 9f        xcn   a
1e3c: 08 05     or    a,#$05
1e3e: c4 f2     mov   $f2,a
1e40: 8f 00 f3  mov   $f3,#$00
1e43: 1d        dec   x
1e44: 10 e7     bpl   $1e2d
1e46: ae        pop   a
1e47: 6f        ret

1e48: 3f ba 1f  call  $1fba  ; From $083e
1e4b: 3f a1 1f  call  $1fa1
1e4e: 3f 6a 1e  call  $1e6a
1e51: 3f 55 1e  call  $1e55
1e54: 6f        ret
1e55: 40        setp
1e56: cd 0f     mov   x,#$0f
1e58: 7d        mov   a,x
1e59: 9f        xcn   a
1e5a: 1c        asl   a
1e5b: d4 66     mov   $66+x,a
1e5d: 3c        rol   a
1e5e: 28 01     and   a,#$01
1e60: 60        clrc
1e61: 88 06     adc   a,#$06
1e63: d4 76     mov   $76+x,a
1e65: 1d        dec   x
1e66: 10 f0     bpl   $1e58
1e68: 20        clrp
1e69: 6f        ret
1e6a: 8f 00 33  mov   $33,#$00
1e6d: cd 0f     mov   x,#$0f
1e6f: e8 40     mov   a,#$40
1e71: d5 1f 03  mov   $031f+x,a
1e74: e8 7f     mov   a,#$7f
1e76: d5 ef 02  mov   $02ef+x,a
1e79: e8 c0     mov   a,#$c0
1e7b: d5 6f 03  mov   $036f+x,a
1e7e: e8 40     mov   a,#$40
1e80: d5 cf 02  mov   $02cf+x,a
1e83: e8 00     mov   a,#$00
1e85: d5 2f 03  mov   $032f+x,a
1e88: d5 af 02  mov   $02af+x,a
1e8b: d5 3f 03  mov   $033f+x,a
1e8e: e8 0b     mov   a,#$0b
1e90: d5 bf 02  mov   $02bf+x,a
1e93: e8 00     mov   a,#$00
1e95: 3f f6 0d  call  $0df6
1e98: 1d        dec   x
1e99: 10 d4     bpl   $1e6f
1e9b: 6f        ret
1e9c: e5 aa 02  mov   a,$02aa
1e9f: 30 03     bmi   $1ea4
1ea1: 5f 30 1f  jmp   $1f30
1ea4: e5 a5 02  mov   a,$02a5
1ea7: d0 47     bne   $1ef0
1ea9: ac a5 02  inc   $02a5
1eac: 8f 7d f2  mov   $f2,#$7d
1eaf: e4 f3     mov   a,$f3
1eb1: 5c        lsr   a
1eb2: 60        clrc
1eb3: 84 f3     adc   a,$f3
1eb5: 28 1f     and   a,#$1f
1eb7: 48 ff     eor   a,#$ff
1eb9: c5 a6 02  mov   $02a6,a
1ebc: e8 00     mov   a,#$00
1ebe: 8f 2c f2  mov   $f2,#$2c
1ec1: c4 f3     mov   $f3,a
1ec3: 8f 3c f2  mov   $f2,#$3c
1ec6: c4 f3     mov   $f3,a
1ec8: 8f 4d f2  mov   $f2,#$4d
1ecb: c4 f3     mov   $f3,a
1ecd: 8f 0d f2  mov   $f2,#$0d
1ed0: c4 f3     mov   $f3,a
1ed2: 8f 6c f2  mov   $f2,#$6c
1ed5: 8f 20 f3  mov   $f3,#$20
1ed8: 8f 7d f2  mov   $f2,#$7d
1edb: e5 aa 02  mov   a,$02aa
1ede: 28 0f     and   a,#$0f
1ee0: c4 f3     mov   $f3,a
1ee2: 1c        asl   a
1ee3: 1c        asl   a
1ee4: 1c        asl   a
1ee5: 48 ff     eor   a,#$ff
1ee7: 80        setc
1ee8: 88 f8     adc   a,#$f8
1eea: 8f 6d f2  mov   $f2,#$6d
1eed: c4 f3     mov   $f3,a
1eef: 6f        ret
1ef0: 68 01     cmp   a,#$01
1ef2: d0 21     bne   $1f15
1ef4: ac a6 02  inc   $02a6
1ef7: 30 36     bmi   $1f2f
1ef9: ac a5 02  inc   $02a5
1efc: 3f 59 1f  call  $1f59
1eff: 8f 6c f2  mov   $f2,#$6c
1f02: 8f 00 f3  mov   $f3,#$00
1f05: e5 aa 02  mov   a,$02aa
1f08: 5c        lsr   a
1f09: 60        clrc
1f0a: 85 aa 02  adc   a,$02aa
1f0d: 28 1f     and   a,#$1f
1f0f: 48 ff     eor   a,#$ff
1f11: c5 a6 02  mov   $02a6,a
1f14: 6f        ret
1f15: ac a6 02  inc   $02a6
1f18: 30 15     bmi   $1f2f
1f1a: e5 aa 02  mov   a,$02aa
1f1d: 28 7f     and   a,#$7f
1f1f: c5 aa 02  mov   $02aa,a
1f22: e5 a7 02  mov   a,$02a7
1f25: 08 80     or    a,#$80
1f27: c5 a7 02  mov   $02a7,a
1f2a: e8 00     mov   a,#$00
1f2c: c5 a5 02  mov   $02a5,a
1f2f: 6f        ret
1f30: e5 a7 02  mov   a,$02a7
1f33: 10 23     bpl   $1f58
1f35: 28 7f     and   a,#$7f
1f37: c5 a7 02  mov   $02a7,a
1f3a: 8f 2c f2  mov   $f2,#$2c
1f3d: c5 a7 02  mov   $02a7,a
1f40: c4 f3     mov   $f3,a
1f42: 8f 3c f2  mov   $f2,#$3c
1f45: e5 a8 02  mov   a,$02a8
1f48: 28 7f     and   a,#$7f
1f4a: c5 a8 02  mov   $02a8,a
1f4d: c4 f3     mov   $f3,a
1f4f: 8f 0d f2  mov   $f2,#$0d
1f52: e5 a9 02  mov   a,$02a9
1f55: 1c        asl   a
1f56: c4 f3     mov   $f3,a
1f58: 6f        ret
1f59: e5 ab 02  mov   a,$02ab
1f5c: 1c        asl   a
1f5d: 1c        asl   a
1f5e: 1c        asl   a
1f5f: 08 07     or    a,#$07
1f61: fd        mov   y,a
1f62: cd 07     mov   x,#$07
1f64: 7d        mov   a,x
1f65: 9f        xcn   a
1f66: 08 0f     or    a,#$0f
1f68: c4 f2     mov   $f2,a
1f6a: f6 4a 21  mov   a,$214a+y
1f6d: c4 f3     mov   $f3,a
1f6f: dc        dec   y
1f70: 1d        dec   x
1f71: 10 f1     bpl   $1f64
1f73: 6f        ret
1f74: e8 00     mov   a,#$00
1f76: 8f 2c f2  mov   $f2,#$2c
1f79: c4 f3     mov   $f3,a
1f7b: 8f 3c f2  mov   $f2,#$3c
1f7e: c4 f3     mov   $f3,a
1f80: 8f 6c f2  mov   $f2,#$6c
1f83: 8f 20 f3  mov   $f3,#$20
1f86: 8f 7d f2  mov   $f2,#$7d
1f89: c4 f3     mov   $f3,a
1f8b: 8f 6d f2  mov   $f2,#$6d
1f8e: 8f f8 f3  mov   $f3,#$f8
1f91: 8f 4d f2  mov   $f2,#$4d
1f94: c4 f3     mov   $f3,a
1f96: 8f 2d f2  mov   $f2,#$2d
1f99: c4 f3     mov   $f3,a
1f9b: 8f 3d f2  mov   $f2,#$3d
1f9e: c4 f3     mov   $f3,a
1fa0: 6f        ret
1fa1: 8f 00 f1  mov   DSP_CTRL,#$00
1fa4: 8f 60 fa  mov   TIMER0,#$60
1fa7: 8f 60 fb  mov   TIMER1,#$60
1faa: 8f 33 f1  mov   DSP_CTRL,#$33
1fad: 8f 00 f4  mov   PORT0,#$00
1fb0: 8f 00 f5  mov   PORT1,#$00
1fb3: 8f 00 f6  mov   PORT2,#$00
1fb6: 8f 00 f7  mov   PORT3,#$00
1fb9: 6f        ret

1fba: 8f 6c f2  mov   $f2,#$6c
1fbd: 8f e0 f3  mov   $f3,#$e0
1fc0: 8f 5d f2  mov   DSP_ADDR,#$5d
1fc3: e8 25     mov   a,#$25
1fc5: c4 f3     mov   $f3,a
1fc7: cd 26     mov   x,#$26
1fc9: f5 f5 1f  mov   a,$1ff5+x
1fcc: fd        mov   y,a
1fcd: f5 f6 1f  mov   a,$1ff6+x
1fd0: 3f 1d 20  call  $201d
1fd3: 1d        dec   x
1fd4: 1d        dec   x
1fd5: 10 f2     bpl   $1fc9
1fd7: cd ff     mov   x,#$ff
1fd9: 8d 00     mov   y,#$00
1fdb: 00        nop
1fdc: dc        dec   y
1fdd: d0 fc     bne   $1fdb
1fdf: 1d        dec   x
1fe0: d0 f7     bne   $1fd9
1fe2: 8f 6c f2  mov   DSP_ADDR,#$6c
1fe5: 8f 20 f3  mov   $f3,#$20
1fe8: 8f 0c f2  mov   DSP_ADDR,#$0c
1feb: 8f 60 f3  mov   $f3,#$60
1fee: 8f 1c f2  mov   DSP_ADDR,#$1c
1ff1: 8f 60 f3  mov   $f3,#$60
1ff4: 6f        ret
1ff5: 2d        push  a
1ff6: 00        nop
1ff7: 3d        inc   x
1ff8: 00        nop
1ff9: 0c 00 1c  asl   $1c00
1ffc: 00        nop
1ffd: 7d        mov   a,x
1ffe: 00        nop
1fff: 0d        push  psw
2000: 00        nop
2001: 4d        push  x
2002: 00        nop
2003: 2c 00 3c  rol   $3c00
2006: 00        nop
2007: 6d        push  y
2008: f8 5c     mov   x,$5c
200a: 00        nop
200b: 4c 00 0f  lsr   $0f00
200e: 7f        reti
200f: 1f 00 2f  jmp   ($2f00+x)
2012: 00        nop
2013: 3f 00 4f  call  $4f00
2016: 00        nop
2017: 5f 00 6f  jmp   $6f00
201a: 00        nop
201b: 7f        reti
201c: 00        nop
201d: cb f2     mov   DSP_ADDR,y
201f: c4 f3     mov   $f3,a
2021: 6f        ret
2022: cb f2     mov   DSP_ADDR,y
2024: e4 f3     mov   a,$f3
2026: 6f        ret
2027: e8 00     mov   a,#$00
2029: c4 f4     mov   PORT0,a
202b: c4 02     mov   $02,a
202d: c4 00     mov   $00,a
202f: 8f 65 f6  mov   PORT2,#$65
2032: 8f 02 f7  mov   PORT3,#$02
2035: 78 65 f6  cmp   PORT2,#$65
2038: d0 fb     bne   $2035
203a: 78 02 f7  cmp   PORT3,#$02
203d: d0 f6     bne   $2035
203f: e4 02     mov   a,$02
2041: 64 f4     cmp   a,PORT0
2043: f0 fc     beq   $2041
2045: e4 f4     mov   a,PORT0
2047: c4 02     mov   $02,a
2049: 28 41     and   a,#$41
204b: d0 13     bne   $2060
204d: e4 f6     mov   a,PORT2
204f: d7 00     mov   ($00)+y,a
2051: fc        inc   y
2052: e4 f7     mov   a,PORT3
2054: d7 00     mov   ($00)+y,a
2056: fa 02 f4  mov   ($f4),($02)
2059: fc        inc   y
205a: d0 e3     bne   $203f
205c: ab 01     inc   $01
205e: 2f df     bra   $203f
2060: 28 01     and   a,#$01
2062: d0 0b     bne   $206f
2064: e4 f7     mov   a,PORT3
2066: c4 01     mov   $01,a
2068: eb f6     mov   y,PORT2
206a: fa 02 f4  mov   ($f4),($02)
206d: 2f d0     bra   $203f
206f: 8f 33 f1  mov   DSP_CTRL,#$33
2072: 8f 00 19  mov   $19,#$00
2075: 8f 00 1a  mov   $1a,#$00
2078: 8f 00 1b  mov   $1b,#$00
207b: 8f 00 1c  mov   $1c,#$00
207e: 8f 00 f4  mov   PORT0,#$00
2081: 8f 00 f5  mov   PORT1,#$00
2084: 8f 00 f6  mov   PORT2,#$00
2087: 8f 00 f7  mov   PORT3,#$00
208a: 60        clrc
208b: e5 04 08  mov   a,$0804
208e: 88 01     adc   a,#$01
2090: c5 7e 0e  mov   $0e7e,a
2093: e5 05 08  mov   a,$0805
2096: 88 00     adc   a,#$00
2098: c5 7f 0e  mov   $0e7f,a
209b: 60        clrc
209c: e5 04 08  mov   a,$0804
209f: 88 02     adc   a,#$02
20a1: c5 86 0e  mov   $0e86,a
20a4: e5 05 08  mov   a,$0805
20a7: 88 00     adc   a,#$00
20a9: c5 87 0e  mov   $0e87,a
20ac: 60        clrc
20ad: e5 04 08  mov   a,$0804
20b0: 88 03     adc   a,#$03
20b2: c5 8b 0e  mov   $0e8b,a
20b5: e5 05 08  mov   a,$0805
20b8: 88 00     adc   a,#$00
20ba: c5 8c 0e  mov   $0e8c,a
20bd: 60        clrc
20be: e5 06 08  mov   a,$0806
20c1: 88 01     adc   a,#$01
20c3: c5 c1 08  mov   $08c1,a
20c6: e5 07 08  mov   a,$0807
20c9: 88 00     adc   a,#$00
20cb: c5 c2 08  mov   $08c2,a
20ce: 60        clrc
20cf: e5 06 08  mov   a,$0806
20d2: 88 02     adc   a,#$02
20d4: c5 94 09  mov   $0994,a
20d7: e5 07 08  mov   a,$0807
20da: 88 00     adc   a,#$00
20dc: c5 95 09  mov   $0995,a
20df: 60        clrc
20e0: e5 06 08  mov   a,$0806
20e3: 88 03     adc   a,#$03
20e5: c5 99 09  mov   $0999,a
20e8: e5 07 08  mov   a,$0807
20eb: 88 00     adc   a,#$00
20ed: c5 9a 09  mov   $099a,a
20f0: e5 00 08  mov   a,$0800
20f3: c5 12 0e  mov   $0e12,a
20f6: e5 01 08  mov   a,$0801
20f9: c5 13 0e  mov   $0e13,a
20fc: 60        clrc
20fd: e5 00 08  mov   a,$0800
2100: 88 01     adc   a,#$01
2102: c5 17 0e  mov   $0e17,a
2105: e5 01 08  mov   a,$0801
2108: 88 00     adc   a,#$00
210a: c5 18 0e  mov   $0e18,a
210d: e5 03 08  mov   a,$0803
2110: c5 c4 1f  mov   $1fc4,a
2113: e5 08 08  mov   a,$0808
2116: c5 cb 08  mov   $08cb,a
2119: e5 09 08  mov   a,$0809
211c: c5 cc 08  mov   $08cc,a
211f: e5 0a 08  mov   a,$080a
2122: c5 76 0e  mov   $0e76,a
2125: e5 0b 08  mov   a,$080b
2128: c5 77 0e  mov   $0e77,a
212b: e5 0c 08  mov   a,$080c
212e: c5 08 0e  mov   $0e08,a
2131: e5 0d 08  mov   a,$080d
2134: c5 09 0e  mov   $0e09,a
2137: e5 0e 08  mov   a,$080e
213a: c5 38 14  mov   $1438,a
213d: c5 aa 0b  mov   $0baa,a
2140: e5 0f 08  mov   a,$080f
2143: c5 39 14  mov   $1439,a
2146: c5 ab 0b  mov   $0bab,a
2149: 6f        ret
214a: 7f        reti
214b: 00        nop
214c: 00        nop
214d: 00        nop
214e: 00        nop
214f: 00        nop
2150: 00        nop
2151: 00        nop
