/* REXX */
/**************************** REXX *********************************/
/* Rexx program to generate valid credit card numbers              */
/*******************************************************************/
"FREE FI(outdd)"
"ALLOC FI(outdd) DA('Z00894.OUTPUT(CUST16)') SHR REUSE"
eofflag = 2                 /* Return code to indicate end-of-file */
return_code = 0                /* Initialize return code           */
out_ctr = 0                    /* Initialize # of lines written    */
stop_cnt = 0


/*******************************************************************/
/* CC Generator is here                                            */
/*******************************************************************/

DO WHILE (out_ctr < 501 & stop_cnt < 600)
 stop_cnt = stop_cnt + 1
 /* random cc 15 digit number generator */
 cc_num = RANDOM(10000,99999,stop_cnt)
 cc_num = cc_num||RANDOM(10000,99999,stop_cnt)
 cc_num = cc_num||RANDOM(10000,99999,stop_cnt)
 cc_num = "000"||cc_num
 /* check digit number generator */
 cc_num = CHECKSUMGEN(cc_num)

 /* validated cc number with Luhn algo */
 z=LUHN(cc_num)
 
 IF z = 0 THEN
  DO
  out_ctr = out_ctr + 1
  line.out_ctr = VALUE(cc_num)
  END

END
line.0 = out_ctr
"EXECIO * DISKW outdd (FINIS STEM line." /* Write it to outdd   */
return_code = rc
say "file write code = " return_code


IF out_ctr > 0 THEN             /* Were any lines written to outdd?*/
  DO                               /* Yes.  So outdd is now open   */
  "EXECIO 0 DISKW outdd (FINIS" /* Closes the open file, outdd     */
  SAY 'File outdd now contains ' out_ctr' lines.'
 END
ELSE                         /* Else no new lines have been        */
  DO                         /* Erase any old records from the file*/
   "EXECIO 0 DISKW outdd (OPEN FINIS"  /*Empty the outdd file      */
   SAY 'File outdd is now empty.'
  END
"FREE FI(outdd)"
/* say "hi"
say LUHN("0007703122971233009")
say CHECKSUMGEN("000770312297123300")
say LUHN("0009278807244632893")
say CHECKSUMGEN("000927880724463289")
say LUHN("0007703122971233009")
say CHECKSUMGEN("000770312297123300") */

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
  /* say "checksum = " checksum */
RETURN checksum // 10


CHECKSUMGEN: /* CC checksum gen using Luhn logic */
 ARG full_cc_num
 checksum = 0
  /*say "cc_num 10 digits = " SUBSTR(cc_num,1,10)
  say "checksum = " WEIGHTED_SUM_OF_DIGITS(SUBSTR(cc_num,1,10))
  say "cc_num 8 digits = " SUBSTR(cc_num,11,8)
  say "checksum = " WEIGHTED_SUM_OF_DIGITS(SUBSTR(cc_num,11,8))
  say "cc_num 1 digits = " SUBSTR(cc_num,19,1)*/
  checksum = checksum + WEIGHTED_SUM_OF_DIGITS(REVERSE(SUBSTR(cc_num,1,10)))
  checksum = checksum + WEIGHTED_SUM_OF_DIGITS(REVERSE(SUBSTR(cc_num,11,8)))
  checksum = 10 - (checksum // 10)
  full_cc_num = full_cc_num || checksum
RETURN full_cc_num



