??
??
B
AssignVariableOp
resource
value"dtype"
dtypetype?
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
8
Const
output"dtype"
valuetensor"
dtypetype
?
HashTableV2
table_handle"
	containerstring "
shared_namestring "!
use_node_name_sharingbool( "
	key_dtypetype"
value_dtypetype?
.
Identity

input"T
output"T"	
Ttype
w
LookupTableFindV2
table_handle
keys"Tin
default_value"Tout
values"Tout"
Tintype"
Touttype?
b
LookupTableImportV2
table_handle
keys"Tin
values"Tout"
Tintype"
Touttype?
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype?
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
f
SimpleMLCreateModelResource
model_handle"
	containerstring "
shared_namestring ?
?
SimpleMLInferenceOpWithHandle
numerical_features
boolean_features
categorical_int_features'
#categorical_set_int_features_values1
-categorical_set_int_features_row_splits_dim_1	1
-categorical_set_int_features_row_splits_dim_2	
model_handle
dense_predictions
dense_col_representation"
dense_output_dimint(0?
D
#SimpleMLLoadModelFromPathWithHandle
model_handle
path?
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ?
@
StaticRegexFullMatch	
input

output
"
patternstring
m
StaticRegexReplace	
input

output"
patternstring"
rewritestring"
replace_globalbool(
?
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
?
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 ?
9
VarIsInitializedOp
resource
is_initialized
?"serve*2.5.02v2.5.0-rc3-213-ga4dfb8d1a718??
h

is_trainedVarHandleOp*
_output_shapes
: *
dtype0
*
shape: *
shared_name
is_trained
a
is_trained/Read/ReadVariableOpReadVariableOp
is_trained*
_output_shapes
: *
dtype0

?
SimpleMLCreateModelResourceSimpleMLCreateModelResource*
_output_shapes
: *E
shared_name64simple_ml_model_b1ad2f63-3969-4531-ac33-357cf689079d
l

hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_name1166*
value_dtype0
n
hash_table_1HashTableV2*
_output_shapes
: *
	key_dtype0*
shared_name1172*
value_dtype0
W
asset_path_initializerPlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
VariableVarHandleOp*
_class
loc:@Variable*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable
a
)Variable/IsInitialized/VarIsInitializedOpVarIsInitializedOpVariable*
_output_shapes
: 
R
Variable/AssignAssignVariableOpVariableasset_path_initializer*
dtype0
]
Variable/Read/ReadVariableOpReadVariableOpVariable*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
b
total_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	total_1
[
total_1/Read/ReadVariableOpReadVariableOptotal_1*
_output_shapes
: *
dtype0
b
count_1VarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_name	count_1
[
count_1/Read/ReadVariableOpReadVariableOpcount_1*
_output_shapes
: *
dtype0
Y
asset_path_initializer_1Placeholder*
_output_shapes
: *
dtype0*
shape: 
?

Variable_1VarHandleOp*
_class
loc:@Variable_1*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_1
e
+Variable_1/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_1*
_output_shapes
: 
X
Variable_1/AssignAssignVariableOp
Variable_1asset_path_initializer_1*
dtype0
a
Variable_1/Read/ReadVariableOpReadVariableOp
Variable_1*
_output_shapes
: *
dtype0
Y
asset_path_initializer_2Placeholder*
_output_shapes
: *
dtype0*
shape: 
?

Variable_2VarHandleOp*
_class
loc:@Variable_2*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_2
e
+Variable_2/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_2*
_output_shapes
: 
X
Variable_2/AssignAssignVariableOp
Variable_2asset_path_initializer_2*
dtype0
a
Variable_2/Read/ReadVariableOpReadVariableOp
Variable_2*
_output_shapes
: *
dtype0
Y
asset_path_initializer_3Placeholder*
_output_shapes
: *
dtype0*
shape: 
?

Variable_3VarHandleOp*
_class
loc:@Variable_3*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_3
e
+Variable_3/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_3*
_output_shapes
: 
X
Variable_3/AssignAssignVariableOp
Variable_3asset_path_initializer_3*
dtype0
a
Variable_3/Read/ReadVariableOpReadVariableOp
Variable_3*
_output_shapes
: *
dtype0
Y
asset_path_initializer_4Placeholder*
_output_shapes
: *
dtype0*
shape: 
?

Variable_4VarHandleOp*
_class
loc:@Variable_4*
_output_shapes
: *
dtype0*
shape: *
shared_name
Variable_4
e
+Variable_4/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Variable_4*
_output_shapes
: 
X
Variable_4/AssignAssignVariableOp
Variable_4asset_path_initializer_4*
dtype0
a
Variable_4/Read/ReadVariableOpReadVariableOp
Variable_4*
_output_shapes
: *
dtype0
G
ConstConst*
_output_shapes
: *
dtype0*
value	B : 
I
Const_1Const*
_output_shapes
: *
dtype0*
value	B : 
?
Const_2Const*
_output_shapes
:*
dtype0*N
valueEBCB B
2147483645BfemaleBmaleBOtherBContact with confirmed
h
Const_3Const*
_output_shapes
:*
dtype0*-
value$B""????????            
?
Const_4Const*
_output_shapes
:*
dtype0*H
value?B=B B
2147483645BOtherBContact with confirmedBAbroad
d
Const_5Const*
_output_shapes
:*
dtype0*)
value B"????????         
a
ReadVariableOpReadVariableOpVariable^Variable/Assign*
_output_shapes
: *
dtype0
?
StatefulPartitionedCallStatefulPartitionedCallReadVariableOpSimpleMLCreateModelResource*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *"
fR
__inference_<lambda>_2866
?
StatefulPartitionedCall_1StatefulPartitionedCall
hash_tableConst_2Const_3*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *"
fR
__inference_<lambda>_2874
?
StatefulPartitionedCall_2StatefulPartitionedCallhash_table_1Const_4Const_5*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *"
fR
__inference_<lambda>_2882
?
NoOpNoOp^StatefulPartitionedCall^StatefulPartitionedCall_1^StatefulPartitionedCall_2^Variable/Assign^Variable_1/Assign^Variable_2/Assign^Variable_3/Assign^Variable_4/Assign
?
Const_6Const"/device:CPU:0*
_output_shapes
: *
dtype0*?

value?
B?
 B?

?
_learner_params
	_features
_is_trained
	optimizer
loss

_model
regularization_losses
trainable_variables
		variables

	keras_api

signatures
 
 
FD
VARIABLE_VALUE
is_trained&_is_trained/.ATTRIBUTES/VARIABLE_VALUE
 
 
)
_input_builder
_compiled_model
 
 

0
?

layers
layer_metrics
regularization_losses
metrics
trainable_variables
		variables
non_trainable_variables
layer_regularization_losses
 
N
_feature_name_to_idx
	_init_ops
#categorical_str_to_int_hashmaps

_model_loader
 
 

0
1

0
 
 
 
!

gender
test_indication
 

_all_files

_done_file
4
	total
	count
	variables
 	keras_api
D
	!total
	"count
#
_fn_kwargs
$	variables
%	keras_api

&_initializer

'_initializer
#
(0
)1
*2
+3
4
 
OM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE
OM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE

0
1

	variables
QO
VARIABLE_VALUEtotal_14keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUE
QO
VARIABLE_VALUEcount_14keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUE
 

!0
"1

$	variables
 
 
 
 
 
 
x
serving_default_coughPlaceholder*'
_output_shapes
:?????????*
dtype0	*
shape:?????????
x
serving_default_feverPlaceholder*'
_output_shapes
:?????????*
dtype0	*
shape:?????????
y
serving_default_genderPlaceholder*'
_output_shapes
:?????????*
dtype0*
shape:?????????
|
serving_default_head_achePlaceholder*'
_output_shapes
:?????????*
dtype0	*
shape:?????????
?
#serving_default_shortness_of_breathPlaceholder*'
_output_shapes
:?????????*
dtype0	*
shape:?????????
~
serving_default_sore_throatPlaceholder*'
_output_shapes
:?????????*
dtype0	*
shape:?????????
?
serving_default_test_indicationPlaceholder*'
_output_shapes
:?????????*
dtype0*
shape:?????????
?
StatefulPartitionedCall_3StatefulPartitionedCallserving_default_coughserving_default_feverserving_default_genderserving_default_head_ache#serving_default_shortness_of_breathserving_default_sore_throatserving_default_test_indication
hash_tableConsthash_table_1Const_1SimpleMLCreateModelResource*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *+
f&R$
"__inference_signature_wrapper_2570
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
StatefulPartitionedCall_4StatefulPartitionedCallsaver_filenameis_trained/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOptotal_1/Read/ReadVariableOpcount_1/Read/ReadVariableOpConst_6*
Tin
	2
*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *&
f!R
__inference__traced_save_2959
?
StatefulPartitionedCall_5StatefulPartitionedCallsaver_filename
is_trainedtotalcounttotal_1count_1*
Tin

2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *)
f$R"
 __inference__traced_restore_2984??
