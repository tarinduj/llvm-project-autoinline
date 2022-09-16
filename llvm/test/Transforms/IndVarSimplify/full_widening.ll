; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -indvars -S | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"

; Make sure that we do not insert trunc in the loop.
define i32 @test_01(double* %p, double %x, i32* %np, i32* %mp, i32 %k) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp sgt i32 [[K:%.*]], 1
; CHECK-NEXT:    [[SMAX:%.*]] = select i1 [[TMP0]], i32 [[K]], i32 1
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[SMAX]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV_WIDE:%.*]] = phi i64 [ [[CANONICAL_IV_NEXT_I:%.*]], [[LOOP]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[CANONICAL_IV_NEXT_I]] = add nuw nsw i64 [[IV_WIDE]], 1
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr inbounds double, double* [[P:%.*]], i64 [[IV_WIDE]]
; CHECK-NEXT:    [[LOAD:%.*]] = load atomic double, double* [[GEP]] unordered, align 8
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[X:%.*]], [[LOAD]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds double, double* [[P]], i64 [[IV_WIDE]]
; CHECK-NEXT:    store atomic double [[MUL]], double* [[GEP2]] unordered, align 8
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[CANONICAL_IV_NEXT_I]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[LOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop

loop:
  %iv.wide = phi i64 [ %canonical.iv.next.i, %loop ], [ 0, %entry ]
  %iv.narrow = phi i32 [ %iv.narrow.next, %loop ], [ 0, %entry ]
  %canonical.iv.next.i = add nuw nsw i64 %iv.wide, 1
  %zext = zext i32 %iv.narrow to i64
  %gep = getelementptr inbounds double, double* %p, i64 %zext
  %load = load atomic double, double* %gep unordered, align 8
  %mul = fmul double %x, %load
  %gep2 = getelementptr inbounds double, double* %p, i64 %zext
  store atomic double %mul, double* %gep2 unordered, align 8
  %iv.narrow.next = add nuw nsw i32 %iv.narrow, 1
  %loop.cond = icmp slt i32 %iv.narrow.next, %k
  br i1 %loop.cond, label %loop, label %exit

exit:
  ret i32 0
}
