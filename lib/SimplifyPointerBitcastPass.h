// Copyright 2022 The Clspv Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"

#ifndef _CLSPV_LIB_SIMPLIFY_POINTER_BITCASTS_PASS_H
#define _CLSPV_LIB_SIMPLIFY_POINTER_BITCASTS_PASS_H

namespace clspv {
struct SimplifyPointerBitcastPass
    : llvm::PassInfoMixin<SimplifyPointerBitcastPass> {
  llvm::PreservedAnalyses run(llvm::Module &M, llvm::ModuleAnalysisManager &);

  bool runOnGEPFromBitcastCstExpr(llvm::Module &M) const;
  bool runOnTrivialBitcast(llvm::Module &M) const;
  bool runOnBitcastFromBitcast(llvm::Module &M) const;
  bool runOnBitcastFromGEP(llvm::Module &M) const;
  bool runOnGEPFromGEP(llvm::Module &M) const;
};
} // namespace clspv

#endif // _CLSPV_LIB_SIMPLIFY_POINTER_BITCASTS_PASS_H
