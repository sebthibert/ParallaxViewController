import UIKit

@available(iOS 13.0, *)
public enum ParallaxImageConfiguration {
  case name(String?, CGFloat)
  case data(Data?, CGFloat)
  case literal(UIImage?, CGFloat)

  var image: UIImage? {
    var image: UIImage? = nil
    switch self {
    case .name(let name, _):
      if let name = name {
        image = UIImage(named: name)
      }
    case .data(let data, _):
      if let data = data {
        image = UIImage(data: data)
      }
    case .literal(let literalImage, _):
      image = literalImage
    }
    return image
  }

  var aspectRatio: CGFloat {
    switch self {
    case .name(_, let aspectRatio), .data(_, let aspectRatio), .literal(_, let aspectRatio):
      return aspectRatio
    }
  }

  var shouldShowImageContainer: Bool {
    image != nil
  }
}

@available(iOS 13.0, *)
public struct ParallaxConfiguration {
  let title: String?
  let imageConfiguration: ParallaxImageConfiguration
  let arrangedSubviews: [UIView]

  public init(title: String? = nil, imageConfiguration: ParallaxImageConfiguration, arrangedSubviews: [UIView] = []) {
    self.title = title
    self.imageConfiguration = imageConfiguration
    self.arrangedSubviews = arrangedSubviews
  }
}
