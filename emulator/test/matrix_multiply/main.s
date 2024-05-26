	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	__mulsi3
	.section	.rodata
	.align	2
.LC1:
	.string	"\n"
	.align	2
.LC0:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-528
	sw	ra,524(sp)
	sw	s0,520(sp)
	sw	s1,516(sp)
	addi	s0,sp,528
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	lw	t3,0(a5)
	lw	t1,4(a5)
	lw	a7,8(a5)
	lw	a6,12(a5)
	lw	a0,16(a5)
	lw	a1,20(a5)
	lw	a2,24(a5)
	lw	a3,28(a5)
	lw	a4,32(a5)
	lw	a5,36(a5)
	sw	t3,-80(s0)
	sw	t1,-76(s0)
	sw	a7,-72(s0)
	sw	a6,-68(s0)
	sw	a0,-64(s0)
	sw	a1,-60(s0)
	sw	a2,-56(s0)
	sw	a3,-52(s0)
	sw	a4,-48(s0)
	sw	a5,-44(s0)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	lw	t3,0(a5)
	lw	t1,4(a5)
	lw	a7,8(a5)
	lw	a6,12(a5)
	lw	a0,16(a5)
	lw	a1,20(a5)
	lw	a2,24(a5)
	lw	a3,28(a5)
	lw	a4,32(a5)
	lw	a5,36(a5)
	sw	t3,-120(s0)
	sw	t1,-116(s0)
	sw	a7,-112(s0)
	sw	a6,-108(s0)
	sw	a0,-104(s0)
	sw	a1,-100(s0)
	sw	a2,-96(s0)
	sw	a3,-92(s0)
	sw	a4,-88(s0)
	sw	a5,-84(s0)
	addi	a5,s0,-520
	li	a4,400
	mv	a2,a4
	li	a1,0
	mv	a0,a5
	call	memset
	sw	zero,-20(s0)
	j	.L2
.L5:
	sw	zero,-24(s0)
	j	.L3
.L4:
	lw	a5,-20(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a3,-64(a5)
	lw	a5,-24(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a2,-104(a5)
	lw	a4,-20(s0)
	mv	a5,a4
	slli	a5,a5,2
	add	a5,a5,a4
	slli	a5,a5,1
	mv	a4,a5
	lw	a5,-24(s0)
	add	s1,a4,a5
	mv	a1,a2
	mv	a0,a3
	call	__mulsi3
	mv	a5,a0
	mv	a4,a5
	slli	a5,s1,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-504(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L3:
	lw	a4,-24(s0)
	li	a5,9
	ble	a4,a5,.L4
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
	li	a5,9
	ble	a4,a5,.L5
	sw	zero,-28(s0)
	j	.L6
.L7:
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-504(a5)
	addi	a4,s0,-40
	li	a2,10
	mv	a1,a4
	mv	a0,a5
	call	itoa
	addi	a5,s0,-40
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	print
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L6:
	lw	a4,-28(s0)
	li	a5,99
	ble	a4,a5,.L7
	call	finish
	li	a5,0
	mv	a0,a5
	lw	ra,524(sp)
	lw	s0,520(sp)
	lw	s1,516(sp)
	addi	sp,sp,528
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
