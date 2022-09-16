; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-- -mcpu=pwr8 < %s | FileCheck %s --check-prefix=LE
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-- -mcpu=pwr8 < %s | FileCheck %s --check-prefix=BE

define <8 x i16> @pr25080(<8 x i32> %a) {
; LE-LABEL: pr25080:
; LE:       # %bb.0: # %entry
; LE-NEXT:    addis 3, 2, .LCPI0_0@toc@ha
; LE-NEXT:    xxlxor 37, 37, 37
; LE-NEXT:    addi 3, 3, .LCPI0_0@toc@l
; LE-NEXT:    lvx 4, 0, 3
; LE-NEXT:    xxland 34, 34, 36
; LE-NEXT:    xxland 35, 35, 36
; LE-NEXT:    vcmpequw 2, 2, 5
; LE-NEXT:    vcmpequw 3, 3, 5
; LE-NEXT:    xxswapd 0, 34
; LE-NEXT:    mfvsrwz 3, 34
; LE-NEXT:    xxsldwi 1, 34, 34, 1
; LE-NEXT:    mfvsrwz 4, 35
; LE-NEXT:    xxsldwi 4, 34, 34, 3
; LE-NEXT:    mtfprd 2, 3
; LE-NEXT:    mffprwz 3, 0
; LE-NEXT:    xxswapd 0, 35
; LE-NEXT:    mtfprd 3, 4
; LE-NEXT:    xxsldwi 5, 35, 35, 1
; LE-NEXT:    mffprwz 4, 1
; LE-NEXT:    xxsldwi 7, 35, 35, 3
; LE-NEXT:    mtfprd 1, 3
; LE-NEXT:    xxswapd 33, 3
; LE-NEXT:    mffprwz 3, 4
; LE-NEXT:    mtfprd 4, 4
; LE-NEXT:    xxswapd 34, 1
; LE-NEXT:    mffprwz 4, 0
; LE-NEXT:    mtfprd 0, 3
; LE-NEXT:    xxswapd 35, 4
; LE-NEXT:    mffprwz 3, 5
; LE-NEXT:    mtfprd 6, 4
; LE-NEXT:    xxswapd 36, 0
; LE-NEXT:    mtfprd 1, 3
; LE-NEXT:    mffprwz 3, 7
; LE-NEXT:    xxswapd 37, 6
; LE-NEXT:    vmrglh 2, 3, 2
; LE-NEXT:    xxswapd 35, 2
; LE-NEXT:    mtfprd 2, 3
; LE-NEXT:    xxswapd 32, 1
; LE-NEXT:    addis 3, 2, .LCPI0_1@toc@ha
; LE-NEXT:    addi 3, 3, .LCPI0_1@toc@l
; LE-NEXT:    xxswapd 38, 2
; LE-NEXT:    vmrglh 3, 4, 3
; LE-NEXT:    vmrglh 4, 0, 5
; LE-NEXT:    vmrglh 5, 6, 1
; LE-NEXT:    vmrglw 2, 3, 2
; LE-NEXT:    vmrglw 3, 5, 4
; LE-NEXT:    vspltish 4, 15
; LE-NEXT:    xxmrgld 34, 35, 34
; LE-NEXT:    lvx 3, 0, 3
; LE-NEXT:    xxlor 34, 34, 35
; LE-NEXT:    vslh 2, 2, 4
; LE-NEXT:    vsrah 2, 2, 4
; LE-NEXT:    blr
;
; BE-LABEL: pr25080:
; BE:       # %bb.0: # %entry
; BE-NEXT:    addis 3, 2, .LCPI0_0@toc@ha
; BE-NEXT:    xxlxor 36, 36, 36
; BE-NEXT:    addi 3, 3, .LCPI0_0@toc@l
; BE-NEXT:    lxvw4x 0, 0, 3
; BE-NEXT:    xxland 35, 35, 0
; BE-NEXT:    xxland 34, 34, 0
; BE-NEXT:    vcmpequw 3, 3, 4
; BE-NEXT:    vcmpequw 2, 2, 4
; BE-NEXT:    xxswapd 0, 35
; BE-NEXT:    mfvsrwz 3, 35
; BE-NEXT:    xxsldwi 1, 35, 35, 1
; BE-NEXT:    sldi 3, 3, 48
; BE-NEXT:    mffprwz 4, 0
; BE-NEXT:    xxsldwi 0, 35, 35, 3
; BE-NEXT:    mtvsrd 36, 3
; BE-NEXT:    mffprwz 3, 1
; BE-NEXT:    sldi 4, 4, 48
; BE-NEXT:    xxswapd 1, 34
; BE-NEXT:    mtvsrd 35, 4
; BE-NEXT:    mfvsrwz 4, 34
; BE-NEXT:    sldi 3, 3, 48
; BE-NEXT:    mtvsrd 37, 3
; BE-NEXT:    mffprwz 3, 0
; BE-NEXT:    sldi 4, 4, 48
; BE-NEXT:    xxsldwi 0, 34, 34, 1
; BE-NEXT:    vmrghh 3, 5, 3
; BE-NEXT:    mtvsrd 37, 4
; BE-NEXT:    sldi 3, 3, 48
; BE-NEXT:    mffprwz 4, 1
; BE-NEXT:    xxsldwi 1, 34, 34, 3
; BE-NEXT:    mtvsrd 34, 3
; BE-NEXT:    mffprwz 3, 0
; BE-NEXT:    sldi 4, 4, 48
; BE-NEXT:    mtvsrd 32, 4
; BE-NEXT:    mffprwz 4, 1
; BE-NEXT:    sldi 3, 3, 48
; BE-NEXT:    mtvsrd 33, 3
; BE-NEXT:    sldi 3, 4, 48
; BE-NEXT:    vmrghh 2, 2, 4
; BE-NEXT:    mtvsrd 36, 3
; BE-NEXT:    addis 3, 2, .LCPI0_1@toc@ha
; BE-NEXT:    vmrghh 0, 1, 0
; BE-NEXT:    addi 3, 3, .LCPI0_1@toc@l
; BE-NEXT:    vmrghh 4, 4, 5
; BE-NEXT:    lxvw4x 0, 0, 3
; BE-NEXT:    vmrghw 2, 2, 3
; BE-NEXT:    vmrghw 3, 4, 0
; BE-NEXT:    xxmrghd 34, 35, 34
; BE-NEXT:    vspltish 3, 15
; BE-NEXT:    xxlor 34, 34, 0
; BE-NEXT:    vslh 2, 2, 3
; BE-NEXT:    vsrah 2, 2, 3
; BE-NEXT:    blr
entry:
  %0 = trunc <8 x i32> %a to <8 x i23>
  %1 = icmp eq <8 x i23> %0, zeroinitializer
  %2 = or <8 x i1> %1, <i1 true, i1 true, i1 true, i1 true, i1 false, i1 false, i1 false, i1 false>
  %3 = sext <8 x i1> %2 to <8 x i16>
  ret <8 x i16> %3
}