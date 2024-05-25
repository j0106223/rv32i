	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	2
.LC1:
	.string	"before sorting\n"
	.align	2
.LC2:
	.string	"after sorting\n"
	.align	2
.LC3:
	.string	"searching for number 7\n"
	.align	2
.LC4:
	.string	"found number 7 in index "
	.align	2
.LC5:
	.string	"\n"
	.align	2
.LC6:
	.string	"cannot found 7 in the item\n"
	.align	2
.LC7:
	.string	"searching for number 20\n"
	.align	2
.LC8:
	.string	"found number 20 in index"
	.align	2
.LC9:
	.string	"cannot found 20 in the item\n"
	.align	2
.LC0:
	.word	9
	.word	8
	.word	7
	.word	6
	.word	5
	.word	4
	.word	3
	.word	2
	.word	1
	.word	0
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96
	sw	ra,92(sp)
	sw	s0,88(sp)
	addi	s0,sp,96
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
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	print
	addi	a5,s0,-80
	li	a1,10
	mv	a0,a5
	call	show_element
	sw	zero,-24(s0)
	j	.L2
.L6:
	sw	zero,-28(s0)
	j	.L3
.L5:
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-64(a5)
	lw	a5,-28(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-64(a5)
	ble	a4,a5,.L4
	lw	a5,-28(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-64(a5)
	sw	a5,-40(s0)
	lw	a5,-28(s0)
	addi	a3,a5,1
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-64(a5)
	slli	a5,a3,2
	addi	a5,a5,-16
	add	a5,a5,s0
	sw	a4,-64(a5)
	lw	a5,-28(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-40(s0)
	sw	a4,-64(a5)
.L4:
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L3:
	lw	a5,-24(s0)
	li	a4,9
	sub	a4,a4,a5
	lw	a5,-28(s0)
	bgtu	a4,a5,.L5
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L2:
	lw	a4,-24(s0)
	li	a5,8
	bleu	a4,a5,.L6
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	print
	addi	a5,s0,-80
	li	a1,10
	mv	a0,a5
	call	show_element
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	print
	sw	zero,-20(s0)
	sw	zero,-32(s0)
	j	.L7
.L9:
	lw	a5,-32(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-64(a5)
	li	a5,7
	bne	a4,a5,.L8
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	print
	lw	a5,-32(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-64(a5)
	addi	a4,s0,-92
	li	a2,10
	mv	a1,a4
	mv	a0,a5
	call	itoa
	addi	a5,s0,-92
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	print
	li	a5,1
	sw	a5,-20(s0)
.L8:
	lw	a5,-32(s0)
	addi	a5,a5,1
	sw	a5,-32(s0)
.L7:
	lw	a4,-32(s0)
	li	a5,9
	bleu	a4,a5,.L9
	lw	a5,-20(s0)
	bne	a5,zero,.L10
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	print
.L10:
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	print
	sw	zero,-20(s0)
	sw	zero,-36(s0)
	j	.L11
.L13:
	lw	a5,-36(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a4,-64(a5)
	li	a5,20
	bne	a4,a5,.L12
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	print
	lw	a5,-36(s0)
	slli	a5,a5,2
	addi	a5,a5,-16
	add	a5,a5,s0
	lw	a5,-64(a5)
	addi	a4,s0,-92
	li	a2,10
	mv	a1,a4
	mv	a0,a5
	call	itoa
	addi	a5,s0,-92
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	print
	li	a5,1
	sw	a5,-20(s0)
.L12:
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L11:
	lw	a4,-36(s0)
	li	a5,9
	bleu	a4,a5,.L13
	lw	a5,-20(s0)
	bne	a5,zero,.L14
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	print
.L14:
	addi	a5,s0,-80
	li	a1,10
	mv	a0,a5
	call	show_element
	call	finish
	li	a5,0
	mv	a0,a5
	lw	ra,92(sp)
	lw	s0,88(sp)
	addi	sp,sp,96
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
.LC10:
	.string	" "
	.text
	.align	2
	.globl	show_element
	.type	show_element, @function
show_element:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L17
.L18:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	addi	a4,s0,-32
	li	a2,10
	mv	a1,a4
	mv	a0,a5
	call	itoa
	addi	a5,s0,-32
	mv	a0,a5
	call	print
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	print
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L17:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L18
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	print
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	show_element, .-show_element
	.align	2
	.globl	print
	.type	print, @function
print:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	j	.L20
.L21:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	_puts
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L20:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L21
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
