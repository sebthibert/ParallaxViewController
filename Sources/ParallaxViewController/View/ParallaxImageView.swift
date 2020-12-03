import UIKit

@available(iOS 13.0, *)
protocol ParallaxImageViewDelegate: AnyObject {
  func didTapImageView(_ sender: ParallaxImageView)
}

@available(iOS 13.0, *)
class ParallaxImageView: UIImageView {
  let gradientView: ParallaxGradientView
  private weak var delegate: ParallaxImageViewDelegate?

  init(delegate: ParallaxImageViewDelegate?, backgroundColor: UIColor, contentMode: UIView.ContentMode, isUserInteractionEnabled: Bool) {
    self.delegate = delegate
    gradientView = ParallaxGradientView(topColor: .black, bottomColor: .clear)
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.contentMode = contentMode
    self.isUserInteractionEnabled = isUserInteractionEnabled
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(gradientView)
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
      gradientView.heightAnchor.constraint(equalToConstant: 150),
    ])
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
    addGestureRecognizer(tapGesture)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @objc private func tapGestureAction() {
    delegate?.didTapImageView(self)
  }
}