?I
?
__inference_call_2798
inputs_cough	
inputs_fever	
inputs_gender
inputs_head_ache	
inputs_shortness_of_breath	
inputs_sore_throat	
inputs_test_indication.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_opc
CastCastinputs_cough*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_sliceg
Cast_1Castinputs_fever*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1m
Cast_2Castinputs_sore_throat*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2u
Cast_3Castinputs_shortness_of_breath*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3k
Cast_4Castinputs_head_ache*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_genderstrided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_test_indicationstrided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:U Q
'
_output_shapes
:?????????
&
_user_specified_nameinputs/cough:UQ
'
_output_shapes
:?????????
&
_user_specified_nameinputs/fever:VR
'
_output_shapes
:?????????
'
_user_specified_nameinputs/gender:YU
'
_output_shapes
:?????????
*
_user_specified_nameinputs/head_ache:c_
'
_output_shapes
:?????????
4
_user_specified_nameinputs/shortness_of_breath:[W
'
_output_shapes
:?????????
,
_user_specified_nameinputs/sore_throat:_[
'
_output_shapes
:?????????
0
_user_specified_nameinputs/test_indication:

_output_shapes
: :


_output_shapes
: 
?
?
__inference_<lambda>_2866
staticregexreplace_input>
:simple_ml_simplemlloadmodelfrompathwithhandle_model_handle
identity??-simple_ml/SimpleMLLoadModelFromPathWithHandle?
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *
patterndone*
rewrite 2
StaticRegexReplace?
-simple_ml/SimpleMLLoadModelFromPathWithHandle#SimpleMLLoadModelFromPathWithHandle:simple_ml_simplemlloadmodelfrompathwithhandle_model_handleStaticRegexReplace:output:0*
_output_shapes
 2/
-simple_ml/SimpleMLLoadModelFromPathWithHandleS
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ??2
Const?
IdentityIdentityConst:output:0.^simple_ml/SimpleMLLoadModelFromPathWithHandle*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 2^
-simple_ml/SimpleMLLoadModelFromPathWithHandle-simple_ml/SimpleMLLoadModelFromPathWithHandle: 

_output_shapes
: 
?
9
__inference__creator_2845
identity??
hash_tablez

hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_name1172*
value_dtype02

hash_tablei
IdentityIdentityhash_table:table_handle:0^hash_table*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 2

hash_table
hash_table
?
?
__inference_<lambda>_28827
3key_value_init1171_lookuptableimportv2_table_handle/
+key_value_init1171_lookuptableimportv2_keys1
-key_value_init1171_lookuptableimportv2_values
identity??&key_value_init1171/LookupTableImportV2?
&key_value_init1171/LookupTableImportV2LookupTableImportV23key_value_init1171_lookuptableimportv2_table_handle+key_value_init1171_lookuptableimportv2_keys-key_value_init1171_lookuptableimportv2_values*	
Tin0*

Tout0*
_output_shapes
 2(
&key_value_init1171/LookupTableImportV2S
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ??2
Constz
IdentityIdentityConst:output:0'^key_value_init1171/LookupTableImportV2*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*!
_input_shapes
: ::2P
&key_value_init1171/LookupTableImportV2&key_value_init1171/LookupTableImportV2: 

_output_shapes
:: 

_output_shapes
:
?H
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2389

inputs	
inputs_1	
inputs_2
inputs_3	
inputs_4	
inputs_5	
inputs_6.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_op]
CastCastinputs*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slicec
Cast_1Castinputs_1*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1c
Cast_2Castinputs_5*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2c
Cast_3Castinputs_4*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3c
Cast_4Castinputs_3*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_2strided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_6strided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:

_output_shapes
: :


_output_shapes
: 
?J
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2632
inputs_cough	
inputs_fever	
inputs_gender
inputs_head_ache	
inputs_shortness_of_breath	
inputs_sore_throat	
inputs_test_indication.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_opc
CastCastinputs_cough*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_sliceg
Cast_1Castinputs_fever*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1m
Cast_2Castinputs_sore_throat*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2u
Cast_3Castinputs_shortness_of_breath*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3k
Cast_4Castinputs_head_ache*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_genderstrided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_test_indicationstrided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:U Q
'
_output_shapes
:?????????
&
_user_specified_nameinputs/cough:UQ
'
_output_shapes
:?????????
&
_user_specified_nameinputs/fever:VR
'
_output_shapes
:?????????
'
_user_specified_nameinputs/gender:YU
'
_output_shapes
:?????????
*
_user_specified_nameinputs/head_ache:c_
'
_output_shapes
:?????????
4
_user_specified_nameinputs/shortness_of_breath:[W
'
_output_shapes
:?????????
,
_user_specified_nameinputs/sore_throat:_[
'
_output_shapes
:?????????
0
_user_specified_nameinputs/test_indication:

_output_shapes
: :


_output_shapes
: 
?H
?
__inference_call_2200

inputs	
inputs_1	
inputs_2
inputs_3	
inputs_4	
inputs_5	
inputs_6.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_op]
CastCastinputs*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slicec
Cast_1Castinputs_1*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1c
Cast_2Castinputs_5*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2c
Cast_3Castinputs_4*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3c
Cast_4Castinputs_3*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_2strided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_6strided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:

_output_shapes
: :


_output_shapes
: 
?
?
__inference__initializer_28357
3key_value_init1165_lookuptableimportv2_table_handle/
+key_value_init1165_lookuptableimportv2_keys1
-key_value_init1165_lookuptableimportv2_values
identity??&key_value_init1165/LookupTableImportV2?
&key_value_init1165/LookupTableImportV2LookupTableImportV23key_value_init1165_lookuptableimportv2_table_handle+key_value_init1165_lookuptableimportv2_keys-key_value_init1165_lookuptableimportv2_values*	
Tin0*

Tout0*
_output_shapes
 2(
&key_value_init1165/LookupTableImportV2P
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
Constz
IdentityIdentityConst:output:0'^key_value_init1165/LookupTableImportV2*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*!
_input_shapes
: ::2P
&key_value_init1165/LookupTableImportV2&key_value_init1165/LookupTableImportV2: 

_output_shapes
:: 

_output_shapes
:
?
J
__inference__creator_2809
identity??SimpleMLCreateModelResource?
SimpleMLCreateModelResourceSimpleMLCreateModelResource*
_output_shapes
: *E
shared_name64simple_ml_model_b1ad2f63-3969-4531-ac33-357cf689079d2
SimpleMLCreateModelResource?
IdentityIdentity*SimpleMLCreateModelResource:model_handle:0^SimpleMLCreateModelResource*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 2:
SimpleMLCreateModelResourceSimpleMLCreateModelResource
?
9
__inference__creator_2827
identity??
hash_tablez

hash_tableHashTableV2*
_output_shapes
: *
	key_dtype0*
shared_name1166*
value_dtype02

hash_tablei
IdentityIdentityhash_table:table_handle:0^hash_table*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 2

hash_table
hash_table
?
?
__inference__initializer_2817
staticregexreplace_input>
:simple_ml_simplemlloadmodelfrompathwithhandle_model_handle
identity??-simple_ml/SimpleMLLoadModelFromPathWithHandle?
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *
patterndone*
rewrite 2
StaticRegexReplace?
-simple_ml/SimpleMLLoadModelFromPathWithHandle#SimpleMLLoadModelFromPathWithHandle:simple_ml_simplemlloadmodelfrompathwithhandle_model_handleStaticRegexReplace:output:0*
_output_shapes
 2/
-simple_ml/SimpleMLLoadModelFromPathWithHandleP
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
Const?
IdentityIdentityConst:output:0.^simple_ml/SimpleMLLoadModelFromPathWithHandle*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 2^
-simple_ml/SimpleMLLoadModelFromPathWithHandle-simple_ml/SimpleMLLoadModelFromPathWithHandle: 

_output_shapes
: 
?
+
__inference__destroyer_2858
identityP
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
ConstQ
IdentityIdentityConst:output:0*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 
?
?
__inference_<lambda>_28747
3key_value_init1165_lookuptableimportv2_table_handle/
+key_value_init1165_lookuptableimportv2_keys1
-key_value_init1165_lookuptableimportv2_values
identity??&key_value_init1165/LookupTableImportV2?
&key_value_init1165/LookupTableImportV2LookupTableImportV23key_value_init1165_lookuptableimportv2_table_handle+key_value_init1165_lookuptableimportv2_keys-key_value_init1165_lookuptableimportv2_values*	
Tin0*

Tout0*
_output_shapes
 2(
&key_value_init1165/LookupTableImportV2S
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  ??2
Constz
IdentityIdentityConst:output:0'^key_value_init1165/LookupTableImportV2*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*!
_input_shapes
: ::2P
&key_value_init1165/LookupTableImportV2&key_value_init1165/LookupTableImportV2: 

_output_shapes
:: 

_output_shapes
:
?
?
;__inference_gradient_boosted_trees_model_layer_call_fn_2715
inputs_cough	
inputs_fever	
inputs_gender
inputs_head_ache	
inputs_shortness_of_breath	
inputs_sore_throat	
inputs_test_indication
unknown
	unknown_0
	unknown_1
	unknown_2
	unknown_3
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputs_coughinputs_feverinputs_genderinputs_head_acheinputs_shortness_of_breathinputs_sore_throatinputs_test_indicationunknown	unknown_0	unknown_1	unknown_2	unknown_3*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *_
fZRX
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_22852
StatefulPartitionedCall?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:U Q
'
_output_shapes
:?????????
&
_user_specified_nameinputs/cough:UQ
'
_output_shapes
:?????????
&
_user_specified_nameinputs/fever:VR
'
_output_shapes
:?????????
'
_user_specified_nameinputs/gender:YU
'
_output_shapes
:?????????
*
_user_specified_nameinputs/head_ache:c_
'
_output_shapes
:?????????
4
_user_specified_nameinputs/shortness_of_breath:[W
'
_output_shapes
:?????????
,
_user_specified_nameinputs/sore_throat:_[
'
_output_shapes
:?????????
0
_user_specified_nameinputs/test_indication:

_output_shapes
: :


_output_shapes
: 
?
?
"__inference_signature_wrapper_2570	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication
unknown
	unknown_0
	unknown_1
	unknown_2
	unknown_3
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallcoughfevergender	head_acheshortness_of_breathsore_throattest_indicationunknown	unknown_0	unknown_1	unknown_2	unknown_3*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *(
f#R!
__inference__wrapped_model_22132
StatefulPartitionedCall?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?
?
__inference__initializer_28537
3key_value_init1171_lookuptableimportv2_table_handle/
+key_value_init1171_lookuptableimportv2_keys1
-key_value_init1171_lookuptableimportv2_values
identity??&key_value_init1171/LookupTableImportV2?
&key_value_init1171/LookupTableImportV2LookupTableImportV23key_value_init1171_lookuptableimportv2_table_handle+key_value_init1171_lookuptableimportv2_keys-key_value_init1171_lookuptableimportv2_values*	
Tin0*

Tout0*
_output_shapes
 2(
&key_value_init1171/LookupTableImportV2P
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
Constz
IdentityIdentityConst:output:0'^key_value_init1171/LookupTableImportV2*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*!
_input_shapes
: ::2P
&key_value_init1171/LookupTableImportV2&key_value_init1171/LookupTableImportV2: 

_output_shapes
:: 

_output_shapes
:
?J
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2694
inputs_cough	
inputs_fever	
inputs_gender
inputs_head_ache	
inputs_shortness_of_breath	
inputs_sore_throat	
inputs_test_indication.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_opc
CastCastinputs_cough*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_sliceg
Cast_1Castinputs_fever*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1m
Cast_2Castinputs_sore_throat*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2u
Cast_3Castinputs_shortness_of_breath*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3k
Cast_4Castinputs_head_ache*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_genderstrided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_test_indicationstrided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:U Q
'
_output_shapes
:?????????
&
_user_specified_nameinputs/cough:UQ
'
_output_shapes
:?????????
&
_user_specified_nameinputs/fever:VR
'
_output_shapes
:?????????
'
_user_specified_nameinputs/gender:YU
'
_output_shapes
:?????????
*
_user_specified_nameinputs/head_ache:c_
'
_output_shapes
:?????????
4
_user_specified_nameinputs/shortness_of_breath:[W
'
_output_shapes
:?????????
,
_user_specified_nameinputs/sore_throat:_[
'
_output_shapes
:?????????
0
_user_specified_nameinputs/test_indication:

_output_shapes
: :


_output_shapes
: 
?
?
 __inference__traced_restore_2984
file_prefix%
assignvariableop_is_trained:
 "
assignvariableop_1_total: "
assignvariableop_2_count: $
assignvariableop_3_total_1: $
assignvariableop_4_count_1: 

identity_6??AssignVariableOp?AssignVariableOp_1?AssignVariableOp_2?AssignVariableOp_3?AssignVariableOp_4?
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B&_is_trained/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
RestoreV2/tensor_names?
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B B B B 2
RestoreV2/shape_and_slices?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*,
_output_shapes
::::::*
dtypes

2
2
	RestoreV2g
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0
*
_output_shapes
:2

Identity?
AssignVariableOpAssignVariableOpassignvariableop_is_trainedIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0
2
AssignVariableOpk

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:2

Identity_1?
AssignVariableOp_1AssignVariableOpassignvariableop_1_totalIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_1k

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:2

Identity_2?
AssignVariableOp_2AssignVariableOpassignvariableop_2_countIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_2k

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:2

Identity_3?
AssignVariableOp_3AssignVariableOpassignvariableop_3_total_1Identity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_3k

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:2

Identity_4?
AssignVariableOp_4AssignVariableOpassignvariableop_4_count_1Identity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype02
AssignVariableOp_49
NoOpNoOp"/device:CPU:0*
_output_shapes
 2
NoOp?

Identity_5Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^NoOp"/device:CPU:0*
T0*
_output_shapes
: 2

Identity_5?

Identity_6IdentityIdentity_5:output:0^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4*
T0*
_output_shapes
: 2

Identity_6"!

identity_6Identity_6:output:0*
_input_shapes
: : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_4:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
?
+
__inference__destroyer_2840
identityP
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
ConstQ
IdentityIdentityConst:output:0*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 
?
Z
,__inference_yggdrasil_model_path_tensor_2804
staticregexreplace_input
identity?
StaticRegexReplaceStaticRegexReplacestaticregexreplace_input*
_output_shapes
: *
patterndone*
rewrite 2
StaticRegexReplace^
IdentityIdentityStaticRegexReplace:output:0*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes
: : 

_output_shapes
: 
?
?
__inference__wrapped_model_2213	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication%
!gradient_boosted_trees_model_2201%
!gradient_boosted_trees_model_2203%
!gradient_boosted_trees_model_2205%
!gradient_boosted_trees_model_2207%
!gradient_boosted_trees_model_2209
identity??4gradient_boosted_trees_model/StatefulPartitionedCall?
4gradient_boosted_trees_model/StatefulPartitionedCallStatefulPartitionedCallcoughfevergender	head_acheshortness_of_breathsore_throattest_indication!gradient_boosted_trees_model_2201!gradient_boosted_trees_model_2203!gradient_boosted_trees_model_2205!gradient_boosted_trees_model_2207!gradient_boosted_trees_model_2209*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *
fR
__inference_call_220026
4gradient_boosted_trees_model/StatefulPartitionedCall?
IdentityIdentity=gradient_boosted_trees_model/StatefulPartitionedCall:output:05^gradient_boosted_trees_model/StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2l
4gradient_boosted_trees_model/StatefulPartitionedCall4gradient_boosted_trees_model/StatefulPartitionedCall:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?I
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2547	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_op\
CastCastcough*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice`
Cast_1Castfever*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1f
Cast_2Castsore_throat*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2n
Cast_3Castshortness_of_breath*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3d
Cast_4Cast	head_ache*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSlicegenderstrided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSlicetest_indicationstrided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?
+
__inference__destroyer_2822
identityP
ConstConst*
_output_shapes
: *
dtype0*
value	B :2
ConstQ
IdentityIdentityConst:output:0*
T0*
_output_shapes
: 2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*
_input_shapes 
?H
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2285

inputs	
inputs_1	
inputs_2
inputs_3	
inputs_4	
inputs_5	
inputs_6.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_op]
CastCastinputs*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slicec
Cast_1Castinputs_1*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1c
Cast_2Castinputs_5*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2c
Cast_3Castinputs_4*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3c
Cast_4Castinputs_3*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSliceinputs_2strided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSliceinputs_6strided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:O K
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:OK
'
_output_shapes
:?????????
 
_user_specified_nameinputs:

_output_shapes
: :


_output_shapes
: 
?
?
;__inference_gradient_boosted_trees_model_layer_call_fn_2298	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication
unknown
	unknown_0
	unknown_1
	unknown_2
	unknown_3
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallcoughfevergender	head_acheshortness_of_breathsore_throattest_indicationunknown	unknown_0	unknown_1	unknown_2	unknown_3*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *_
fZRX
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_22852
StatefulPartitionedCall?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?
?
;__inference_gradient_boosted_trees_model_layer_call_fn_2736
inputs_cough	
inputs_fever	
inputs_gender
inputs_head_ache	
inputs_shortness_of_breath	
inputs_sore_throat	
inputs_test_indication
unknown
	unknown_0
	unknown_1
	unknown_2
	unknown_3
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputs_coughinputs_feverinputs_genderinputs_head_acheinputs_shortness_of_breathinputs_sore_throatinputs_test_indicationunknown	unknown_0	unknown_1	unknown_2	unknown_3*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *_
fZRX
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_23892
StatefulPartitionedCall?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:U Q
'
_output_shapes
:?????????
&
_user_specified_nameinputs/cough:UQ
'
_output_shapes
:?????????
&
_user_specified_nameinputs/fever:VR
'
_output_shapes
:?????????
'
_user_specified_nameinputs/gender:YU
'
_output_shapes
:?????????
*
_user_specified_nameinputs/head_ache:c_
'
_output_shapes
:?????????
4
_user_specified_nameinputs/shortness_of_breath:[W
'
_output_shapes
:?????????
,
_user_specified_nameinputs/sore_throat:_[
'
_output_shapes
:?????????
0
_user_specified_nameinputs/test_indication:

_output_shapes
: :


_output_shapes
: 
?
?
;__inference_gradient_boosted_trees_model_layer_call_fn_2423	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication
unknown
	unknown_0
	unknown_1
	unknown_2
	unknown_3
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallcoughfevergender	head_acheshortness_of_breathsore_throattest_indicationunknown	unknown_0	unknown_1	unknown_2	unknown_3*
Tin
2					*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:?????????* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *_
fZRX
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_23892
StatefulPartitionedCall?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?I
?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2485	
cough		
fever	

gender
	head_ache	
shortness_of_breath	
sore_throat	
test_indication.
*none_lookup_lookuptablefindv2_table_handle/
+none_lookup_lookuptablefindv2_default_value0
,none_lookup_1_lookuptablefindv2_table_handle1
-none_lookup_1_lookuptablefindv2_default_value
inference_op_model_handle
identity??None_Lookup/LookupTableFindV2?None_Lookup_1/LookupTableFindV2?inference_op\
CastCastcough*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast{
strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice/stack
strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice/stack_1
strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice/stack_2?
strided_sliceStridedSliceCast:y:0strided_slice/stack:output:0strided_slice/stack_1:output:0strided_slice/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice`
Cast_1Castfever*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_1
strided_slice_1/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_1/stack?
strided_slice_1/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_1/stack_1?
strided_slice_1/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_1/stack_2?
strided_slice_1StridedSlice
Cast_1:y:0strided_slice_1/stack:output:0 strided_slice_1/stack_1:output:0 strided_slice_1/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_1f
Cast_2Castsore_throat*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_2
strided_slice_2/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_2/stack?
strided_slice_2/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_2/stack_1?
strided_slice_2/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_2/stack_2?
strided_slice_2StridedSlice
Cast_2:y:0strided_slice_2/stack:output:0 strided_slice_2/stack_1:output:0 strided_slice_2/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_2n
Cast_3Castshortness_of_breath*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_3
strided_slice_3/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_3/stack?
strided_slice_3/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_3/stack_1?
strided_slice_3/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_3/stack_2?
strided_slice_3StridedSlice
Cast_3:y:0strided_slice_3/stack:output:0 strided_slice_3/stack_1:output:0 strided_slice_3/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_3d
Cast_4Cast	head_ache*

DstT0*

SrcT0	*'
_output_shapes
:?????????2
Cast_4
strided_slice_4/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_4/stack?
strided_slice_4/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_4/stack_1?
strided_slice_4/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_4/stack_2?
strided_slice_4StridedSlice
Cast_4:y:0strided_slice_4/stack:output:0 strided_slice_4/stack_1:output:0 strided_slice_4/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_4
strided_slice_5/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_5/stack?
strided_slice_5/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_5/stack_1?
strided_slice_5/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_5/stack_2?
strided_slice_5StridedSlicegenderstrided_slice_5/stack:output:0 strided_slice_5/stack_1:output:0 strided_slice_5/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_5
strided_slice_6/stackConst*
_output_shapes
:*
dtype0*
valueB"        2
strided_slice_6/stack?
strided_slice_6/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_6/stack_1?
strided_slice_6/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_6/stack_2?
strided_slice_6StridedSlicetest_indicationstrided_slice_6/stack:output:0 strided_slice_6/stack_1:output:0 strided_slice_6/stack_2:output:0*
Index0*
T0*#
_output_shapes
:?????????*

begin_mask*
end_mask*
shrink_axis_mask2
strided_slice_6?
None_Lookup/LookupTableFindV2LookupTableFindV2*none_lookup_lookuptablefindv2_table_handlestrided_slice_5:output:0+none_lookup_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2
None_Lookup/LookupTableFindV2?
None_Lookup_1/LookupTableFindV2LookupTableFindV2,none_lookup_1_lookuptablefindv2_table_handlestrided_slice_6:output:0-none_lookup_1_lookuptablefindv2_default_value*	
Tin0*

Tout0*#
_output_shapes
:?????????2!
None_Lookup_1/LookupTableFindV2?
stackPackstrided_slice:output:0strided_slice_1:output:0strided_slice_4:output:0strided_slice_3:output:0strided_slice_2:output:0*
N*
T0*'
_output_shapes
:?????????*

axis2
stackU
ConstConst*
_output_shapes
:  *
dtype0*
value
B  2
Const?
stack_1Pack&None_Lookup/LookupTableFindV2:values:0(None_Lookup_1/LookupTableFindV2:values:0*
N*
T0*'
_output_shapes
:?????????*

axis2	
stack_1q
RaggedConstant/valuesConst*
_output_shapes
: *
dtype0*
valueB 2
RaggedConstant/valuesv
RaggedConstant/ConstConst*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Constz
RaggedConstant/Const_1Const*
_output_shapes
:*
dtype0	*
valueB	R 2
RaggedConstant/Const_1?
inference_opSimpleMLInferenceOpWithHandlestack:output:0Const:output:0stack_1:output:0RaggedConstant/values:output:0RaggedConstant/Const:output:0RaggedConstant/Const_1:output:0inference_op_model_handle*-
_output_shapes
:?????????:*
dense_output_dim2
inference_op
strided_slice_7/stackConst*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack?
strided_slice_7/stack_1Const*
_output_shapes
:*
dtype0*
valueB"       2
strided_slice_7/stack_1?
strided_slice_7/stack_2Const*
_output_shapes
:*
dtype0*
valueB"      2
strided_slice_7/stack_2?
strided_slice_7StridedSlice inference_op:dense_predictions:0strided_slice_7/stack:output:0 strided_slice_7/stack_1:output:0 strided_slice_7/stack_2:output:0*
Index0*
T0*'
_output_shapes
:?????????*

begin_mask*
end_mask2
strided_slice_7?
IdentityIdentitystrided_slice_7:output:0^None_Lookup/LookupTableFindV2 ^None_Lookup_1/LookupTableFindV2^inference_op*
T0*'
_output_shapes
:?????????2

Identity"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*?
_input_shapes?
?:?????????:?????????:?????????:?????????:?????????:?????????:?????????: : : : : 2>
None_Lookup/LookupTableFindV2None_Lookup/LookupTableFindV22B
None_Lookup_1/LookupTableFindV2None_Lookup_1/LookupTableFindV22
inference_opinference_op:N J
'
_output_shapes
:?????????

_user_specified_namecough:NJ
'
_output_shapes
:?????????

_user_specified_namefever:OK
'
_output_shapes
:?????????
 
_user_specified_namegender:RN
'
_output_shapes
:?????????
#
_user_specified_name	head_ache:\X
'
_output_shapes
:?????????
-
_user_specified_nameshortness_of_breath:TP
'
_output_shapes
:?????????
%
_user_specified_namesore_throat:XT
'
_output_shapes
:?????????
)
_user_specified_nametest_indication:

_output_shapes
: :


_output_shapes
: 
?
?
__inference__traced_save_2959
file_prefix)
%savev2_is_trained_read_readvariableop
$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop&
"savev2_total_1_read_readvariableop&
"savev2_count_1_read_readvariableop
savev2_const_6

identity_1??MergeV2Checkpoints?
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*2
StaticRegexFullMatchc
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.part2
Constl
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part2	
Const_1?
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: 2
Selectt

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: 2

StringJoinZ

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :2

num_shards
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : 2
ShardedFilename/shard?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: 2
ShardedFilename?
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*?
value?B?B&_is_trained/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/1/count/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH2
SaveV2/tensor_names?
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B B B B 2
SaveV2/shape_and_slices?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0%savev2_is_trained_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop"savev2_total_1_read_readvariableop"savev2_count_1_read_readvariableopsavev2_const_6"/device:CPU:0*
_output_shapes
 *
dtypes

2
2
SaveV2?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:2(
&MergeV2Checkpoints/checkpoint_prefixes?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 2
MergeV2Checkpointsr
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: 2

Identitym

Identity_1IdentityIdentity:output:0^MergeV2Checkpoints*
T0*
_output_shapes
: 2

Identity_1"!

identity_1Identity_1:output:0*!
_input_shapes
: : : : : : : 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: "?L
saver_filename:0StatefulPartitionedCall_4:0StatefulPartitionedCall_58"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*?
serving_default?
7
cough.
serving_default_cough:0	?????????
7
fever.
serving_default_fever:0	?????????
9
gender/
serving_default_gender:0?????????
?
	head_ache2
serving_default_head_ache:0	?????????
S
shortness_of_breath<
%serving_default_shortness_of_breath:0	?????????
C
sore_throat4
serving_default_sore_throat:0	?????????
K
test_indication8
!serving_default_test_indication:0?????????>
output_12
StatefulPartitionedCall_3:0?????????tensorflow/serving/predict2"

asset_path_initializer:0done24

asset_path_initializer_1:0nodes-00000-of-000012@

asset_path_initializer_2:0 gradient_boosted_trees_header.pb2)

asset_path_initializer_3:0	header.pb2,

asset_path_initializer_4:0data_spec.pb:?u
?
_learner_params
	_features
_is_trained
	optimizer
loss

_model
regularization_losses
trainable_variables
		variables

	keras_api

signatures
,_default_save_signature
*-&call_and_return_all_conditional_losses
.__call__
/call
0yggdrasil_model_path_tensor"?
_tf_keras_model?{"name": "gradient_boosted_trees_model", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "must_restore_from_config": false, "class_name": "GradientBoostedTreesModel", "config": {"layer was saved without config": true}, "is_graph_network": false, "save_spec": {"cough": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "int64", "cough"]}, "fever": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "int64", "fever"]}, "sore_throat": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "int64", "sore_throat"]}, "shortness_of_breath": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "int64", "shortness_of_breath"]}, "head_ache": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "int64", "head_ache"]}, "gender": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "string", "gender"]}, "test_indication": {"class_name": "TypeSpec", "type_spec": "tf.TensorSpec", "serialized": [{"class_name": "TensorShape", "items": [null, 1]}, "string", "test_indication"]}}, "keras_version": "2.5.0", "backend": "tensorflow", "model_config": {"class_name": "GradientBoostedTreesModel"}, "training_config": {"loss": null, "metrics": [[{"class_name": "MeanMetricWrapper", "config": {"name": "accuracy", "dtype": "float32", "fn": "binary_accuracy"}, "shared_object_id": 0}]], "weighted_metrics": null, "loss_weights": null, "optimizer_config": {"class_name": "RMSprop", "config": {"name": "RMSprop", "learning_rate": 0.001, "decay": 0.0, "rho": 0.9, "momentum": 0.0, "epsilon": 1e-07, "centered": false}}}}
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
:
 2
