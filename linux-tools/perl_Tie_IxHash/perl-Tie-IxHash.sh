#!/bin/bash
############################################################################################
## Copyright 2003, 2015 IBM Corp                                                          ##
##                                                                                        ##
## Redistribution and use in source and binary forms, with or without modification,       ##
## are permitted provided that the following conditions are met:                          ##
##    1.Redistributions of source code must retain the above copyright notice,            ##
##        this list of conditions and the following disclaimer.                           ##
##    2.Redistributions in binary form must reproduce the above copyright notice, this    ##
##        list of conditions and the following disclaimer in the documentation and/or     ##
##        other materials provided with the distribution.                                 ##
##                                                                                        ##
## THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS AND ANY EXPRESS       ##
## OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF        ##
## MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ##
## THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,    ##
## EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF     ##
## SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ##
## HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,  ##
## OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  ##
## SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                           ##
############################################################################################
## File :       perl-Tie-IxHash.sh                                                        ##
##                                                                                        ##
## Description: Test for perl-Tie-IxHash package                                          ##
##                                                                                        ##
## Author:      Avinesh Kumar <avinesku at linux.vnet.ibm.com>                            ##
##                                                                                        ##
###########################################################################################

#cd $(dirname $0)
#LTPBIN=${PWD%%/testcases/*}/testcases/bin
MAPPER_FILE="$LTPBIN/mapper_file"
source $LTPBIN/tc_utils.source
source  $MAPPER_FILE
TESTS_DIR="${LTPBIN%/shared}/perl_Tie_IxHash"
REQUIRED="perl"

function tc_local_setup()
{
        tc_exec_or_break $REQUIRED || return
}

function install_check()
{
        tc_check_package "$PERL_TIE_IXHASH"
        tc_break_if_bad $? "$PERL_TIE_IXHASH is not installed"
}

function run_test()
{
        pushd $TESTS_DIR >$stdout 2>$stderr
        TESTS=`ls t/*.t`
        TST_TOTAL=`echo $TESTS | wc -w`
        for test in $TESTS; do
                tc_register "Test $test"
                grep -Eq "#!perl -T" "$test"
                if [ $? -ne 0 ];then
                	perl $test >$stdout 2>$stderr
		else
			perl -T $test >$stdout 2>$stderr
		fi
                tc_pass_or_fail $? "$test failed"
        done
        popd >$stdout 2>$stderr
}

#
# main
#
tc_setup
install_check && run_test
