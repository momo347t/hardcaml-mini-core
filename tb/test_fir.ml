open Alcotest

let test_impulse () =
  (* Placeholder test; adapt to your Hardcaml version *)
  assert true

let () =
  run "hardcaml-mini-core" [
    "fir", [ test_case "impulse" `Quick test_impulse ];
  ]
