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
.sub "_block1000"  :anon :subid("16_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 0
    .const 'Sub' $P1003 = "10_1372687564.88365" 
    capture_lex $P1003
.annotate 'line', 1
.annotate 'file', 'prime_p6.pl'
    .const 'Sub' $P1003 = "10_1372687564.88365" 
    capture_lex $P1003
    $P115 = $P1003()
    .return ($P115)
    .const 'Sub' $P1069 = "17_1372687564.88365" 
    .return ($P1069)
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
.sub "_block1002"  :anon :subid("10_1372687564.88365") :outer("16_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 1
    .const 'Sub' $P1012 = "11_1372687564.88365" 
    capture_lex $P1012
    .lex "GLOBALish", $P1004
    .lex "EXPORT", $P1005
    .lex "$?PACKAGE", $P1006
    .lex "::?PACKAGE", $P1007
    .lex "$_", $P1008
    .lex "$/", $P1009
    .lex "$!", $P1010
    find_lex $P100, "$?PACKAGE"
    get_who $P101, $P100
    nqp_get_sc_object $P102, "E9DEA157595808DAE995A7846F04569FB054B869", 8
    $P103 = $P101."at_key"($P102)
    set $P1011, $P103
    .lex "$VERSION", $P1011
    .lex "&MAIN", $P1045
    find_lex $P104, "&MAIN"
    $P105 = $P104."clone"()
    store_lex "&MAIN", $P105
    .lex "$=POD", $P1046
    $P0 = find_dynamic_lex "$*CTXSAVE"
    if null $P0 goto ctxsave_done
    $I0 = can $P0, "ctxsave"
    unless $I0 goto ctxsave_done
    $P0."ctxsave"()
  ctxsave_done:
    nqp_get_sc_object $P106, "E9DEA157595808DAE995A7846F04569FB054B869", 33
.annotate 'line', 7
    find_lex $P107, "$VERSION"
    nqp_get_sc_object $P108, "E9DEA157595808DAE995A7846F04569FB054B869", 9
    perl6_container_store $P107, $P108
.annotate 'line', 1
    nqp_get_sc_object $P107, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    $P108 = $P107."clone"()
    perl6_capture_lex $P108
    $P107 = "&MAIN_HELPER"($P108)
    .return ($P107)
.end


.HLL "perl6"

.namespace []
.sub "" :load :init :subid("post18") :outer("10_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 1
    .const 'Sub' $P1003 = "10_1372687564.88365" 
    .local pmc block
    set block, $P1003
    nqp_get_sc $P109, "E9DEA157595808DAE995A7846F04569FB054B869"
    isnull $I100, $P109
    if $I100, if_1047
    goto if_1047_end
  if_1047:
    nqp_dynop_setup 
    nqp_bigint_setup 
    nqp_native_call_setup 
    rakudo_dynop_setup 
    getinterp $P110
    get_class $P111, "LexPad"
    get_class $P112, "Perl6LexPad"
    $P110."hll_map"($P111, $P112)
    nqp_create_sc $P113, "E9DEA157595808DAE995A7846F04569FB054B869"
    .local pmc cur_sc
    set cur_sc, $P113
    nqp_get_sc $P114, "__6MODEL_CORE__"
    isnull $I101, $P114
    unless $I101, if_1048_end
    set $S100, "Incorrect pre-compiled version of <unknown> loaded"
    die $S100
  if_1048_end:
    nqp_get_sc_object $P114, "__6MODEL_CORE__", 0
    $P115 = $P114."new_type"()
    nqp_add_object_to_sc cur_sc, 2, $P115
    load_bytecode "ModuleLoader.pbc"
    get_root_namespace $P114
    set $P115, $P114["nqp"]
    set $P116, $P115["ModuleLoader"]
    set $P117, $P116[1]
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 2
    $P117."load_module"("Perl6::ModuleLoader", $P118)
    .const '' $P1049 = "16_1372687564.88365" 
    get_hll_global $P114, "ModuleLoader"
    $P115 = $P114."load_setting"("CORE")
    $P1049."set_outer_ctx"($P115)
    nqp_get_sc $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628"
    isnull $I101, $P114
    unless $I101, if_1050_end
    set $S100, "Incorrect pre-compiled version of src/gen/Metamodel.pm loaded"
    die $S100
  if_1050_end:
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 33
    $P115 = $P114."new_type"("GLOBAL" :named("name"))
    nqp_add_object_to_sc cur_sc, 3, $P115
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    get_how $P115, $P114
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    $P115."compose"($P116)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 33
    $P115 = $P114."new_type"("EXPORT" :named("name"))
    nqp_add_object_to_sc cur_sc, 4, $P115
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 4
    get_how $P115, $P114
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 4
    $P115."compose"($P116)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 472
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 5, $P115
    .const 'LexInfo' $P1051 = "10_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    $P1051."set_static_lexpad"($P116)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    $P114."add_static_value"("GLOBALish", $P115, 0, 0)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 4
    $P114."add_static_value"("EXPORT", $P115, 0, 0)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    $P114."add_static_value"("$?PACKAGE", $P115, 0, 0)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    $P114."add_static_value"("::?PACKAGE", $P115, 0, 0)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 6, $P115
    new $P116, "ResizablePMCArray"
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 6
    nqp_get_sc_object $P118, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P117, $P118, "$!params", 0, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 7, $P115
    .const '' $P1052 = "10_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 7
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1052
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 6
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 7
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1053 = "10_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 7
    perl6_associate_sub_code_object $P1053, $P121
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 520
    repr_box_str $P115, "$VERSION", $P114
    nqp_add_object_to_sc cur_sc, 8, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 523
    repr_box_int $P115, 1, $P114
    nqp_add_object_to_sc cur_sc, 9, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 523
    repr_box_int $P115, 10, $P114
    nqp_add_object_to_sc cur_sc, 10, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 462
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 505
    perl6_create_container_descriptor $P116, $P114, $P115, 1, "$i"
    nqp_add_object_to_sc cur_sc, 11, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 472
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 12, $P115
    .const 'LexInfo' $P1054 = "11_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 12
    $P1054."set_static_lexpad"($P116)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 12
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    repr_instance_of $P116, $P115
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 11
    setattribute $P116, $P117, "$!descriptor", $P118
    nqp_get_sc_object $P119, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    setattribute $P116, $P119, "$!value", $P120
    $P114."add_static_value"("$i", $P116, 1, 0)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 462
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 505
    perl6_create_container_descriptor $P116, $P114, $P115, 1, "$prim"
    nqp_add_object_to_sc cur_sc, 13, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 472
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 14, $P115
    .const 'LexInfo' $P1055 = "12_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 14
    $P1055."set_static_lexpad"($P116)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 14
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    repr_instance_of $P116, $P115
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 13
    setattribute $P116, $P117, "$!descriptor", $P118
    nqp_get_sc_object $P119, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    setattribute $P116, $P119, "$!value", $P120
    $P114."add_static_value"("$prim", $P116, 1, 0)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 462
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 505
    perl6_create_container_descriptor $P116, $P114, $P115, 1, "$j"
    nqp_add_object_to_sc cur_sc, 15, $P116
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 14
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    repr_instance_of $P116, $P115
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 15
    setattribute $P116, $P117, "$!descriptor", $P118
    nqp_get_sc_object $P119, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 509
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    setattribute $P116, $P119, "$!value", $P120
    $P114."add_static_value"("$j", $P116, 1, 0)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 523
    repr_box_int $P115, 2, $P114
    nqp_add_object_to_sc cur_sc, 16, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 523
    repr_box_int $P115, 0, $P114
    nqp_add_object_to_sc cur_sc, 17, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 18, $P115
    new $P116, "ResizablePMCArray"
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 18
    nqp_get_sc_object $P118, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P117, $P118, "$!params", 0, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 19, $P115
    .const '' $P1056 = "13_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 19
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1056
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 18
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 19
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1057 = "13_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 19
    perl6_associate_sub_code_object $P1057, $P121
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 20, $P115
    new $P116, "ResizablePMCArray"
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 20
    nqp_get_sc_object $P118, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P117, $P118, "$!params", 0, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 21, $P115
    .const '' $P1058 = "14_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 21
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1058
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 20
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 21
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1059 = "14_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 21
    perl6_associate_sub_code_object $P1059, $P121
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 520
    repr_box_str $P115, "\n", $P114
    nqp_add_object_to_sc cur_sc, 22, $P115
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 23, $P115
    new $P116, "ResizablePMCArray"
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 23
    nqp_get_sc_object $P118, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P117, $P118, "$!params", 0, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 24, $P115
    .const '' $P1060 = "15_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 24
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1060
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 23
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 24
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1061 = "15_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 24
    perl6_associate_sub_code_object $P1061, $P121
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 25, $P115
    new $P116, "ResizablePMCArray"
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 25
    nqp_get_sc_object $P118, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P117, $P118, "$!params", 0, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 514
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 26, $P115
    .const '' $P1062 = "12_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 26
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1062
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 25
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 26
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1063 = "12_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 26
    perl6_associate_sub_code_object $P1063, $P121
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 462
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    perl6_create_container_descriptor $P116, $P114, $P115, 0, "$min"
    nqp_add_object_to_sc cur_sc, 27, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 512
    set $P1, $P114
    repr_instance_of $P115, $P1
    set $P0, $P115
    nqp_add_object_to_sc cur_sc, 28, $P0
    repr_bind_attr_str $P0, $P1, "$!variable_name", -1, "$min"
    nqp_get_sc_object $P116, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    repr_bind_attr_obj $P0, $P1, "$!nominal_type", -1, $P116
    repr_bind_attr_int $P0, $P1, "$!flags", -1, 1050752
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 9
    repr_bind_attr_obj $P0, $P1, "$!default_value", -1, $P117
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 27
    repr_bind_attr_obj $P0, $P1, "$!container_descriptor", -1, $P118
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 462
    nqp_get_sc_object $P115, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    perl6_create_container_descriptor $P116, $P114, $P115, 0, "$max"
    nqp_add_object_to_sc cur_sc, 29, $P116
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 512
    set $P1, $P114
    repr_instance_of $P115, $P1
    set $P0, $P115
    nqp_add_object_to_sc cur_sc, 30, $P0
    repr_bind_attr_str $P0, $P1, "$!variable_name", -1, "$max"
    nqp_get_sc_object $P116, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 506
    repr_bind_attr_obj $P0, $P1, "$!nominal_type", -1, $P116
    repr_bind_attr_int $P0, $P1, "$!flags", -1, 1050752
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 10
    repr_bind_attr_obj $P0, $P1, "$!default_value", -1, $P117
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 29
    repr_bind_attr_obj $P0, $P1, "$!container_descriptor", -1, $P118
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 31, $P115
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 28
    nqp_get_sc_object $P117, "E9DEA157595808DAE995A7846F04569FB054B869", 30
    new $P118, "ResizablePMCArray"
    push $P118, $P116
    push $P118, $P117
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 31
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 511
    repr_bind_attr_obj $P119, $P120, "$!params", 0, $P118
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 516
    repr_instance_of $P115, $P114
    nqp_add_object_to_sc cur_sc, 32, $P115
    .const '' $P1064 = "11_1372687564.88365" 
    nqp_get_sc_object $P116, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    nqp_get_sc_object $P117, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P116, $P117, "$!do", 0, $P1064
    nqp_get_sc_object $P118, "E9DEA157595808DAE995A7846F04569FB054B869", 31
    nqp_get_sc_object $P119, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    nqp_get_sc_object $P120, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 513
    repr_bind_attr_obj $P119, $P120, "$!signature", 1, $P118
    .const '' $P1065 = "11_1372687564.88365" 
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    perl6_associate_sub_code_object $P1065, $P121
    .const 'LexInfo' $P1066 = "11_1372687564.88365" 
    $P1066."set_fresh_magicals"()
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 12
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    $P114."add_static_value"("&?ROUTINE", $P115, 0, 0)
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 32
    $P114."add_static_value"("&MAIN", $P115, 0, 0)
    nqp_get_sc_object $P114, "B8275BFDB10AC7E4834A6BECBC4B03D585940924-1336768556.64628", 530
    $P115 = $P114."new"()
    nqp_add_object_to_sc cur_sc, 33, $P115
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 5
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 33
    $P114."add_static_value"("$=POD", $P115, 0, 0)
  if_1047_end:
    nqp_get_sc_object $P114, "E9DEA157595808DAE995A7846F04569FB054B869", 3
    set_hll_global "GLOBAL", $P114
    .const 'LexInfo' $P1067 = "10_1372687564.88365" 
    $P1067."set_fresh_magicals"()
.end


.HLL "perl6"

.namespace []
.include "except_types.pasm"
.sub "MAIN"  :anon :subid("11_1372687564.88365") :outer("10_1372687564.88365")
    .param pmc param_1019 :call_sig
.annotate 'file', "prime_p6.pl"
.annotate 'line', 12
    .const 'Sub' $P1024 = "12_1372687564.88365" 
    capture_lex $P1024
    perl6_take_dispatcher 
    .lex "$min", $P1013
    .lex "$max", $P1014
    .lex "$_", $P1015
    .lex "$/", $P1016
    .lex "$!", $P1017
    .lex "$i", $P1018
    .lex "call_sig", param_1019
    bind_signature 
    .lex "$*DISPATCHER", $P1020
    .lex "&?ROUTINE", $P1021
    root_new $P1022, ['parrot';'Continuation']
    set_label $P1022, lexotic_19
    .lex "RETURN", $P1022
.annotate 'line', 14
    find_lex $P104, "$i"
    find_lex $P105, "$min"
    perl6_container_store $P104, $P105
    new $P115, 'ExceptionHandler', [.CONTROL_LOOP_NEXT;.CONTROL_LOOP_REDO;.CONTROL_LOOP_LAST]
    set_label $P115, loop1044_handler
    push_eh $P115
  loop1044_test:
    find_lex $P106, "&infix:<<=>"
    perl6_multi_dispatch_thunk $P107, $P106
    find_lex $P108, "$i"
    find_lex $P109, "$max"
    $P110 = $P107($P108, $P109)
    unless $P110, loop1044_done
  loop1044_redo:
    .const 'Sub' $P1024 = "12_1372687564.88365" 
    capture_lex $P1024
    $P1024()
  loop1044_next:
    find_lex $P112, "&postfix:<++>"
    perl6_multi_dispatch_thunk $P113, $P112
    find_lex $P114, "$i"
    $P113($P114)
    goto loop1044_test
  loop1044_handler:
    .local pmc exception 
    .get_results (exception) 
    pop_upto_eh exception
    getattribute $P116, exception, 'type'
    eq $P116, .CONTROL_LOOP_NEXT, loop1044_next
    eq $P116, .CONTROL_LOOP_REDO, loop1044_redo
  loop1044_done:
    pop_eh 
.annotate 'line', 12
    perl6_decontainerize_return_value $P104, $P110
    goto lexotic_20
  lexotic_19:
    .get_results ($P104)
  lexotic_20:
    find_lex $P105, "&EXHAUST"
    store_lex "RETURN", $P105
    perl6_type_check_return_value $P104
    .return ($P104)
.end


.HLL "perl6"

.namespace []
.include "except_types.pasm"
.sub "_block1023"  :anon :subid("12_1372687564.88365") :outer("11_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 14
    .const 'Sub' $P1040 = "15_1372687564.88365" 
    capture_lex $P1040
    .const 'Sub' $P1029 = "14_1372687564.88365" 
    capture_lex $P1029
    .lex "$_", $P1025
    .lex "$prim", $P1026
    .lex "$j", $P1027
.annotate 'line', 15
    find_lex $P111, "$prim"
    nqp_get_sc_object $P112, "E9DEA157595808DAE995A7846F04569FB054B869", 9
    perl6_container_store $P111, $P112
.annotate 'line', 16
    find_lex $P111, "$j"
    nqp_get_sc_object $P112, "E9DEA157595808DAE995A7846F04569FB054B869", 16
    perl6_container_store $P111, $P112
    new $P125, 'ExceptionHandler', [.CONTROL_LOOP_NEXT;.CONTROL_LOOP_REDO;.CONTROL_LOOP_LAST]
    set_label $P125, loop1037_handler
    push_eh $P125
  loop1037_test:
    find_lex $P113, "&infix:<<=>"
    perl6_multi_dispatch_thunk $P114, $P113
    find_lex $P115, "$j"
    find_lex $P116, "&sqrt"
    perl6_multi_dispatch_thunk $P117, $P116
    find_lex $P118, "$i"
    $P119 = $P117($P118)
    $P120 = $P114($P115, $P119)
    unless $P120, loop1037_done
  loop1037_redo:
    .const 'Sub' $P1029 = "14_1372687564.88365" 
    capture_lex $P1029
    $P1029()
  loop1037_next:
    find_lex $P122, "&postfix:<++>"
    perl6_multi_dispatch_thunk $P123, $P122
    find_lex $P124, "$j"
    $P123($P124)
    goto loop1037_test
  loop1037_handler:
    .local pmc exception 
    .get_results (exception) 
    pop_upto_eh exception
    getattribute $P126, exception, 'type'
    eq $P126, .CONTROL_LOOP_NEXT, loop1037_next
    eq $P126, .CONTROL_LOOP_REDO, loop1037_redo
  loop1037_done:
    pop_eh 
.annotate 'line', 22
    find_lex $P112, "&infix:<==>"
    perl6_multi_dispatch_thunk $P113, $P112
    find_lex $P114, "$prim"
    nqp_get_sc_object $P115, "E9DEA157595808DAE995A7846F04569FB054B869", 9
    $P116 = $P113($P114, $P115)
    if $P116, if_1038
    find_lex $P118, "Nil"
    set $P111, $P118
    goto if_1038_end
  if_1038:
    .const 'Sub' $P1040 = "15_1372687564.88365" 
    capture_lex $P1040
    $P117 = $P1040()
    set $P111, $P117
  if_1038_end:
.annotate 'line', 14
    .return ($P111)
.end


.HLL "perl6"

.namespace []
.sub "_block1028"  :anon :subid("14_1372687564.88365") :outer("12_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 16
    .const 'Sub' $P1033 = "13_1372687564.88365" 
    capture_lex $P1033
    .lex "$_", $P1030
.annotate 'line', 17
    find_lex $P122, "&infix:<==>"
    perl6_multi_dispatch_thunk $P123, $P122
    find_lex $P124, "&infix:<%>"
    perl6_multi_dispatch_thunk $P125, $P124
    find_lex $P126, "$i"
    find_lex $P127, "$j"
    $P128 = $P125($P126, $P127)
    nqp_get_sc_object $P129, "E9DEA157595808DAE995A7846F04569FB054B869", 17
    $P130 = $P123($P128, $P129)
    if $P130, if_1031
    find_lex $P133, "Nil"
    set $P121, $P133
    goto if_1031_end
  if_1031:
    .const 'Sub' $P1033 = "13_1372687564.88365" 
    capture_lex $P1033
    $P132 = $P1033()
    set $P121, $P132
  if_1031_end:
.annotate 'line', 16
    .return ($P121)
.end


.HLL "perl6"

.namespace []
.sub "_block1032"  :anon :subid("13_1372687564.88365") :outer("14_1372687564.88365")
    .param pmc param_1035 :call_sig
.annotate 'file', "prime_p6.pl"
.annotate 'line', 17
    perl6_take_dispatcher 
    .lex "$_", $P1034
    .lex "call_sig", param_1035
    bind_signature 
    .lex "$*DISPATCHER", $P1036
.annotate 'line', 18
    find_lex $P131, "$prim"
    nqp_get_sc_object $P132, "E9DEA157595808DAE995A7846F04569FB054B869", 17
    perl6_container_store $P131, $P132
.annotate 'line', 19
    $P131 = "&last"()
.annotate 'line', 17
    .return ($P131)
.end


.HLL "perl6"

.namespace []
.sub "_block1039"  :anon :subid("15_1372687564.88365") :outer("12_1372687564.88365")
    .param pmc param_1042 :call_sig
.annotate 'file', "prime_p6.pl"
.annotate 'line', 22
    perl6_take_dispatcher 
    .lex "$_", $P1041
    .lex "call_sig", param_1042
    bind_signature 
    .lex "$*DISPATCHER", $P1043
.annotate 'line', 23
    find_lex $P117, "&infix:<~>"
    perl6_multi_dispatch_thunk $P118, $P117
    find_lex $P119, "$i"
    $P120 = $P119."Stringy"()
    nqp_get_sc_object $P121, "E9DEA157595808DAE995A7846F04569FB054B869", 22
    $P122 = $P118($P120, $P121)
    $P123 = "&print"($P122)
.annotate 'line', 22
    .return ($P123)
.end


.HLL "perl6"

.namespace []
.sub "_block1068" :load :anon :subid("17_1372687564.88365")
.annotate 'file', "prime_p6.pl"
.annotate 'line', 1
    .const '' $P1070 = "16_1372687564.88365" 
    $P116 = $P1070()
    .return ($P116)
.end

