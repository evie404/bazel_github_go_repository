# github_go_repository

`github_go_repository` is a thin wrapper around [bazel_gazelle](https://github.com/bazelbuild/bazel-gazelle/) `go_repository` to better support HTTP caching for Github-hosted Go libraries.

## Usage

Add to `WORKSPACE` after importing `bazel_gazelle`:

```python
http_archive(
    name = "bazel_gazelle",
    # omitted
)

# github_go_repository is a thin wrapper around gazelle's go_repository which supports some level of http caching
http_archive(
    name = "github_go_repository",
    sha256 = "7778d639ed16b4167d2825649ca7a46761ccacb4990e23da5bfcc59474f8ccdb",
    strip_prefix = "github_go_repository-0.1",
    urls = [
        "https://github.com/rickypai/github_go_repository/archive/0.1.zip",
    ],
)

load("@github_go_repository//:def.bzl", "github_go_repository")
```

Then instead of using `go_repository`, use `github_go_repository`:

```python
github_go_repository(
    name = "org_golang_google_grpc",
    commit = "f495f5b15ae7ccda3b38c53a1bfcde4c1a58a2bc",  # 1.27.1
    importpath = "google.golang.org/grpc",
    sha256 = "ef0b0804485e2ce1da0bc6daa7f1073b0f7fc4c7971b6337271e9ff8bc7081d1",
    repo_url = "github.com/grpc/grpc-go",  # optional; specific to github_go_repository when the repo URL is different from the importpath
)
```

## Risks

> Archives served by GitHub do not have stable SHA-256 sums. They haven't changed in a couple years, but it's broken us in the past. Use at your own risk.

https://github.com/bazelbuild/bazel-gazelle/issues/549#issuecomment-559238543
