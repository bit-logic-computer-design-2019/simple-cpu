main:
        addiu   $sp,$sp,-32
        sw      $fp,28($sp)
        move    $fp,$sp
        sw      $0,8($fp)
        li      $2,1                        # 0x1
        sw      $2,12($fp)
$L4:
        li      $2,99942400       # 0x5f50000
        ori     $2,$2,0xe100
        sw      $2,16($fp)
$L3:
        lw      $2,16($fp)
        nop
        addi   $3,$2,-1
        sw      $3,16($fp)
        sltu    $2,$0,$2
        andi    $2,$2,0x00ff
        beq     $2,$0,$L2
        nop

        b       $L3
        nop

$L2:
        lw      $2,12($fp)
        nop
        sw      $2,20($fp)
        lw      $3,12($fp)
        lw      $2,8($fp)
        nop
        addu    $2,$3,$2
        sw      $2,12($fp)
        lw      $2,12($fp)
        nop
        sw      $2,8($fp)
        b       $L4
        nop