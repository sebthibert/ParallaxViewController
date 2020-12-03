import UIKit

@available(iOS 13.0, *)
public enum ParallaxImageConfiguration {
  case name(String?)
  case data(Data?)
  case literal(UIImage?)

  var image: UIImage? {
    var image: UIImage? = nil
    switch self {
    case .name(let name):
      if let name = name {
        image = UIImage(named: name)
      }
    case .data(let data):
      if let data = data {
        image = UIImage(data: data)
      }
    case .literal(let literalImage):
      image = literalImage
    }
    return image
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

  init(title: String? = nil, imageConfiguration: ParallaxImageConfiguration, arrangedSubviews: [UIView] = []) {
    self.title = title
    self.imageConfiguration = imageConfiguration
    self.arrangedSubviews = arrangedSubviews
  }
}
