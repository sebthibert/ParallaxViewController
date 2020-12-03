import UIKit

@available(iOS 13.0, *)
class ParallaxView: UIView {
  private(set) var scrollView: ParallaxScrollView!
  private(set) var imageContainerTopConstraint: NSLayoutConstraint!
  private(set) var imageContainerHeightConstraint: NSLayoutConstraint!

  var stackViewMinY: CGFloat {
    scrollView.stackView.convert(scrollView.stackView.bounds, to: nil).minY
  }

  init(shouldShowImageContainer: Bool, scrollViewDelegate: UIScrollViewDelegate?, imageViewDelegate: ParallaxImageViewDelegate?) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    scrollView = ParallaxScrollView(scrollViewDelegate: scrollViewDelegate, imageViewDelegate: imageViewDelegate, shouldShowImageContainer: shouldShowImageContainer, alwaysBounceVertical: true, showsVerticalScrollIndicator: false)
    addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.stackView.trailingAnchor, constant: 20),
      scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.stackView.bottomAnchor, constant: 20),
    ])
    if shouldShowImageContainer {
      imageContainerTopConstraint = scrollView.imageContainer.topAnchor.constraint(equalTo: topAnchor)
      imageContainerHeightConstraint = scrollView.imageContainer.heightAnchor.constraint(equalToConstant: 0)
      NSLayoutConstraint.activate([
        imageContainerTopConstraint,
        imageContainerHeightConstraint,
        scrollView.imageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        scrollView.stackView.topAnchor.constraint(equalTo: scrollView.imageContainer.bottomAnchor, constant: 20),
      ])
    } else {
      NSLayoutConstraint.activate([
        scrollView.stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
      ])
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
