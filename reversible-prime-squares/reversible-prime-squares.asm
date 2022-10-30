#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#@ Author: Maime Pheello 					 +
# @Purpose: Reversible-prime-squares                             +  
# @Date: 10 October 20222                                        +
# @Contact: phillipmaime@gmail.com                               +
# @Student ID: 202000484                                         +
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

.data
newline: .asciiz "\n"
niceFormat1: .asciiz "**************10 reversible prime squares************** \n \n"


.text
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# H I G H   L E V E L    M O D E L
#int main()
#{
#	int j = 0;
#	int x,s,l;
#	
#	printf("**************10 reversible prime squares**************\n\n");
#
#
#	for(int i=0; i>=0; i++)
#	{
#		
#		int s = reverse(i);
#
#       if(isPerfect(i) == true && isPerfect(s) == true)
#        {
#            x = squrt(i);
#            l = squrt(s); 
#
#            if(primeCheck(x) == 1 && primeCheck(l)==1)
#            {
#                if(notPalindrome(i))
#                {
#                	
#                   printf("%d",x);
#                    j++;
#                    if(j == 10)
#                    {
#                    	break;
#	             }
#                }
#
#            }
#       }
#			
#	}
#
#	
#	return 0;
#}



main:

li $v0,4
la $a0,niceFormat1
syscall

addi $s1,$0,0   # j
addi $s2,$0,0   # c
addi $s3,$0,0    # x
addi $s4,$0,0    # s
addi $s5,$0,0    # l
addi $t1,$0,10
addi $t3,$zero,0



forloopmain:
move $a1,$s1
beqz $a1,ifstatement1   #if i>=0
j endmain
ifstatement1:
jal Reverse
move $s3,$v1       # s = reverve(i)
move $v1,$zero
move $a1,$s1
jal isPerfect
move $t2,$v0
move $v0,$zero
beq $t2,$t3,ifstatement2     #is  isPerfect(i) == true && isPerfect(s) == true
j loooopend
ifstatement2:
move $a1,$s3
jal isPerfect
move $t2,$v0
move $v0,$zero
beq $t2,$t3,ifstatement3
j loooopend
ifstatement3:
move $a1,$s1
jal square_root
move $s4,$v1
move $v1,$zero
move $a1,$s3
jal square_root
move $s5,$v1
move $v1,$zero
move $a1,$s4
jal primeCheck
move $t2,$v0
move $v0,$zero
beq $t2,$t3,ifstatement4
j loooopend
ifstatement4:
move $a1,$s5
jal primeCheck
move $t2,$v0
move $v0,$zero
beq $t2,$t3,ifstatement5		
j loooopend
ifstatement5:
bne $s1,$s3,lastExe
j loooopend
lastExe:
li $v0,1
add $a0,$zero,$s1
syscall
addi $s2,$s2,1
li $v0,4
la $a0,newline
syscall
beq $s2,$t1,endmain
j loooopend	
loooopend:
addi $s1,$s1,1
move $v1,$zero
move $v0,$zero
move $a1,$zero
move $t2,$zero
move $s3,$zero
move $v0,$zero
j forloopmain


endmain:

li $v0,10
syscall
#*******************
# REVERSE FUNCTION
#*******************

#  int reverse(int num)
#  {
#   int r;                     
#   int reverse=0;
#   
#      while(num!=0)
#	{
#           r=num%10;
#	   reverse= (reverse*10)+r;
#	   num=num/10;
#	}
#	return reverse;	
#  }
# L O W    L E V E L

Reverse:
addi $sp,$sp,-20
# sw $a1,12($sp)        #$a1 = num
sw $t1,0($sp)
sw $t2,4($sp)
sw $t3,8($sp)
sw $t4,16($sp)
#set this 5 temp reg to zero
move $t1,$0               # $t1 = reverse
move $t2,$0               # $t2 = r
move $t3,$0                   
move $t4,$0
move $t5,$0
addi $t3,$0,10            # $t3 = 10
L1:
beqz $a1,end   # check whether num == 0? in not execute the next line
div $a1,$t3    # num%10
mfhi $t2       
mul $t4,$t1,$t3    # $t4 = reverse * 10
add $t1,$t4,$t2    # reverse= (reverse*10)+r
div $a1,$t3
mflo $a1
j L1

