
// Copyright (c) 2025 rlarjsdn3 <rlarjsdn3@naver.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

public class TSButton: UIButton {
    
    // MARK: - Properties
    
    ///
    let container = UIView()

    ///
    private let stackView = UIStackView()
    
    ///
    public override var imageView: UIImageView {
        get { _imageView }
        set { }
    }
    
    private let _imageView = UIImageView()
    
    
    ///
    public override var titleLabel: UILabel {
        get { _titleLabel }
        set { }
    }
    
    private let _titleLabel = UILabel()

    ///
    private let accessoryImageView = UIImageView()
    
    ///
    var config: TSButton.Configuration?
    
    ///
    var highlightType: TSButton.HighlightType = .tintAndScaleDown()
    
    ///
    public override var isHighlighted: Bool {
        didSet { updateHighlightState() }
    }
    
    ///
    public override var isEnabled: Bool {
        didSet { updateButtonEnabledState() }
    }
    
    
    // MARK: - Intializer
    
    ///
    init(config: TSButton.Configuration) {
        self.config = config
        super.init(frame: .zero)
        
        self.backgroundColor = config.backgroundColor
        self.layer.cornerRadius = config.cornerRadius
        
        addSubview(container)
        container.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         trailing: self.trailingAnchor,
                         bottom: self.bottomAnchor,
                         topInset: config.contentEdgeInset.top,
                         leadingInset: config.contentEdgeInset.leading,
                         trailingInset: config.contentEdgeInset.trailing,
                         bottomInset: config.contentEdgeInset.bottom)
        container.isUserInteractionEnabled = false
        
        if let accessoryImage = config.accessoryImage {
            accessoryImageView.image = accessoryImage.applyingSymbolConfiguration(config.preferredSymbolConfigurationForAccessoryImage ?? .unspecified)
            accessoryImageView.contentMode = .scaleAspectFit
            
            container.addSubview(accessoryImageView)
            accessoryImageView.centerY(in: container)
            accessoryImageView.anchor(trailing: container.trailingAnchor, trailingInset: 0)
        }
        
        container.addSubview(stackView)
        stackView.centerY(in: container)
        stackView.spacing = config.imageSpacing
        switch config.contentAlignment {
        case .left: stackView.anchor(leading: container.leadingAnchor, leadingInset: 0)
        case .center: stackView.centerX(in: container)
        case .right: stackView.anchor(trailing: config.accessoryImage != nil
                                      ? accessoryImageView.leadingAnchor
                                      : container.trailingAnchor,
                                      trailingInset: config.accessoryImage != nil
                                      ? config.accessoryImageSpacing
                                      : 0)
        }
        
        if let title = config.title {
            let attrText = NSAttributedString(string: title,
                                              attributes: config.titleAttributes ?? [:])
            titleLabel.attributedText = attrText
            titleLabel.textAlignment = config.titleAlignment
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let image = config.image {
            imageView.image = image.applyingSymbolConfiguration(config.preferredSymbolConfigurationForImage ?? .unspecified)
            imageView.contentMode = .scaleAspectFit
            stackView.insertArrangedSubview(imageView, at: 0)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    
    private func updateHighlightState() {
        UIView.animate(withDuration: 0.15) {
            self.isHighlighted ? self.highlightType.apply(to: self) : self.highlightType.undo(for: self)
        }
    }
    
    private func updateButtonEnabledState() {
        self.alpha = self.isEnabled ? 1 : 0.25
    }
}


// MARK: - Extension

extension TSButton {
    
    private struct AssociatedKeys {
        static var previousBackgroundColor = "previousBackgroundColor"
    }
    
    ///
    var previousBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.previousBackgroundColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.previousBackgroundColor,
                                     newValue,
                                     .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
