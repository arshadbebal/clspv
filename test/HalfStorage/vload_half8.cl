// RUN: clspv %s -o %t.spv -long-vector
// RUN: spirv-dis -o %t2.spvasm %t.spv
// RUN: FileCheck %s < %t2.spvasm
// RUN: spirv-val --target-env vulkan1.0 %t.spv

__kernel void test(__global half *a, int b, __global float8 *dst) {
    *dst = vload_half8(b, a);
}

// CHECK-DAG: [[half:%[^ ]+]] = OpTypeFloat 16
// CHECK-DAG: [[half4:%[^ ]+]] = OpTypeVector [[half]] 4
// CHECK-DAG: [[float:%[^ ]+]] = OpTypeFloat 32
// CHECK-DAG: [[float2:%[^ ]+]] = OpTypeVector [[float]] 2
// CHECK-DAG: [[uint:%[^ ]+]] = OpTypeInt 32 0
// CHECK-DAG: [[uint_0:%[^ ]+]] = OpConstant [[uint]] 0
// CHECK-DAG: [[uint_1:%[^ ]+]] = OpConstant [[uint]] 1
// CHECK-DAG: [[uint_2:%[^ ]+]] = OpConstant [[uint]] 2
// CHECK-DAG: [[uint_3:%[^ ]+]] = OpConstant [[uint]] 3
// CHECK-DAG: [[uint_4:%[^ ]+]] = OpConstant [[uint]] 4
// CHECK-DAG: [[uint_5:%[^ ]+]] = OpConstant [[uint]] 5
// CHECK-DAG: [[uint_6:%[^ ]+]] = OpConstant [[uint]] 6
// CHECK-DAG: [[uint_7:%[^ ]+]] = OpConstant [[uint]] 7

// CHECK-DAG: [[half_array:%[^ ]+]] = OpTypeRuntimeArray [[half]]
// CHECK-DAG: [[half_ptr:%[^ ]+]] = OpTypeStruct [[half_array]]
// CHECK-DAG: [[global_half_ptr:%[^ ]+]] = OpTypePointer StorageBuffer [[half_ptr]]

// CHECK: [[a:%[^ ]+]] = OpVariable [[global_half_ptr]] StorageBuffer
// CHECK: [[b:%[^ ]+]] = OpCompositeExtract [[uint]] {{.*}} 0

// CHECK: [[bx8:%[^ ]+]] = OpShiftLeftLogical [[uint]] [[b]] [[uint_3]]
// CHECK: [[addr0:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[bx8]]
// CHECK: [[val0:%[^ ]+]] = OpLoad [[half]] [[addr0]]

// CHECK: [[idx1:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] [[uint_1]]
// CHECK: [[addr1:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx1]]
// CHECK: [[val1:%[^ ]+]] = OpLoad [[half]] [[addr1]]

// CHECK: [[idx2:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] [[uint_2]]
// CHECK: [[addr2:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx2]]
// CHECK: [[val2:%[^ ]+]] = OpLoad [[half]] [[addr2]]

// CHECK: [[idx3:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] %uint_3
// CHECK: [[addr3:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx3]]
// CHECK: [[val3:%[^ ]+]] = OpLoad [[half]] [[addr3]]

// CHECK: [[idx4:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] %uint_4
// CHECK: [[addr4:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx4]]
// CHECK: [[val4:%[^ ]+]] = OpLoad [[half]] [[addr4]]

// CHECK: [[idx5:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] %uint_5
// CHECK: [[addr5:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx5]]
// CHECK: [[val5:%[^ ]+]] = OpLoad [[half]] [[addr5]]

// CHECK: [[idx6:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] %uint_6
// CHECK: [[addr6:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx6]]
// CHECK: [[val6:%[^ ]+]] = OpLoad [[half]] [[addr6]]

// CHECK: [[idx7:%[^ ]+]] = OpBitwiseOr [[uint]] [[bx8]] %uint_7
// CHECK: [[addr7:%[^ ]+]] = OpAccessChain {{.*}} [[a]] [[uint_0]] [[idx7]]
// CHECK: [[val7:%[^ ]+]] = OpLoad [[half]] [[addr7]]

// CHECK: [[valh4l:%[^ ]+]] = OpCompositeConstruct [[half4]] [[val0]] [[val1]] [[val2]] [[val3]]
// CHECK: [[valh4h:%[^ ]+]] = OpCompositeConstruct [[half4]] [[val4]] [[val5]] [[val6]] [[val7]]
// CHECK: [[vali32l:%[^ ]+]] = OpBitcast %v2uint [[valh4l]]
// CHECK: [[vali32h:%[^ ]+]] = OpBitcast %v2uint [[valh4h]]
// CHECK: [[val01i32l:%[^ ]+]] = OpCompositeExtract [[uint]] [[vali32l]] 0
// CHECK: [[val23i32l:%[^ ]+]] = OpCompositeExtract [[uint]] [[vali32l]] 1
// CHECK: [[val01i32h:%[^ ]+]] = OpCompositeExtract [[uint]] [[vali32h]] 0
// CHECK: [[val23i32h:%[^ ]+]] = OpCompositeExtract [[uint]] [[vali32h]] 1

// CHECK: [[val01:%[^ ]+]] = OpExtInst [[float2]] {{.*}} UnpackHalf2x16 [[val01i32l]]
// CHECK: [[val23:%[^ ]+]] = OpExtInst [[float2]] {{.*}} UnpackHalf2x16 [[val23i32l]]
// CHECK: [[val45:%[^ ]+]] = OpExtInst [[float2]] {{.*}} UnpackHalf2x16 [[val01i32h]]
// CHECK: [[val67:%[^ ]+]] = OpExtInst [[float2]] {{.*}} UnpackHalf2x16 [[val23i32h]]

// CHECK: [[val0:%[^ ]+]] = OpCompositeExtract [[float]] [[val01]] 0
// CHECK: [[val1:%[^ ]+]] = OpCompositeExtract [[float]] [[val01]] 1
// CHECK: [[val2:%[^ ]+]] = OpCompositeExtract [[float]] [[val23]] 0
// CHECK: [[val3:%[^ ]+]] = OpCompositeExtract [[float]] [[val23]] 1
// CHECK: [[val4:%[^ ]+]] = OpCompositeExtract [[float]] [[val45]] 0
// CHECK: [[val5:%[^ ]+]] = OpCompositeExtract [[float]] [[val45]] 1
// CHECK: [[val6:%[^ ]+]] = OpCompositeExtract [[float]] [[val67]] 0
// CHECK: [[val7:%[^ ]+]] = OpCompositeExtract [[float]] [[val67]] 1

// CHECK: [[addr0:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_0]]
// CHECK: OpStore [[addr0]] [[val0]]
// CHECK: [[addr1:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_1]]
// CHECK: OpStore [[addr1]] [[val1]]
// CHECK: [[addr2:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_2]]
// CHECK: OpStore [[addr2]] [[val2]]
// CHECK: [[addr3:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_3]]
// CHECK: OpStore [[addr3]] [[val3]]
// CHECK: [[addr4:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_4]]
// CHECK: OpStore [[addr4]] [[val4]]
// CHECK: [[addr5:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_5]]
// CHECK: OpStore [[addr5]] [[val5]]
// CHECK: [[addr6:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_6]]
// CHECK: OpStore [[addr6]] [[val6]]
// CHECK: [[addr7:%[^ ]+]] = OpAccessChain {{.*}} {{.*}} [[uint_0]] [[uint_0]] [[uint_7]]
// CHECK: OpStore [[addr7]] [[val7]]