end:
add $v1,$0,$t1

#lw $a1,12($sp)
lw $t1,0($sp)
lw $t2,0($sp)
lw $t3,0($sp)
lw $t4,0($sp)
addi $sp,$sp,20
jr $ra

#************************
# END OF REVERSE FUNCTION
#************************


#************************
#PRIME CHECK FUNCTION
#***********************

#++++++++++++++++++++++++
# H I G H   L E V E L

#bool primeCheck(int num)
#{
#	bool isPrime=true;
#	
#	if(num==0 || num==1 )
#	{
#		isPrime = false;
#	}
#	
#	for(int i=2; i <= num/2; i++)
#	{
#		if(num%i == 0)
#		{
#			isPrime = false;
#			break;
#		}
#		
#	}
#	return isPrime;
#}
#L O W   L E V E L

primeCheck:
addi	$sp,$sp,-24
#sw	$a1,12($sp)
sw	$t1,0($sp)
sw	$t2,4($sp)	#isTrue
sw	$t3,8($sp)
sw	$t4,16($sp)
sw	$t5,20($sp)
#set temp reg from reg 1 to 5 to zero
move $t1,$0
move $t2,$0
move $t3,$0
move $t4,$0
move $t5,$0
addi $t1,$0,1      #$t1 = 1
addi $t2,$0,1
addi $t3,$0,2	# $t3 = i = 2

beqz $a1,go          #$a1 = num  #if num == 0
beq $a1,$t1,go	                 #if num == 1

div $a1,$t3        # num/2
mflo $t4           # $s4 = num/2
j forloop

forloop:
ble $t3,$t4, L2
j end2

L2: 
div $a1,$t3      #num%i
mfhi $t5         # $t5 = num%i
j iff
iff:
beqz,$t5,go     #if num%i == 0
j loopf
loopf:
addi $t3,$t3,1    #incrementing i
move $t5,$zero    
j forloop

go:
move $t2,$0      #isPrime = 0
j end2
end2:
move $v0,$t2
#lw	$a1,12($sp)
lw $t1,0($sp)
lw $t2,4($sp)	#isTrue
lw $t3,8($sp)
lw $t4,16($sp)
lw $t5,20($sp)
addi $sp,$sp,24
jr	$ra
#*******************
# END OF PRIME CHECK
#*******************



#**************************
# NOT PALINNDROME FUNCTION
#**************************

#++++++++++++++++++++++++
# H I G H   L E V E L

#bool notPalindrome(int num)
#{
#	bool isPalindrome = true;
#	if(reverse(num) == num)
#	{
#		isPalindrome = false;
#	}
#	return isPalindrome;
#}

# L O W   L E V E L    I M P L I M E N T A T I O N

notPalindrome:
addi $sp,$sp,-24
#sw $a1,12($sp)
sw $t1,0($sp)
sw $t2,4($sp)
sw $t3,8($sp)
sw $t4,16($sp)
sw $t5,20($sp)
#set temp reg from reg 1 to 5 to zero
move $t1,$0
move $t2,$0
move $t3,$0
move $t4,$0
move $t5,$0

addi	$t2,$t0,1
jal	Reverse

addi	$sp,$sp,-24
#sw	$a1,12($sp)
sw $t1,0($sp)
sw $t2,4($sp)	
sw $t3,8($sp)
sw $t4,16($sp)
sw $t5,20($sp)
#set temp reg from reg 1 to 5 to zero
move $t1,$0
move $t2,$0      # $t2 = isPalindrome
move $t3,$0
move $t4,$0
move $t5,$0
addi $t2,$t0,1

