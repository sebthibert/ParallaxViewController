import UIKit

@available(iOS 13.0, *)
class ParallaxScrollView: UIScrollView {
  let imageContainer: ParallaxImageContainerView
  let stackView: ParallaxStackView

  init(scrollViewDelegate: UIScrollViewDelegate?, imageViewDelegate: ParallaxImageViewDelegate?, shouldShowImageContainer: Bool, alwaysBounceVertical: Bool, showsVerticalScrollIndicator: Bool) {
    imageContainer = ParallaxImageContainerView(delegate: imageViewDelegate)
    stackView = ParallaxStackView(spacing: 20)
    super.init(frame: .zero)
    self.delegate = scrollViewDelegate
    self.alwaysBounceVertical = alwaysBounceVertical
    self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    if shouldShowImageContainer {
      addSubview(imageContainer)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
