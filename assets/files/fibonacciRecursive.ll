declare i32 @printf(i8*, ...)declare i32 @__isoc99_scanf(i8*, ...)
@.str.1 = private unnamed_addr constant [16 x i8] c"Enter a number:\00"
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00"
@.str.3 = private unnamed_addr constant [15 x i8] c"fib(%d)\09= %d;\0A\00"


; define function f
define i32 @f(i32) {
	; allocate %a0
		%a0 = alloca i32
	; store %0 in %a0
		store i32 %0, i32* %a0
	; load %a0 in %t2
		%t2 = load i32, i32* %a0
	; %t1 = %t2 < 2
		%t1 = icmp slt i32 %t2, 2
	; branch to l1 if %t1 is true, else branch to l2
		br i1 %t1, label %l1, label %l2

; if %t1 is true
l1:
	; load %a0 in %t3
		%t3 = load i32, i32* %a0
	; return register %t3
		ret i32 %t3
	; branch to l3
		br label %l3

; if %t1 is false
l2:
	; load %a0 in %t5
		%t5 = load i32, i32* %a0
	; %t4 = %t5 - 1
		%t4 = sub i32 %t5, 1
	; call function f in %t6
		%t6 = call i32 @f(i32 %t4)
	; load %a0 in %t8
		%t8 = load i32, i32* %a0
	; %t7 = %t8 - 2
		%t7 = sub i32 %t8, 2
	; call function f in %t9
		%t9 = call i32 @f(i32 %t7)
	; %t10 = %t6 + %t9
		%t10 = add i32 %t6, %t9
	; return register %t10
		ret i32 %t10
	; branch to l3
		br label %l3

; exit
l3:
	; return register 0
		ret i32 0
}

; define function main
define i32 @main() {
	; allocate %t11
		%t11 = alloca i32
	; print
		%t12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8],[16 x i8]* @.str.1,i32 0, i32 0))
	; get adress of %t11
		%t13 = getelementptr i32, i32* %t11
	; scan
		%t14 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8],[3 x i8]* @.str.2,i32 0, i32 0), i32* %t13)
	; allocate %t15
		%t15 = alloca i32
	; store 1 in %t15
		store i32 1, i32* %t15
	; branch to l4
		br label %l4

; while header
l4:
	; load %t15 in %t16
		%t16 = load i32, i32* %t15
	; %t17 = %t16 + 1
		%t17 = add i32 %t16, 1
	; store %t17 in %t15
		store i32 %t17, i32* %t15
	; load %t11 in %t19
		%t19 = load i32, i32* %t11
	; %t18 = %t16 <= %t19
		%t18 = icmp sle i32 %t16, %t19
	; branch to l5 if %t18 is true, else branch to l6
		br i1 %t18, label %l5, label %l6

; while body
l5:
	; load %t15 in %t21
		%t21 = load i32, i32* %t15
	; call function f in %t20
		%t20 = call i32 @f(i32 %t21)
	; load %t15 in %t22
		%t22 = load i32, i32* %t15
	; print
		%t23 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8],[15 x i8]* @.str.3,i32 0, i32 0), i32 %t22, i32 %t20)
	; branch to l4
		br label %l4

; exit
l6:
	; return register 0
		ret i32 0
}
