import gleam/int
import gleam/float

pub fn to_human_size(size: Int) -> String {
  let kib = 1024
  let mib = kib * 1024

  case size {
    _ if size >= mib -> make_human_size(size, mib, "MiB")
    _ if size >= kib -> make_human_size(size, kib, "KiB")
    _ -> make_human_size(size, 1, "B")
  }
}

fn make_human_size(size: Int, divisor: Int, unit: String) -> String {
  let unit_size = size / divisor
  let remainder = size % divisor

  case remainder {
    0 -> int.to_string(unit_size) <> " " <> unit
    _ -> {
      let after_dot =
        int.to_float(remainder) /. int.to_float(divisor) *. 10.0
        |> float.round

      int.to_string(unit_size) <> "." <> int.to_string(after_dot) <> " " <> unit
    }
  }
}
