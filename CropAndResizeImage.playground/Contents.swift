import UIKit

extension UIImage {

  // Returns a cropped and resized image in a single draw.
  func cropped(at rect: CGRect, andResizedTo finalSize: CGSize) -> UIImage {
    let widthScale = finalSize.width / rect.size.width
    let heightScale = finalSize.height / rect.size.height

    let drawRect = CGRect(x: -(rect.origin.x * widthScale),
                          y: -(rect.origin.y * heightScale),
                          width: self.size.width * widthScale,
                          height: self.size.height * widthScale)

    let format = UIGraphicsImageRendererFormat()
    // We should set it to 1 otherwise it will use main screen's scale,
    // which is 2 for retina display, resulting in larger image jpeg data byte size.
    format.scale = 1

    let renderer = UIGraphicsImageRenderer(size: finalSize, format: format)
    return renderer.image() { _ in
      self.draw(in: drawRect)
    }
  }

}

let inputImage = UIImage(named: "portrait.jpg")! // w 4,032 h 3,024   2947161 bytes
inputImage.imageOrientation.rawValue
inputImage.jpegData(compressionQuality: 0.8)!

let outputImage = inputImage.cropped(
  at: CGRect(x: 0, y: 0, width: 1000, height: 1000),
  andResizedTo: CGSize(width: 600, height: 600)
)

outputImage
outputImage.size // 600 600

// format.scale = 2, format.opaque = true  -> 1774151 bytes
// format.scale = 2, format.opaque = false -> 1954047 bytes
// format.scale = 1, format.opaque = true  -> 545412 bytes
// format.scale = 1, format.opaque = false -> 592678 bytes
outputImage.pngData()!

// format.scale = 2, format.opaque = true  -> 199283 bytes
// format.scale = 2, format.opaque = false -> 199304 bytes
// format.scale = 1, format.opaque = true  -> 65988 bytes
// format.scale = 1, format.opaque = false -> 65968 bytes
outputImage.jpegData(compressionQuality: 0.8)!

outputImage.imageOrientation.rawValue // note the orientation is corrected
