import gleam/list
import gleam/string
import nakai/html.{Node}
import nakai/html/attrs
import gitcove/templates/base
import gitcove/components/blob_view.{blob_view}
import gitcove/components/tree_view.{tree_view}
import gitcove/components/breadcrumb.{Crumb, breadcrumb}
import gitcove/utilities/git
import gitcove/utilities/nakai.{with}
import gitcove/utilities/nakai/node

pub fn page(
  owner: String,
  repo: String,
  ref: String,
  path: List(String),
) -> Node(a) {
  let crumbs = [
    Crumb(name: owner, link: "/" <> owner),
    Crumb(
      name: repo,
      link: string.join(["", owner, repo, "tree", ref], with: "/"),
    ),
    ..list.index_map(
      path,
      fn(i, part) {
        Crumb(
          name: part,
          link: string.join(
            ["", owner, repo, "tree", ref, ..list.take(path, i + 1)],
            with: "/",
          ),
        )
      },
    )
  ]

  base.document([
    {
      use <- with(attrs.class("flex flex-col gap-2"))

      node.div([breadcrumb([], crumbs), git_object(owner, repo, ref, path)])
    },
  ])
}

fn git_object(
  owner owner: String,
  repo repo: String,
  ref ref: String,
  path path: List(String),
) -> Node(a) {
  case git.get_type(owner, repo, ref, path) {
    "tree" ->
      tree_view(
        git.ls_tree(owner, repo, ref, path),
        url_prefix: string.join(
          ["", owner, repo, "tree", ref, ..path],
          with: "/",
        ),
      )
    "blob" -> blob_view(git.cat_file(owner, repo, ref, path))
  }
}
