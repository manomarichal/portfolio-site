.data
	fpzero: .float 0.0
	fpone: .float 1.0
	fpminone: .float -1.0
	s0: .asciiz "Enter a number:\00"
	s1: .asciiz "fib("
	s2: .asciiz ")\t= "
	s3: .asciiz ";\n\00""
.text
.globl main

jal main
beq $zero, $zero, exit


# define function f
f:
	addi $sp, $sp, -44
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	li $t0, 2
	sw $t0, 8($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	blt $t1, $t2, l6
	beq $zero, $zero, l5

# not true
l5:
	li $t0, 0
	beq $zero, $zero, l7

# true
l6:
	li $t0, 1
	beq $zero, $zero, l7

# exit comparison
l7:
	sw $t0, 12($sp)
	lw $t0, 12($sp)
	beq $t0, $zero l3
	beq $zero, $zero, l2

# if true
l2:
	lw $v0, 4($sp)
	beq $zero, $zero, l1
	beq $zero, $zero, l4

# if false
l3:
	li $t1, 1
	sw $t1, 16($sp)
	lw $t2, 4($sp)
	lw $t3, 16($sp)
	sub $t1, $t2, $t3
	sw $t1, 20($sp)
	lw $a0, 20($sp)
	jal f
	sw $v0, 24($sp)
	li $t0, 2
	sw $t0, 28($sp)
	lw $t1, 4($sp)
	lw $t2, 28($sp)
	sub $t0, $t1, $t2
	sw $t0, 32($sp)
	lw $a0, 32($sp)
	jal f
	sw $v0, 36($sp)
	lw $t1, 24($sp)
	lw $t2, 36($sp)
	add $t0, $t1, $t2
	sw $t0, 40($sp)
	lw $v0, 40($sp)
	beq $zero, $zero, l1
	beq $zero, $zero, l4

# exit
l4:

# return from function f
l1:
	lw $ra, 0($sp)
	addi $sp, $sp, 44
	jr $ra

# define function main
main:
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	la $a0, s0
	li $v0, 4
	syscall
	la $t0, 4($sp)
	sw $t0, 8($sp)
	li $v0, 5
	syscall
	lw $t0, 8($sp)
	sw $v0, 0($t0)
	li $t0, 1
	sw $t0, 16($sp)
	lw $t0, 16($sp)
	sw $t0, 12($sp)
	beq $zero, $zero, l9

# while header
l9:
	lw $t0, 12($sp)
	addi $t1, $t0, 1
	sw $t1, 12($sp)
	sw $t0, 20($sp)
	lw $t1, 20($sp)
	lw $t2, 4($sp)
	ble $t1, $t2, l13
	beq $zero, $zero, l12

# not true
l12:
	li $t0, 0
	beq $zero, $zero, l14

# true
l13:
	li $t0, 1
	beq $zero, $zero, l14

# exit comparison
l14:
	sw $t0, 24($sp)
	lw $t0, 24($sp)
	beq $t0, $zero l11
	beq $zero, $zero, l10

# while body
l10:
	lw $a0, 12($sp)
	jal f
	sw $v0, 28($sp)
	la $a0, s1
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, 12($sp)
	syscall
	la $a0, s2
	li $v0, 4
	syscall
	li $v0, 1
	lw $a0, 28($sp)
	syscall
	la $a0, s3
	li $v0, 4
	syscall
	beq $zero, $zero, l9

# exit
l11:
	li $t0, 0
	sw $t0, 32($sp)
	lw $v0, 32($sp)
	beq $zero, $zero, l8

# return from function main
l8:
	lw $ra, 0($sp)
	addi $sp, $sp, 36
	jr $ra

exit: