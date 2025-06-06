// RUN: iree-opt --split-input-file --pass-pipeline="builtin.module(vm.module(iree-vm-ordinal-allocation),vm.module(iree-convert-vm-to-emitc))" %s | FileCheck %s

vm.module @my_module {
  // CHECK-LABEL: emitc.func private @my_module_buffer_fill_f64
  vm.func @buffer_fill_f64(%buf : !vm.buffer) {
    // CHECK: %[[C0:.+]] = "emitc.constant"() <{value = 0 : i64}> : () -> i64
    // CHECK: %[[C16:.+]] = "emitc.constant"() <{value = 16 : i64}> : () -> i64
    // CHECK: %[[C102:.+]] = "emitc.constant"() <{value = 1.020000e+02 : f64}> : () -> f64

    // CHECK: %[[BUFFER_REF:.+]] = apply "*"(%arg3) : (!emitc.ptr<!emitc.opaque<"iree_vm_ref_t">>) -> !emitc.opaque<"iree_vm_ref_t">
    // CHECK-NEXT: %[[BUFFER_PTR:.+]] = call_opaque "iree_vm_buffer_deref"(%[[BUFFER_REF]]) : (!emitc.opaque<"iree_vm_ref_t">) -> !emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>

    // CHECK: %[[STATUS:.+]] = call_opaque "vm_buffer_fill_f64"(%[[BUFFER_PTR]], %[[C0]], %[[C16]], %[[C102]]) : (!emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>, i64, i64, f64) -> !emitc.opaque<"iree_status_t">
    %c0 = vm.const.i64 0
    %c16 = vm.const.i64 16
    %c102 = vm.const.f64 102.0
    vm.buffer.fill.f64 %buf, %c0, %c16, %c102 : f64 -> !vm.buffer
    vm.return
  }
}

// -----

vm.module @my_module {
  // CHECK-LABEL: emitc.func private @my_module_buffer_load_f64
  vm.func @buffer_load_f64(%buf : !vm.buffer) {
    // CHECK: %[[C0:.+]] = "emitc.constant"() <{value = 0 : i64}> : () -> i64

    // CHECK: %[[BUFFER_REF:.+]] = apply "*"(%arg3) : (!emitc.ptr<!emitc.opaque<"iree_vm_ref_t">>) -> !emitc.opaque<"iree_vm_ref_t">
    // CHECK-NEXT: %[[BUFFER_PTR:.+]] = call_opaque "iree_vm_buffer_deref"(%[[BUFFER_REF]]) : (!emitc.opaque<"iree_vm_ref_t">) -> !emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>

    // CHECK: %[[RESULT:.+]] = "emitc.variable"() <{value = 0.000000e+00 : f64}> : () -> !emitc.lvalue<f64>
    // CHECK-NEXT: %[[RESULT_PTR:.+]] = apply "&"(%[[RESULT]]) : (!emitc.lvalue<f64>) -> !emitc.ptr<f64>
    // CHECK-NEXT: %[[STATUS:.+]] = call_opaque "vm_buffer_load_f64"(%[[BUFFER_PTR]], %[[C0]], %[[RESULT_PTR]]) : (!emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>, i64, !emitc.ptr<f64>) -> !emitc.opaque<"iree_status_t">

    %c0 = vm.const.i64 0
    %v0 = vm.buffer.load.f64 %buf[%c0] : !vm.buffer -> f64
    vm.return
  }
}

// -----

vm.module @my_module {
  // CHECK-LABEL: emitc.func private @my_module_buffer_store_f64
  vm.func @buffer_store_f64(%buf : !vm.buffer) {
    // CHECK: %[[C0:.+]] = "emitc.constant"() <{value = 0 : i64}> : () -> i64
    // CHECK: %[[C102:.+]] = "emitc.constant"() <{value = 1.020000e+02 : f64}> : () -> f64

    // CHECK: %[[BUFFER_REF:.+]] = apply "*"(%arg3) : (!emitc.ptr<!emitc.opaque<"iree_vm_ref_t">>) -> !emitc.opaque<"iree_vm_ref_t">
    // CHECK-NEXT: %[[BUFFER_PTR:.+]] = call_opaque "iree_vm_buffer_deref"(%[[BUFFER_REF]]) : (!emitc.opaque<"iree_vm_ref_t">) -> !emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>

    // CHECK: %[[STATUS:.+]] = call_opaque "vm_buffer_store_f64"(%[[BUFFER_PTR]], %[[C0]], %[[C102]]) : (!emitc.ptr<!emitc.opaque<"iree_vm_buffer_t">>, i64, f64) -> !emitc.opaque<"iree_status_t">
    %c0 = vm.const.i64 0
    %c102 = vm.const.f64 102.0
    vm.buffer.store.f64 %c102, %buf[%c0] : f64 -> !vm.buffer
    vm.return
  }
}
