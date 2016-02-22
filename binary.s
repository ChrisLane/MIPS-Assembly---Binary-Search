#======= Declare all variables =======#
	.data
	
msg_inputList: 	.asciiz "Please enter positive numbers in ascending order and a 0 to terminate\n"
msg_searchList:	.asciiz "Please enter a number to search for\n"
msg_YES:		.asciiz "YES\n"
msg_NO:			.asciiz "NO\n"

#=====================================#


# Program code
	.text
	.globl main
	
#===============================================================#
main:
	# Print list input instruction
	li $v0, 4 				# syscall 4 (print_str)
	la $a0, msg_inputList 	# argument: list input string
	syscall					# print the list input string
	
	# Initialise counter
	li $s0, 0				# start counter at 1

#===============================================================#

inputList:
	# Take user input
	li $v0, 5				# syscall 5 (read_int)
	syscall					# take user integer input
	move $t0, $v0			# move user input to temporary value
	
	# Continue to search if input was 0
	beqz $t0, searchList	# if 0, begin the search step
	
	# Input wasn't 0, store value
	li $a0, 4				# 4 bytes for an integer
	li $v0, 9				# syscall 9 (sbrk)
	syscall					# allocate memory for integer
	sw $t0, ($v0)			# store the integer
	
	# Increment counter
	addi $s0, $s0, 1			# add 1 to the counter
	
	# Take next input
	j inputList				# loop back to user input

#===============================================================#

exit:
	# Exit the program
	li $v0, 10				# syscall 10 (exit)
	syscall					# exit the program