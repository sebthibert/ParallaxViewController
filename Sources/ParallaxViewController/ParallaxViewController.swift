import UIKit

@available(iOS 13.0, *)
public class ParallaxViewController: UIViewController, UIScrollViewDelegate {
  private let configuration: ParallaxConfiguration
  var parallaxView: ParallaxView!
  var previousNavigationBarHidden = false
  var previousStackViewMinY: CGFloat?

  public init(configuration: ParallaxConfiguration) {
    self.configuration = configuration
    super.init(nibName: nil, bundle: nil)
    parallaxView = ParallaxView(shouldShowImageContainer: configuration.imageConfiguration.shouldShowImageContainer, scrollViewDelegate: self, imageViewDelegate: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    parallaxView.scrollView.imageContainer.imageView.image = configuration.imageConfiguration.image
    view.addSubview(parallaxView)
    NSLayoutConstraint.activate([
      parallaxView.topAnchor.constraint(equalTo: view.topAnchor),
      parallaxView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      parallaxView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      parallaxView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    configuration.arrangedSubviews.forEach { parallaxView.scrollView.stackView.addArrangedSubview($0) }
  }

  public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { [weak self] _ in
      self?.setNavigationBar()
    }
    layoutHeaderView(width: size.width, scrollView: parallaxView.scrollView)
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBar()
    previousStackViewMinY = nil
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.tintColor = .label
    navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    navigationController?.navigationBar.shadowImage = nil
    previousStackViewMinY = parallaxView.stackViewMinY
  }

  public override var preferredStatusBarStyle: UIStatusBarStyle {
    let shouldShowLightContent = traitCollection.userInterfaceStyle == .dark ? true : !shouldShowNavigationBar
    return shouldShowLightContent ? .lightContent : .darkContent
  }

  var shouldShowNavigationBar: Bool {
    if let stackViewMinY = previousStackViewMinY {
      return stackViewMinY < view.safeAreaInsets.top
    } else {
      return parallaxView.stackViewMinY < view.safeAreaInsets.top
    }
  }

  func setNavigationBar() {
    setNavigationTint()
    let backgroundImage = shouldShowNavigationBar ? nil : UIImage()
    navigationController?.navigationBar.shadowImage = backgroundImage
    navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: .default)
    title = shouldShowNavigationBar ? configuration.title : nil
    previousNavigationBarHidden = shouldShowNavigationBar
  }

  func setNavigationTint() {
    let tint: UIColor = traitCollection.userInterfaceStyle == .dark ? .label : shouldShowNavigationBar ? .label : .systemBackground
    navigationController?.navigationBar.tintColor = tint
    setNeedsStatusBarAppearanceUpdate()
  }

  func layoutHeaderView(width: CGFloat, scrollView: UIScrollView) {
    if previousNavigationBarHidden != shouldShowNavigationBar {
      setNavigationBar()
    }
    let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
    let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    let topBarHeight = navigationBarHeight + statusBarHeight
    let imageContainerHeight = (width / (3840 / 2160)) - topBarHeight
    let headerHeight = imageContainerHeight - scrollView.contentOffset.y
    if scrollView.contentOffset.y < 0.0 {
      parallaxView?.imageContainerHeightConstraint?.constant = headerHeight
    } else {
      if scrollView.contentOffset.y >= imageContainerHeight {
        parallaxView?.imageContainerTopConstraint?.constant = headerHeight
        parallaxView?.imageContainerHeightConstraint?.constant = headerHeight
      } else {
        parallaxView?.imageContainerTopConstraint?.constant = view.frame.origin.y
        parallaxView?.imageContainerHeightConstraint?.constant = headerHeight
        parallaxView?.scrollView.imageContainer.imageView.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 1)
      }
    }
  }

  // MARK: - UIScrollViewDelegate

  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    layoutHeaderView(width: view.frame.width, scrollView: scrollView)
  }
}
