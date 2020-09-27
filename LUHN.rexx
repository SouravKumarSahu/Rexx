/* REXX */

say LUHN("0007703122971233009")

WEIGHTED_SUM_OF_DIGITS: /* Provide input number with even length */
ARG numb
check_sum = 0
jj = LENGTH(numb) % 2
DO j=1 TO jj
 num_dig   = numb // 10
 numb      = numb % 10
 check_sum = check_sum + num_dig
 num_dig   = 2 * (numb // 10)
 numb      = numb % 10
 check_sum = check_sum + (num_dig // 10) + (num_dig % 10)
END
RETURN check_sum


LUHN: /* Luhn algo - if valid number returs = 0 */
  ARG cc_num
  checksum = 0
  /*say "cc_num 10 digits = " SUBSTR(cc_num,1,10)
  say "checksum = " WEIGHTED_SUM_OF_DIGITS(SUBSTR(cc_num,1,10))
  say "cc_num 8 digits = " SUBSTR(cc_num,11,8)
  say "checksum = " WEIGHTED_SUM_OF_DIGITS(SUBSTR(cc_num,11,8))
  say "cc_num 1 digits = " SUBSTR(cc_num,19,1)*/
  checksum = checksum + WEIGHTED_SUM_OF_DIGITS(REVERSE(SUBSTR(cc_num,1,10)))
  checksum = checksum + WEIGHTED_SUM_OF_DIGITS(REVERSE(SUBSTR(cc_num,11,8)))
  checksum = checksum + SUBSTR(cc_num,19,1)
  say "checksum = " checksum
RETURN checksum // 10
