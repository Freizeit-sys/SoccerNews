//
//  PreviewImageController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/19.
//

import UIKit

protocol PreviewImageViewDelegate: class {
    func didClose(_ animated: Bool)
}

class PreviewImageView: UIView {
    
    weak var delegate: PreviewImageViewDelegate?
    
    var previewImage: UIImage? {
        didSet {
            guard let previewImage = self.previewImage else { return }
            imageView.image = previewImage
        }
    }
    
    private var originalFrame: CGRect!
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let rotationAngle: CGFloat = CGFloat(270 * Double.pi / 180)
        button.transform = CGAffineTransform(rotationAngle: rotationAngle)
        return button
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.cancelsTouchesInView = false
        return pan
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(overlayView)
        addSubview(closeButton)
        addSubview(imageView)
        
        overlayView.fillSuperView()
        
        closeButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let height: CGFloat = 300
        let y: CGFloat = (screenHeight / 2) - (height / 2)
        imageView.frame = CGRect(x: 0, y: y, width: screenWidth, height: height)
        
        panGesture.addTarget(self, action: #selector(handlePanGesture))
        imageView.addGestureRecognizer(panGesture)
        
        originalFrame = imageView.frame
    }
    
    @objc private func handleClose() {
        delegate?.didClose(true)
    }
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        
        switch recognizer.state {
        case .began:
            // hide close button
            UIView.animate(withDuration: 0.2, animations: {
                self.closeButton.alpha = 0.0
            }, completion: nil)
        case .changed:
            // Top limit
            if translation.y < 0 {
                return
            }
            let y: CGFloat = originalFrame.minY + translation.y
            imageView.frame = CGRect(x: 0, y: y, width: originalFrame.width, height: originalFrame.height)
            
            let value: CGFloat = frame.height - imageView.frame.minY
            let total: CGFloat = frame.height - originalFrame.minY
            let alpha = value / total
            updateOverlayViewAlpha(alpha)
        case .ended:
            if translation.y < 150 {
                // reset imageview position and overlayview with closebutton alpha
                resetViews()
            } else {
                // close preview image
                close()
            }
        default:
            ()
        }
    }
    
    private func updateOverlayViewAlpha(_ alpha: CGFloat) {
        overlayView.alpha = alpha
    }
    
    private func resetViews() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.frame = self.originalFrame
            self.overlayView.alpha = 1.0
            self.closeButton.alpha = 1.0
        }, completion: nil)
    }
    
    private func close() {
        UIView.animate(withDuration: 0.1) {
            self.imageView.frame = CGRect(x: 0, y: self.frame.height, width: self.originalFrame.width, height: self.originalFrame.height)
            self.overlayView.alpha = 0.0
        } completion: { (finished) in
            self.delegate?.didClose(false)
        }

    }
}

class PreviewImageController: UIViewController {
    
    var previewImage: UIImage?
    
    private let v = PreviewImageView()
    
    override func loadView() {
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.v.previewImage = self.previewImage
        self.v.delegate = self
        
        self.setupNavigationItems()
    }
}

extension PreviewImageController {
    
    private func setupNavigationItems() {
        self.setupRemainingNavItem()
        self.setupLeftNavItem()
    }
    
    private func setupRemainingNavItem() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupLeftNavItem() {
        let closeButton = UIButton(type: .system)
        closeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        closeButton.tintColor = .white
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(image, for: .normal)
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}

extension PreviewImageController: PreviewImageViewDelegate {
    
    func didClose(_ animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