is_trained
"
	optimizer
 "
trackable_dict_wrapper
G
_input_builder
_compiled_model"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
'
0"
trackable_list_wrapper
?

layers
layer_metrics
regularization_losses
metrics
trainable_variables
		variables
non_trainable_variables
layer_regularization_losses
.__call__
,_default_save_signature
*-&call_and_return_all_conditional_losses
&-"call_and_return_conditional_losses"
_generic_user_object
,
1serving_default"
signature_map
l
_feature_name_to_idx
	_init_ops
#categorical_str_to_int_hashmaps"
_generic_user_object
S
_model_loader
2_create_resource
3_initialize
4_destroy_resourceR 
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
.
0
1"
trackable_list_wrapper
'
0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
A

gender
test_indication"
trackable_dict_wrapper
>

_all_files

_done_file"
_generic_user_object
?
	total
	count
	variables
 	keras_api"?
_tf_keras_metric?{"class_name": "Mean", "name": "loss", "dtype": "float32", "config": {"name": "loss", "dtype": "float32"}, "shared_object_id": 1}
?
	!total
	"count
#
_fn_kwargs
$	variables
%	keras_api"?
_tf_keras_metric?{"class_name": "MeanMetricWrapper", "name": "accuracy", "dtype": "float32", "config": {"name": "accuracy", "dtype": "float32", "fn": "binary_accuracy"}, "shared_object_id": 0}
R
&_initializer
5_create_resource
6_initialize
7_destroy_resourceR 
R
'_initializer
8_create_resource
9_initialize
:_destroy_resourceR 
C
(0
)1
*2
+3
4"
trackable_list_wrapper
* 
:  (2total
:  (2count
.
0
1"
trackable_list_wrapper
-
	variables"
_generic_user_object
:  (2total
:  (2count
 "
trackable_dict_wrapper
.
!0
"1"
trackable_list_wrapper
-
$	variables"
_generic_user_object
"
_generic_user_object
"
_generic_user_object
*
*
*
*
?2?
__inference__wrapped_model_2213?
???
FullArgSpec
args? 
varargsjargs
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
?2?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2632
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2694
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2485
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2547?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
;__inference_gradient_boosted_trees_model_layer_call_fn_2298
;__inference_gradient_boosted_trees_model_layer_call_fn_2715
;__inference_gradient_boosted_trees_model_layer_call_fn_2736
;__inference_gradient_boosted_trees_model_layer_call_fn_2423?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
__inference_call_2798?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
,__inference_yggdrasil_model_path_tensor_2804?
???
FullArgSpec
args?
jself
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?B?
"__inference_signature_wrapper_2570coughfevergender	head_acheshortness_of_breathsore_throattest_indication"?
???
FullArgSpec
args? 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
__inference__creator_2809?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__initializer_2817?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__destroyer_2822?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__creator_2827?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__initializer_2835?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__destroyer_2840?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__creator_2845?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__initializer_2853?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
?2?
__inference__destroyer_2858?
???
FullArgSpec
args? 
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *? 
	J
Const
J	
Const_1
J	
Const_2
J	
Const_3
J	
Const_4
J	
Const_55
__inference__creator_2809?

? 
? "? 5
__inference__creator_2827?

? 
? "? 5
__inference__creator_2845?

? 
? "? 7
__inference__destroyer_2822?

? 
? "? 7
__inference__destroyer_2840?

? 
? "? 7
__inference__destroyer_2858?

? 
? "? =
__inference__initializer_2817?

? 
? "? >
__inference__initializer_2835=>?

? 
? "? >
__inference__initializer_2853?@?

? 
? "? ?
__inference__wrapped_model_2213?;<???
???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
? "3?0
.
output_1"?
output_1??????????
__inference_call_2798?;<???
???
???
/
cough&?#
inputs/cough?????????	
/
fever&?#
inputs/fever?????????	
1
gender'?$
inputs/gender?????????
7
	head_ache*?'
inputs/head_ache?????????	
K
shortness_of_breath4?1
inputs/shortness_of_breath?????????	
;
sore_throat,?)
inputs/sore_throat?????????	
C
test_indication0?-
inputs/test_indication?????????
p 
? "???????????
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2485?;<???
???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
p 
? "%?"
?
0?????????
? ?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2547?;<???
???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
p
? "%?"
?
0?????????
? ?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2632?;<???
???
???
/
cough&?#
inputs/cough?????????	
/
fever&?#
inputs/fever?????????	
1
gender'?$
inputs/gender?????????
7
	head_ache*?'
inputs/head_ache?????????	
K
shortness_of_breath4?1
inputs/shortness_of_breath?????????	
;
sore_throat,?)
inputs/sore_throat?????????	
C
test_indication0?-
inputs/test_indication?????????
p 
? "%?"
?
0?????????
? ?
V__inference_gradient_boosted_trees_model_layer_call_and_return_conditional_losses_2694?;<???
???
???
/
cough&?#
inputs/cough?????????	
/
fever&?#
inputs/fever?????????	
1
gender'?$
inputs/gender?????????
7
	head_ache*?'
inputs/head_ache?????????	
K
shortness_of_breath4?1
inputs/shortness_of_breath?????????	
;
sore_throat,?)
inputs/sore_throat?????????	
C
test_indication0?-
inputs/test_indication?????????
p
? "%?"
?
0?????????
? ?
;__inference_gradient_boosted_trees_model_layer_call_fn_2298?;<???
???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
p 
? "???????????
;__inference_gradient_boosted_trees_model_layer_call_fn_2423?;<???
???
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????
p
? "???????????
;__inference_gradient_boosted_trees_model_layer_call_fn_2715?;<???
???
???
/
cough&?#
inputs/cough?????????	
/
fever&?#
inputs/fever?????????	
1
gender'?$
inputs/gender?????????
7
	head_ache*?'
inputs/head_ache?????????	
K
shortness_of_breath4?1
inputs/shortness_of_breath?????????	
;
sore_throat,?)
inputs/sore_throat?????????	
C
test_indication0?-
inputs/test_indication?????????
p 
? "???????????
;__inference_gradient_boosted_trees_model_layer_call_fn_2736?;<???
???
???
/
cough&?#
inputs/cough?????????	
/
fever&?#
inputs/fever?????????	
1
gender'?$
inputs/gender?????????
7
	head_ache*?'
inputs/head_ache?????????	
K
shortness_of_breath4?1
inputs/shortness_of_breath?????????	
;
sore_throat,?)
inputs/sore_throat?????????	
C
test_indication0?-
inputs/test_indication?????????
p
? "???????????
"__inference_signature_wrapper_2570?;<???
? 
???
(
cough?
cough?????????	
(
fever?
fever?????????	
*
gender ?
gender?????????
0
	head_ache#? 
	head_ache?????????	
D
shortness_of_breath-?*
shortness_of_breath?????????	
4
sore_throat%?"
sore_throat?????????	
<
test_indication)?&
test_indication?????????"3?0
.
output_1"?
output_1?????????K
,__inference_yggdrasil_model_path_tensor_2804?

? 
? "? 