"""Provides the repository macro to import absl."""

load("//third_party:repo.bzl", "tf_http_archive", "tf_mirror_urls")

def repo():
    """Imports absl."""

    # Attention: tools parse and update these lines.
    # LINT.IfChange
    ABSL_COMMIT = "67d126083c1584dd7dc584d700f853afaec365ca"
    ABSL_SHA256 = "8652366395b2f20628281fd98c4413e9947d989fcb214f8bdc56351e8cd7e7d4"
    # LINT.ThenChange(//tensorflow/lite/tools/cmake/modules/abseil-cpp.cmake)

    SYS_DIRS = [
        "algorithm",
        "base",
        "cleanup",
        "container",
        "debugging",
        "flags",
        "functional",
        "hash",
        "memory",
        "meta",
        "numeric",
        "random",
        "status",
        "strings",
        "synchronization",
        "time",
        "types",
        "utility",
    ]
    SYS_LINKS = {
        "//third_party/absl:system.absl.{name}.BUILD".format(name = n): "absl/{name}/BUILD.bazel".format(name = n)
        for n in SYS_DIRS
    }

    tf_http_archive(
        name = "com_google_absl",
        sha256 = ABSL_SHA256,
        build_file = "//third_party/absl:com_google_absl.BUILD",
        system_build_file = "//third_party/absl:system.BUILD",
        system_link_files = SYS_LINKS,
        strip_prefix = "abseil-cpp-{commit}".format(commit = ABSL_COMMIT),
        urls = tf_mirror_urls("https://github.com/abseil/abseil-cpp/archive/{commit}.tar.gz".format(commit = ABSL_COMMIT)),
        patch_file = ["//third_party/absl:nvidia_jetson.patch"],
    )
