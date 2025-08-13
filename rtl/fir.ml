(* Minimal Hardcaml FIR core (educational). *)
open Hardcaml
module S = Signal

module I = struct
  type 'a t = {
    clk      : 'a;
    rst      : 'a;
    valid_in : 'a;
    x        : 'a;
    ready_in : 'a;
  } [@@deriving hardcaml]
end

module O = struct
  type 'a t = {
    valid_out : 'a;
    y         : 'a;
    ready_out : 'a;
  } [@@deriving hardcaml]
end

let create ~scope ~taps ~width (i : _ I.t) =
  let open S in
  let spec = Reg_spec.create ~clock:i.clk ~clear:i.rst () in
  let coeffs = Array.of_list taps in
  let n = Array.length coeffs in
  let x_regs = Array.init n (fun _ -> wire width) in
  x_regs.(0) <== i.x;
  for k = 1 to n - 1 do
    x_regs.(k) <== reg spec x_regs.(k-1)
  done;
  let prods =
    Array.mapi (fun k xr -> 
      let c = of_int ~width coeffs.(k) in
      uresize (xr *: c) (width*2)
    ) x_regs
  in
  let sum = Array.fold_left (+:) (zero (width*2)) prods in
  let y = uresize sum width in
  let v = reg spec i.valid_in in
  O.{ valid_out = v; y; ready_out = v }
