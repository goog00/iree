// Copyright 2025 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef IREE_COMPILER_CODEGEN_EXTERNALINTERFACES_CODEGENEXTERNALMODELS_H_
#define IREE_COMPILER_CODEGEN_EXTERNALINTERFACES_CODEGENEXTERNALMODELS_H_

namespace mlir {
class DialectRegistry;
} // namespace mlir

namespace mlir::iree_compiler::IREE::Codegen {

void registerCodegenExternalModels(DialectRegistry &registry);

} // namespace mlir::iree_compiler::IREE::Codegen

#endif // IREE_COMPILER_CODEGEN_EXTERNALINTERFACES_CODEGENEXTERNALMODELS_H_
