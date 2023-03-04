import gleam/int
import gleam/bool
import gleam/list
import gleam/string
import shellout

pub type TreeEntry {
  Commit(name: String, hash: String)
  Tree(name: String, hash: String)
  Blob(name: String, hash: String, size: Int)
}

pub fn cat_file(
  owner owner: String,
  repo repo: String,
  ref ref: String,
  path path: List(String),
) -> String {
  let assert Ok(data) =
    shellout.command(
      run: "/usr/bin/git",
      with: [
        "cat-file",
        "--textconv",
        ref <> ":" <> string.join(path, with: "/"),
      ],
      in: "/Users/dan/.repos/" <> owner <> "/" <> repo <> ".git",
      opt: [],
    )

  data
}

pub fn get_type(
  owner owner: String,
  repo repo: String,
  ref ref: String,
  path path: List(String),
) -> String {
  let assert Ok(kind) =
    shellout.command(
      run: "/usr/bin/git",
      with: ["cat-file", "-t", ref <> ":" <> string.join(path, with: "/")],
      in: "/Users/dan/.repos/" <> owner <> "/" <> repo <> ".git",
      opt: [],
    )

  string.trim(kind)
}

pub fn ls_tree(
  owner owner: String,
  repo repo: String,
  ref ref: String,
  path path: List(String),
) -> List(TreeEntry) {
  let assert Ok(tree) =
    shellout.command(
      run: "/usr/bin/git",
      with: ["ls-tree", "-l", ref, "./" <> string.join(path, with: "/") <> "/"],
      in: "/Users/dan/.repos/" <> owner <> "/" <> repo <> ".git",
      opt: [],
    )

  string.split(tree, on: "\n")
  |> list.filter(fn(item) { bool.negate(string.is_empty(item)) })
  |> list.map(fn(line) {
    let parts =
      line
      |> string.replace(each: "\t", with: " ")
      |> string.split(on: " ")
      |> list.filter(fn(item) { bool.negate(string.is_empty(item)) })

    let assert Ok(kind) = list.at(parts, 1)
    let assert Ok(hash) = list.at(parts, 2)
    let assert Ok(size) = list.at(parts, 3)
    let assert Ok(name) = list.at(parts, 4)
    let assert Ok(name) =
      string.split(name, on: "/")
      |> list.last

    case kind {
      "commit" -> Commit(name, hash)
      "tree" -> Tree(name, hash)
      "blob" -> {
        let assert Ok(size) = int.parse(size)

        Blob(name, hash, size)
      }
    }
  })
}