beq $v1,$a1,return1      # $a1 = num, $v1 = reverse(num)    if(reverse(num)==num), go toreturn1
j end3
return1:
move $t2,$0           #isPalindrome = 0 
j end3
end3:
move	$v0,$t2        # return isPalindrome
#lw	$a1,12($sp)
lw	$t1,0($sp)
lw	$t2,4($sp)	
lw	$t3,8($sp)
lw	$t4,16($sp)
#lw	$t5,20($sp)
addi	$sp,$sp,24
jr	$ra	

#**********************
# END Of NOTPALINDROME
#**********************


#*********************
# IS PERFECT FUNCTION
#*********************

#++++++++++++++++++++++++
# H I G H   L E V E L

#bool isPerfect(int num)
#{
#    for(int i=1; i*i <= num; i++ )
#    {
#        if((num % i == 0) && (num / i == i))
#        {
#            return true;
#            printf("%d",num);
#        }
#    }
#
#    return false;
#}
# L O W   L E V E L    I M P L I M E N T A T I O N
isPerfect:
addi	$sp,$sp,-24
#sw	$a1,12($sp)
sw $t1,0($sp)	#i
sw $t2,4($sp)	
sw $t3,8($sp)
sw $t4,16($sp)
sw $t5,20($sp)
sw $t6,28($sp)
#set temp reg from 1 to 6 to zero to clear any data in them
move $t1,$0
move $t2,$0
move $t3,$0
move $t4,$0
move $t5,$0
move $t6,$0

addi $t1,$0,1      #set $t1 = int i = 1
forl:
mul $t2, $t1,$t1     #i*i
ble $t2,$a1,L3       #if (i*i <= num) go to L3
j returnFalse
L3:
div $a1,$t1      
mfhi $t4        #store the remainder in $t4 //(num%i == 0)
mflo $t5        #store the quatioent in $t5 //(num/i == i)

beqz $t4,Ifstatement2     # if(num%i == 0)
j loopend
Ifstatement2:
beq $t5,$t1,returnTrue    #if(num/i == i)
j loopend
returnTrue:
addi $t6,$0,1
j end4
loopend:
addi $t1,$t1,1
j forl
returnFalse:
addi $t6,$0,0
j end4
end4:
add $v0,$0,$t6

lw $t1,0($sp)
lw $t2,4($sp)	
lw $t3,8($sp)
lw $t4,16($sp)
lw $t5,20($sp)
lw $t6,28($sp)
addi $sp,$sp,24
jr $ra
	
#**************************
#ENF OF IS PERFECT FUNCTION
#**************************



#**************************
# SQUARE ROOT FUNCTION
#**************************

#++++++++++++++++++++++++
# H I G H   L E V E L
#int squrt(int x)
#{
#	if(x==0)
#	{
#		return x;
#	}
#       if(x==1)
#       {
#               return x
#	}
#	while (result<= x)
#	{
#		i++;
#		result = i * i;
#	}
#	return i - 1;
#}

#L O W   L E V E L
square_root:
addi $sp,$sp,-24
sw $a1,12($sp)	
sw $t1,0($sp)	
sw $t2,4($sp)		
sw $t3,8($sp)	
sw $t4,16($sp)
sw $t5,20($sp)
#set temp reg from 1 to 5 to zero to clear any data in them
li $t1,1
addi $t2,$0,0    # result
addi $t3,$0,0     # i
li $t4,0          # i - 1
move $t5,$0
beqz $a1,goo
beq $a1,$t1,goo
j return_square
goo:
move $v0,$a1
jr $ra
while1:
ble $a2,$a1,looop
j return_square
looop:
addi $t3,$t3,1
mul $t2,$t3,$t3
j while1
subi $t4,$t3,1
return_square:
move $v0,$t4
jr $ra

lw $t1,0($sp)
lw $t2,4($sp)	
lw $t3,8($sp)
lw $t4,16($sp)
lw $t5,20($sp)
addi $sp,$sp,24
jr $ra		

#****************************
#END OF SQUARE ROOT FUNCTION
#****************************













