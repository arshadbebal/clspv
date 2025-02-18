// RUN: clspv %s -o %t.spv -inline-entry-points -vec3-to-vec4
// RUN: spirv-dis -o %t2.spvasm %t.spv
// RUN: FileCheck %s < %t2.spvasm
// RUN: spirv-val --target-env vulkan1.0 %t.spv

// CHECK-DAG: %[[FLOAT_TYPE_ID:[a-zA-Z0-9_]*]] = OpTypeFloat 32
// CHECK-DAG: %[[FLOAT_VECTOR_TYPE_ID:[a-zA-Z0-9_]*]] = OpTypeVector %[[FLOAT_TYPE_ID]] 4
// CHECK-DAG: %[[CONSTANT_FLOAT_42_ID:[a-zA-Z0-9_]*]] = OpConstant %[[FLOAT_TYPE_ID]] 42
// CHECK-DAG: %[[UNDEF_FLOAT:[a-zA-Z0-9_]*]] = OpUndef %[[FLOAT_TYPE_ID]]
// CHECK-DAG: %[[COMPOSITE_FLOAT_42_ID:[a-zA-Z0-9_]*]] = OpConstantComposite %[[FLOAT_VECTOR_TYPE_ID]] %[[CONSTANT_FLOAT_42_ID]] %[[CONSTANT_FLOAT_42_ID]] %[[CONSTANT_FLOAT_42_ID]]
// CHECK: %[[LOADB_ID:[a-zA-Z0-9_]*]] = OpLoad %[[FLOAT_VECTOR_TYPE_ID]]
// CHECK: %[[OP_ID:[a-zA-Z0-9_]*]] = OpFDiv %[[FLOAT_VECTOR_TYPE_ID]] %[[LOADB_ID]] %[[COMPOSITE_FLOAT_42_ID]]
// CHECK: %[[OP_ID_INSERT_UNDEF:[a-zA-Z0-9_]*]] = OpCompositeInsert %[[FLOAT_VECTOR_TYPE_ID]] %[[UNDEF_FLOAT]] %[[OP_ID]] 3

void kernel __attribute__((reqd_work_group_size(1, 1, 1))) foo(global float3* a, global float3* b)
{
  *a = half_divide(*b, 42.0f);
}
