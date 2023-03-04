import gleam/int
import gleam/list
import nakai/html.{Node}
import gitcove/utilities.{cond}
import gitcove/utilities/bytes
import gitcove/utilities/nakai/node
import gitcove/utilities/nakai/with
import gitcove/utilities/git.{Blob, Commit, Tree, TreeEntry}
import gitcove/icons

pub fn tree_view(
  tree: List(TreeEntry),
  url_prefix url_prefix: String,
) -> Node(a) {
  node.table([
    node.tbody({
      use i, entry <- list.index_map(tree)

      use <- with.class(cond(
        when: int.is_even(i),
        then: "bg-base-200",
        else: "bg-base-100",
      ))

      node.tr([
        {
          use <- with.class("pl-1")
          use <- with.style("width: 1%;")

          node.td([
            {
              use <- with.class("w-4 h-4")

              case entry {
                Commit(_, _) -> icons.folder_minus()
                Tree(_, _) -> icons.folder()
                Blob(_, _, _) -> icons.file()
              }
            },
          ])
        },
        case entry {
          Commit(name, hash) -> {
            use <- with.class("px-1")

            node.td_text(name <> " @ " <> hash)
          }
          Tree(name, _hash) -> {
            use <- with.class("px-1 text-primary")

            node.td([
              {
                use <- with.class("hover:underline")
                use <- with.href(url_prefix <> "/" <> name)

                node.a_text(name)
              },
            ])
          }
          Blob(name, _hash, _size) -> {
            use <- with.class("px-1")

            node.td([
              {
                use <- with.class("hover:underline")
                use <- with.href(url_prefix <> "/" <> name)

                node.a_text(name)
              },
            ])
          }
        },
        {
          use <- with.class("px-1 text-right")

          node.td_text(case entry {
            Blob(_, _, size) -> bytes.to_human_size(size)
            _ -> "-"
          })
        },
      ])
    }),
  ])
}
