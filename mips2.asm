# addu subu ori lw sw beq j

ori     $s0,$s0,1
ori     $s1,$s1,5
ori     $s2,$s2,1
ori     $s3,$s3,6
ori     $s4,$s4,1
ori     $s5,$s5,7
ori     $s6,$s6,0
ori     $s7,$s7,2

addu    $t0,$s1,$s4
addu    $t1,$s2,$s5
subu    $t2,$s1,$s3
addu    $t3,$s3,$s4
addu    $t4,$s5,$s3
subu    $t5,$s4,$s2

sw      $s7,0($0)
lw      $t7,0($0)

loop:
addu    $s0,$s0,$s2

addu    $t0,$t0,$t5
subu    $t2,$t2,$t3
addu    $t3,$t3,$s2
subu    $t1,$t1,$s4
addu    $t4,$t4,$t0

beq     $s0,$s7,loop

j		target				# jump to target

ori     $s6,$s6,0x233

target:
