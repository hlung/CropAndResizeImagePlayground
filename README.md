# CropAndResizeImagePlayground

An Xcode playground demonstrating how to both crop AND resize image in a single draw. Mainly to optimize memory and time.
This project uses UIKit's `UIImageGraphicsRenderer`.

## Background

When we need to resize and crop image, we usually think it requires 2 separate operations, "crop" and "resize". This is inefficient. Images need to be uncompressed and store in memory before we can manipulate it. The memory used is quite large. A 3 MB jpg file can be expanded up to almost 40 MB. Doing several operations (e.g. crop and resize) can multiply this number further, creating a huge spike in memory usage and risk app termination by system.

It turns out that we can actually do both crop and resize in a single draw, using `UIGraphicsImageRenderer(size:format:)` with appropriate `size` and draw `rect` parameters.
