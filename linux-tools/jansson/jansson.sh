#!/bin/bash
###########################################################################################
## Copyright 2003, 2015 IBM Corp                                                          ##
##                                                                                        ##
## Redistribution and use in source and binary forms, with or without modification,       ##
## are permitted provided that the following conditions are met:                          ##
##	1.Redistributions of source code must retain the above copyright notice,          ##
##        this list of conditions and the following disclaimer.                           ##
##	2.Redistributions in binary form must reproduce the above copyright notice, this  ##
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
### File : jansson.sh                                                          ##
##
### Description: Test for jansson package                                      ##
##
### Author:      Hariharan T S <harihare@in.ibm.com>                           ##
###########################################################################################

#cd $(dirname $0)
#LTPBIN=${LTPBIN%/shared}/jansson
source $LTPBIN/tc_utils.source
TESTS_DIR="${LTPBIN%/shared}/jansson"
export top_srcdir=$TESTS_DIR

function tc_local_setup()
{
      tc_check_package jansson
        tc_break_if_bad $? "jansson not installed" || return
}

function run_test()
{
    pushd $TESTS_DIR/test >$stdout 2>$stderr
    TESTS=`ls -d suites/*/ | cut -d "/" -f 2`
    TST_TOTAL=`echo $TESTS | wc -w`
    for test in $TESTS; do
        tc_register "TestSuite $test"
        ./run-suites $test >$stdout 2>$stderr
        tc_pass_or_fail $? "$test failed"
    done
    popd >$stdout 2>$stderr
}
#
# main
#
tc_setup
run_test
