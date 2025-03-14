module Hacl.HMAC.Blake2b_256

module D = Hacl.Hash.Definitions

open Spec.Agile.HMAC
open Spec.Hash.Definitions
open FStar.HyperStack.ST
open Lib.IntTypes

open EverCrypt.Helpers

open Hacl.HMAC
open Hacl.Hash.Blake2b_256

#set-options "--z3rlimit 25 --fuel 0 --ifuel 0"

[@@ Comment "Write the HMAC-BLAKE2b MAC of a message (`data`) by using a key (`key`) into `dst`.

The key can be any length and will be hashed if it is longer and padded if it is shorter than 128 bytes.
`dst` must point to 64 bytes of memory."]
let compute_blake2b_256: compute_st Blake2B =
  mk_compute (D.mk_impl Blake2B Hacl.Impl.Blake2.Core.M256)
             hash alloca init update_multi update_last finish
