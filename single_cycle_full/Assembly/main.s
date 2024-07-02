	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	li	a5,10
	sw	a5,-20(s0)
	li	a5,20
	sw	a5,-24(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	add	a5,a4,a5
	sw	a5,-28(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	sub	a5,a4,a5
	sw	a5,-32(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	or	a5,a4,a5
	sw	a5,-36(s0)
	lw	a4,-20(s0)
	lw	a5,-24(s0)
	and	a5,a4,a5
	sw	a5,-40(s0)
	li	a5,0
	mv	a0,a5
	lw	s0,44(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
