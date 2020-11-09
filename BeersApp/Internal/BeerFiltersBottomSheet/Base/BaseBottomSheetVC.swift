//
//  BaseBottomSheetViewController.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


private struct Constants {
    let roundingCorners: UIRectCorner = [.topLeft, .topRight]
    let cornerRadii = CGSize(width: 16, height: 16)
    let animationDuration: TimeInterval = 0.25
    let updatePositionAnimationDuration: TimeInterval = 0.1
    let backgroundColor: UIColor = appColors.sandDune.withAlphaComponent(0.4)
    let bottomSheetBackgroundColor: UIColor = .clear
    let closeThreshold: CGFloat = 0.35
    let viewShadow = LayerShadow(color: appColors.sandDune, opacity: 0.3,
        offset: .zero, radius: 5)
}
private let constants = Constants()

class BaseBottomSheetViewController: UIViewController {
    private enum State {
        case expanded
        case closed
    }
    
    private let bottomSheetView = UIView()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let panGestureRecognizer = UIPanGestureRecognizer()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var shadowLayer: CAShapeLayer?
    
    private var contentSize: CGSize = .zero
    private var panTranslation: CGFloat = 0
    
    private var stateAfterPan: State = .expanded {
        didSet {
            if oldValue != stateAfterPan {
                feedbackGenerator.impactOccurred()
            }
        }
    }
    
    private var state: State = .closed {
        didSet {
            view.setNeedsLayout()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        updateBottomSheetPosition()
        setShadowLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        completeBottomSheetViewTransition(to: .expanded)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        closeBottomSheet()
    }
    
    func configurePresentationStyle() {
        modalPresentationStyle = .overCurrentContext
    }
    
    func setContentView(_ contentView: UIView) {
        bottomSheetView.subviews.forEach { $0.removeFromSuperview() }

        contentView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        updateContentSize()
        bottomSheetView.frame = CGRect(origin: .zero, size: contentSize)
    }
}

// MARK: - View configuration
private extension BaseBottomSheetViewController {
    func configureViewComponents() {
        view.backgroundColor = constants.backgroundColor
        
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.addTarget(self, action: #selector(tapGesture))
        view.addGestureRecognizer(tapGestureRecognizer)

        configureBottomSheetView()
    }
    
    func configureBottomSheetView() {
        bottomSheetView.backgroundColor = constants.bottomSheetBackgroundColor
        view.addSubview(bottomSheetView)
        
        panGestureRecognizer.delegate = self
        panGestureRecognizer.cancelsTouchesInView = false
        panGestureRecognizer.addTarget(self, action: #selector(panGesture))
        bottomSheetView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setShadowLayer() {
        if shadowLayer != nil {
            shadowLayer?.removeFromSuperlayer()
            shadowLayer = nil
        }
        
        let path = UIBezierPath(roundedRect: view.bounds,
            byRoundingCorners: constants.roundingCorners,
            cornerRadii: constants.cornerRadii)
        
        let shadowLayer = CAShapeLayer()
        let shapeLayer = CAShapeLayer()
        shapeLayer.addShadow(constants.viewShadow)
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = appColors.clear.cgColor
        
        shadowLayer.addShadow(constants.viewShadow)
        shadowLayer.path = path.cgPath
        shadowLayer.fillColor = appColors.white.cgColor
        shapeLayer.addSublayer(shadowLayer)
        
        bottomSheetView.layer.insertSublayer(shapeLayer, at: 0)
        
        self.shadowLayer = shapeLayer
    }
}

// MARK: - Tap gesture configuration
private extension BaseBottomSheetViewController {
    @objc func tapGesture(_ recognizer: UITapGestureRecognizer) {
        let tapPointY = recognizer.location(in: view).y
        let bottomSheetTop = bottomSheetView.frame.origin.y
        if tapPointY < bottomSheetTop {
            closeBottomSheet()
        }
    }
    
    func closeBottomSheet() {
        completeBottomSheetViewTransition(to: .closed, animated: true)
    }
}

// MARK: - Bottom sheet view state changes
private extension BaseBottomSheetViewController {
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view).y
        moveContainer(for: translation)
        
        if recognizer.state == .ended {
            finishPan()
        }
    }
    
    func moveContainer(for translation: CGFloat) {
        panTranslation = translation
        view.setNeedsLayout()
        
        let relativeTranslation = translation / contentSize.height
        stateAfterPan = relativeTranslation > constants.closeThreshold  ? .closed  : .expanded
    }
    
    func finishPan() {
        panTranslation = 0
        completeBottomSheetViewTransition(to: stateAfterPan)
    }
    
    private func completeBottomSheetViewTransition(to state: State, animated: Bool = true) {
        let duration = animated ? constants.animationDuration : 0
        UIView.animate(withDuration: duration, delay: 0.0,
            options: [.allowUserInteraction], animations: { [weak self] in
            self?.state = state
            self?.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            if state == .closed {
                self?.dismiss(animated: false, completion: nil)
            }
        })
    }
}

// MARK: - Bottom sheet position
private extension BaseBottomSheetViewController {
    func updateBottomSheetPosition() {
        let bottomOffset: CGFloat = view.safeAreaInsets.bottom

        updateContentSize()
        
        let y = state == .expanded
            ? view.frame.height - contentSize.height - bottomOffset + panTranslation
            : view.frame.height
        let origin = CGPoint(x: 0, y: y)
        bottomSheetView.frame = CGRect(origin: origin, size: contentSize)
    }
    
    func updateContentSize() {
        guard let contentView = bottomSheetView.subviews.first else { return }
        contentSize = contentView.systemLayoutSizeFitting(view.bounds.size,
            withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    }
}

// MARK: - BottomSheetContentViewDelegate conformance
extension BaseBottomSheetViewController: BottomSheetContentViewDelegate {
    func contentViewDidFinishInteraction() {
        closeBottomSheet()
    }
}

// MARK: - UIGestureRecognizerDelegate conformance
extension BaseBottomSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view, touchView.isKind(of: RangeSlider.self) {
            return false
        }
        return true
    }
}
