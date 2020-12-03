import UIKit

@available(iOS 13.0, *)
class ParallaxStackView: UIStackView {
  init(spacing: CGFloat) {
    super.init(frame: .zero)
    self.spacing = spacing
    axis = .vertical
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
