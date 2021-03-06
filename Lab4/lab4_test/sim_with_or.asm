# 本文档存储器以字编址
# 本文档存储器以字编址
# 本文档存储器以字编址
# 初始PC = 0x00000000

  
	j _start	# 0 0800000b

.data
    .word 0,6,0,8,0x80000000,0x80000100,0x100,5,0,0,0   #编译成机器码时，编译器会在前面多加个0，所以后面lw指令地址会多加4

_start:    
		addi $t0,$0,3       	#t0=3  	44						 		20080003
        addi $t1,$0,5   		#t1=5	48								20090005
		addi $t2,$0,1       	#t2=1	52								200a0001
		addi $t3,$0,0			#t3=0	56								200b0000
		
        add  $s0,$t1,$t0  		#s0=t1+t0=8  测试add指令	60			 01288020
        lw   $s1,12($0)  		#							64			8c11000c
        beq  $s1,$s0,_next1		#正确跳到_next 				68			 12300001
		
		j _fail													#		0800001b

_next1:	
		lw $t0, 16($0)			#t0 = 0x80000000	76					8c080010
		lw $t1, 20($0)			#t1 = 0x80000100	80					8c090014
		
		add  $s0,$t1,$t0		#s0 = 0x00000100 = 256	84				01288020
		lw $s1, 24($0)			#						88				8c110018
        beq  $s1,$s0,_next2		#正确跳到_success		92				 12300001
		
		j _fail														#	0800001b

_next2:
		or $0, $0, $t2			#$0应该一直为0			100				 000a0020
		beq $0,$t3,_success		#						104				100b0002
		
		
_fail:  
		sw   $t3,8($0) #失败通过看存储器地址0x08里值，若为0则测试不通过，最初地址0x08里值为0 108	ac0b0008
        j    _fail													#	0800001b

_success: 
		sw   $t2,8($0)    #全部测试通过，存储器地址0x08里值为1	116		   ac0a0008
		j   _success       											#   0800001d

					  #判断测试通过的条件是最后存储器地址0x08里值为1，说明全部通过测试
					  	