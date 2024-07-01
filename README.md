## pcg-c build with Zig

This project builds [pcg-c](https://github.com/imneme/pcg-c) with Zig.
These are _not_ Zig bindings to the project. pcg-c is a straightforward
library so 

## Usage

```zig
.{
    .name = "my-project",
    .version = "0.0.0",
    .dependencies = .{
        .libpng = .{
            .url = "https://github.com/chiumichael/pcg-zig/archive/<git-ref-here>.tar.gz",
            .hash = "12208070233b17de6be05e32af096a6760682b48598323234824def41789e993432c",
        },
    },
}
```

And in your `build.zig`:

```zig
const libpcg = b.dependency("libpcg", .{target = target};
exe.linkLibrary(libpcg.artifact("pcg"));
```

Then you can easily `@cImport` the project. 

### Tests

The two test scripts `run-test-high-tests.sh` and `run-test-low-tests.sh`
are adapted from the the original `pcp-c` project. 
Run the test scripts to double-check that the libraries have built correctly.
