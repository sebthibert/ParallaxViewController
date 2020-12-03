import UIKit

@available(iOS 13.0, *)
class ParallaxImageContainerView: UIView {
  let imageView: ParallaxImageView

  init(delegate: ParallaxImageViewDelegate?) {
    imageView = ParallaxImageView(delegate: delegate, backgroundColor: .systemBackground, contentMode: .scaleAspectFill, isUserInteractionEnabled: false)
    super.init(frame: .zero)
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
