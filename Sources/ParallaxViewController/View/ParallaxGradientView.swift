import UIKit

@available(iOS 13.0, *)
class ParallaxGradientView: UIView {
  override class var layerClass: AnyClass {
    return CAGradientLayer.classForCoder()
  }

  init(topColor: UIColor, bottomColor: UIColor) {
    super.init(frame: .zero)
    let gradientLayer = layer as? CAGradientLayer
    gradientLayer?.colors = [topColor.cgColor, bottomColor.cgColor]
    backgroundColor = .clear
    alpha = 0.4
    isUserInteractionEnabled = false
    translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
