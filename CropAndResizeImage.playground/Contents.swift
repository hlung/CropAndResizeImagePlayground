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
    format.opaque = true

    // The renderer corrects the image orientation automatically.
    let renderer = UIGraphicsImageRenderer(size: finalSize, format: format)
    return renderer.image() { _ in
      // Draws the image on renderer canvas size,
      // as if it is translated and scaled to the specified rect.
      self.draw(in: drawRect)
    }
  }

}

let inputImage = UIImage(named: "portrait.jpg")!
inputImage.imageOrientation.rawValue
inputImage.jpegData(compressionQuality: 0.8)!

let outputImage = inputImage.cropped(at: CGRect(x: 1000, y: 0, width: 1000, height: 1000),
                                     andResizedTo: CGSize(width: 600, height: 600))

outputImage
outputImage.size
outputImage.jpegData(compressionQuality: 0.8)!
outputImage.imageOrientation.rawValue // note the orientation is corrected
