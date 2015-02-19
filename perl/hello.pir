.include 'cclass.pasm'
.include 'except_severity.pasm'
.include 'except_types.pasm'
.include 'iglobals.pasm'
.include 'interpinfo.pasm'
.include 'iterator.pasm'
.include 'sysinfo.pasm'
.include 'stat.pasm'
.include 'datatypes.pasm'

.HLL "perl6"

.namespace []
.sub "_block1000"  :anon :subid("11_1372703217.59042")
.annotate 'file', "hello.pl"
.annotate 'line', 0
    .const 'Sub' $P1003 = "10_1372703217.59042" 
    capture_lex $P1003
.annotate 'line', 1
.annotate 'file', 'hello.pl'
    .const 'Sub' $P1003 = "10_1372703217.59042" 
    capture_lex $P1003
    $P108 = $P1003()
    .return ($P108)
    .const 'Sub' $P1021 = "12_1372703217.59042" 
    .return ($P1021)
.end


.HLL "perl6"

.loadlib "nqp_group"

.loadlib "nqp_ops"

.loadlib "perl6_group"

.loadlib "perl6_ops"

.loadlib "bit_ops"

.loadlib "math_ops"

.loadlib "trans_ops"

.loadlib "io_ops"

.loadlib "obscure_ops"

.loadlib "os"

.loadlib "file"

.loadlib "sys_ops"

.loadlib "nqp_bigint_ops"

.loadlib "nqp_dyncall_ops"

.namespace []
.sub "_block1002"  :anon :subid("10_1372703217.59042") :outer("11_1372703217.59042")
.annotate 'file', "hello.pl"
.annotate 'line', 1
    .lex "GLOBALish", $P1004
    .lex "EXPORT", $P1005
    .lex "$?PACKAGE", $P1006
    .lex "::?PACKAGE", $P1007
    .lex "$_", $P1008
    .lex "$/", $P1009
    .lex "$!", $P1010
    .lex "$=POD", $P1011
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    nqp_get_sc_object $P100, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 9
.annotate 'line', 3
    nqp_get_sc_object $P101, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 8
    $P102 = "&say"($P101)
.annotate 'line', 1
    .return ($P102)
.end


.HLL "perl6"

.namespace []
.sub "" :load :init :subid("post13") :outer("10_1372703217.59042")
.annotate 'file', "hello.pl"
.annotate 'line', 1
    .const 'Sub' $P1003 = "10_1372703217.59042" 
    .local pmc block
    set block, $P1003
    nqp_get_sc $P101, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42"
    isnull $I100, $P101
    if $I100, if_1012
    goto if_1012_end
  if_1012:
    nqp_dynop_setup 
    nqp_bigint_setup 
    nqp_native_call_setup 
    rakudo_dynop_setup 
    getinterp $P103
    get_class $P104, "LexPad"
    get_class $P105, "Perl6LexPad"
    $P103."hll_map"($P104, $P105)
    nqp_create_sc $P106, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42"
    .local pmc cur_sc
    set cur_sc, $P106
    nqp_get_sc $P107, "__6MODEL_CORE__"
    isnull $I101, $P107
    unless $I101, if_1013_end
    set $S100, "Incorrect pre-compiled version of <unknown> loaded"
    die $S100
  if_1013_end:
    nqp_get_sc_object $P107, "__6MODEL_CORE__", 0
    $P108 = $P107."new_type"()
    nqp_add_object_to_sc cur_sc, 2, $P108
    load_bytecode "ModuleLoader.pbc"
    get_root_namespace $P107
    set $P108, $P107["nqp"]
    set $P109, $P108["ModuleLoader"]
    set $P110, $P109[1]
    nqp_get_sc_object $P111, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 2
    $P110."load_module"("Perl6::ModuleLoader", $P111)
    .const '' $P1014 = "11_1372703217.59042" 
    get_hll_global $P107, "ModuleLoader"
    $P108 = $P107."load_setting"("CORE")
    $P1014."set_outer_ctx"($P108)
    nqp_get_sc $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628"
    isnull $I101, $P107
    unless $I101, if_1015_end
    set $S100, "Incorrect pre-compiled version of src/gen/Metamodel.pm loaded"
    die $S100
  if_1015_end:
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 33
    $P108 = $P107."new_type"("GLOBAL" :named("name"))
    nqp_add_object_to_sc cur_sc, 3, $P108
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    get_how $P108, $P107
    nqp_get_sc_object $P109, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    $P108."compose"($P109)
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 33
    $P108 = $P107."new_type"("EXPORT" :named("name"))
    nqp_add_object_to_sc cur_sc, 4, $P108
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 4
    get_how $P108, $P107
    nqp_get_sc_object $P109, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 4
    $P108."compose"($P109)
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 472
    repr_instance_of $P108, $P107
    nqp_add_object_to_sc cur_sc, 5, $P108
    .const 'LexInfo' $P1016 = "10_1372703217.59042" 
    nqp_get_sc_object $P109, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    $P1016."set_static_lexpad"($P109)
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    nqp_get_sc_object $P108, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    $P107."add_static_value"("GLOBALish", $P108, 0, 0)
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    nqp_get_sc_object $P108, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 4
    $P107."add_static_value"("EXPORT", $P108, 0, 0)
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    nqp_get_sc_object $P108, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    $P107."add_static_value"("$?PACKAGE", $P108, 0, 0)
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    nqp_get_sc_object $P108, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    $P107."add_static_value"("::?PACKAGE", $P108, 0, 0)
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P108, $P107
    nqp_add_object_to_sc cur_sc, 6, $P108
    new $P109, "ResizablePMCArray"
    nqp_get_sc_object $P110, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 6
    nqp_get_sc_object $P111, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P110, $P111, "$!params", 0, $P109
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P108, $P107
    nqp_add_object_to_sc cur_sc, 7, $P108
    .const '' $P1017 = "10_1372703217.59042" 
    nqp_get_sc_object $P109, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 7
    nqp_get_sc_object $P110, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P109, $P110, "$!do", 0, $P1017
    nqp_get_sc_object $P111, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 6
    nqp_get_sc_object $P112, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 7
    nqp_get_sc_object $P113, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P112, $P113, "$!signature", 1, $P111
    .const '' $P1018 = "10_1372703217.59042" 
    nqp_get_sc_object $P114, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 7
    perl6_associate_sub_code_object $P1018, $P114
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 520
    repr_box_str $P108, "Hello!", $P107
    nqp_add_object_to_sc cur_sc, 8, $P108
    nqp_get_sc_object $P107, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 530
    $P108 = $P107."new"()
    nqp_add_object_to_sc cur_sc, 9, $P108
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 5
    nqp_get_sc_object $P108, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 9
    $P107."add_static_value"("$=POD", $P108, 0, 0)
  if_1012_end:
    nqp_get_sc_object $P107, "6D0684E42EFFCD18A67C3CA879DCF7FE592D3E42", 3
    set_hll_global "GLOBAL", $P107
    .const 'LexInfo' $P1019 = "10_1372703217.59042" 
    $P1019."set_fresh_magicals"()
.end


.HLL "perl6"

.namespace []
.sub "_block1020" :load :anon :subid("12_1372703217.59042")
.annotate 'file', "hello.pl"
.annotate 'line', 1
    .const '' $P1022 = "11_1372703217.59042" 
    $P109 = $P1022()
    .return ($P109)
.end

