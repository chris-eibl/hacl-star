module Hacl.Impl.BignumQ.Mul

module ST = FStar.HyperStack.ST
open FStar.HyperStack.All
open FStar.Mul

open Lib.IntTypes
open Lib.Buffer

module F56 = Hacl.Impl.Ed25519.Field56

inline_for_extraction noextract
let qelemB = lbuffer uint64 5ul

val barrett_reduction:
    z:qelemB
  -> t:lbuffer uint64 10ul ->
  Stack unit
    (requires fun h -> live h z /\ live h t)
    (ensures  fun h0 _ h1 -> modifies (loc z) h0 h1)

val mul_modq:
    z:qelemB
  -> x:qelemB
  -> y:qelemB ->
  Stack unit
    (requires fun h -> live h z /\ live h x /\ live h y /\
      (let s = as_seq h x in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000) /\
      (let s = as_seq h y in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000))
    (ensures  fun h0 _ h1 -> modifies (loc z) h0 h1 /\
      (let s = as_seq h1 z in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000) /\
      F56.as_nat h1 z == (F56.as_nat h0 x * F56.as_nat h0 y) % Spec.Ed25519.q
    )

val add_modq:
    z:qelemB
  -> x:qelemB
  -> y:qelemB ->
  Stack unit
    (requires fun h ->
      live h z /\ live h x /\ live h y /\
      (let s = as_seq h x in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000) /\
      (let s = as_seq h y in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000))
    (ensures  fun h0 _ h1 -> modifies (loc z) h0 h1 /\
      (let s = as_seq h1 z in
       let op_String_Access = Seq.index in
       v s.[0] < 0x100000000000000 /\
       v s.[1] < 0x100000000000000 /\
       v s.[2] < 0x100000000000000 /\
       v s.[3] < 0x100000000000000 /\
       v s.[4] < 0x100000000000000) /\
      F56.as_nat h1 z == (F56.as_nat h0 x + F56.as_nat h0 y) % Spec.Ed25519.q
    )
