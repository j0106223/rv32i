	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	2
.LC0:
	.string	"\n"
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a0,-20(s0)
	call	fibonacci
	sw	a0,-24(s0)
	addi	a5,s0,-36
	li	a2,10
	mv	a1,a5
	lw	a0,-24(s0)
	call	itoa
	addi	a5,s0,-36
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	print
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L3
	call	finish
	li	a5,0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.align	2
	.globl	fibonacci
	.type	fibonacci, @function
fibonacci:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	beq	a5,zero,.L6
	lw	a4,-20(s0)
	li	a5,1
	bne	a4,a5,.L7
.L6:
	lw	a5,-20(s0)
	j	.L8
.L7:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	mv	a0,a5
	call	fibonacci
	mv	s1,a0
	lw	a5,-20(s0)
	addi	a5,a5,-2
	mv	a0,a5
	call	fibonacci
	mv	a5,a0
	add	a5,s1,a5
.L8:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	addi	sp,sp,32
	jr	ra
	.size	fibonacci, .-fibonacci
	.align	2
	.globl	print
	.type	print, @function
print:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	j	.L10
.L11:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	_puts
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L10:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L11
	nop
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	print, .-print
	.align	2
	.globl	_puts
	.type	_puts, @function
_puts:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	li	a5,134217728
	lbu	a4,-17(s0)
	sw	a4,0(a5)
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	_puts, .-_puts
	.ident	"GCC: () 13.2.0"
