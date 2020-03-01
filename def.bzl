load("@bazel_gazelle//:deps.bzl", "go_repository")

# github_go_repository is a wrapper around go_repository to make the fetching of github repos easier
# by converting git clones to http archive downloads. The latter is fast, more reliable, actually
# cachable, and actually recommended by the Bazel team.
# It does have some caveats, so it's not meant to be a complete replacement of `go_repository`.
def github_go_repository(
  name,
  importpath,
  commit,
  repo_url = "",
  **kwargs):

  # when repo_url is not defined, we expect it to be the importpath
  if repo_url == "":
    repo_url = importpath

  repo = repo_url.split("/").pop()
  url = "https://" + repo_url + "/archive/" + commit + ".tar.gz"

  go_repository(
    name = name,
    importpath = importpath,
    strip_prefix = repo + "-" + commit,
    urls = [url],
    **kwargs)
