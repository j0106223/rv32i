	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	__fixdfsi
	.section	.rodata
	.align	2
.LC1:
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
	lui	a5,%hi(.LC0)
	lw	a4,%lo(.LC0)(a5)
	lw	a5,%lo(.LC0+4)(a5)
	sw	a4,-24(s0)
	sw	a5,-20(s0)
	lw	a0,-24(s0)
	lw	a1,-20(s0)
	call	ceil
	mv	a4,a0
	mv	a5,a1
	mv	a0,a4
	mv	a1,a5
	call	__fixdfsi
	mv	a5,a0
	sw	a5,-28(s0)
	addi	a5,s0,-40
	li	a2,10
	mv	a1,a5
	lw	a0,-28(s0)
	call	itoa
	addi	a5,s0,-40
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	print
	lw	a0,-24(s0)
	lw	a1,-20(s0)
	call	floor
	mv	a4,a0
	mv	a5,a1
	mv	a0,a4
	mv	a1,a5
	call	__fixdfsi
	mv	a5,a0
	sw	a5,-28(s0)
	addi	a5,s0,-40
	li	a2,10
	mv	a1,a5
	lw	a0,-28(s0)
	call	itoa
	addi	a5,s0,-40
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	print
	call	finish
	li	a5,0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.align	2
	.globl	print
	.type	print, @function
print:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	j	.L4
.L5:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	_puts
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L5
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
	.section	.rodata
	.align	3
.LC0:
	.word	1293080650
	.word	1074340347
	.ident	"GCC: () 13.2.0"
