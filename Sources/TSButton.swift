
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
    private let leftImageView = UIImageView()
    
    ///
    private let rightImageView = UIImageView()
    
    ///
    public override var titleLabel: UILabel? {
        get { _titleLabel }
        set { }
    }
    
    private let _titleLabel = UILabel()
    
    ///
    var highlightType: TSButton.HighlightType = .dimAndScaleDown()
    
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
    init(leftImage: UIImage? = nil,
         title: String?,
         rightImage: UIImage? = nil,
         config: TSButton.Configuration) {
        super.init(frame: .zero)
        
        // NOTE: - Using a stack causes issues with correctly setting the button’s overall size,
        //         so constraints for each element were explicitly defined using a UIView.
        
        self.backgroundColor = config.backgroundColor
        self.layer.cornerRadius = config.cornerRadius
        titleLabel?.textAlignment = config.titleAlignment
        
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: config.contentEdgeInset.top),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: config.contentEdgeInset.leading),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -config.contentEdgeInset.bottom),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -config.contentEdgeInset.trailing),
        ])
        
        if let leftImage = leftImage {
            leftImageView.image = leftImage.applyingSymbolConfiguration(config.preferredSymbolConfigurationForLeftImage
                                                                        ?? UIImage.SymbolConfiguration.unspecified)
            
            container.addSubview(leftImageView)
            leftImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                leftImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
                leftImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                leftImageView.widthAnchor.constraint(equalTo: leftImageView.heightAnchor),
                leftImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: config.leftImageScale)
            ])
        }
        
        if let rightImage = rightImage {
            rightImageView.image = rightImage.applyingSymbolConfiguration(config.preferredSymbolConfigurationForRightImage
                                                                          ?? UIImage.SymbolConfiguration.unspecified)
            
            container.addSubview(rightImageView)
            rightImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                rightImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                rightImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -config.contentEdgeInset.trailing),
                rightImageView.widthAnchor.constraint(equalTo: rightImageView.heightAnchor),
                rightImageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: config.rightImageScale)
            ])
        }
        
        if let title = title {
            let attrText = NSAttributedString(string: title,
                                              attributes: config.titleAttributes ?? [:])
            setAttributedTitle(attrText, for: .normal)
            _titleLabel.textAlignment = config.titleAlignment
            
            container.addSubview(_titleLabel)
            _titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                _titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                _titleLabel.leadingAnchor.constraint(
                    equalTo: leftImage != nil ? leftImageView.trailingAnchor : container.leadingAnchor,
                    constant: leftImage != nil ? config.leftImageSpacing : 0
                ),
                _titleLabel.trailingAnchor.constraint(
                    equalTo: rightImage != nil ? rightImageView.leadingAnchor : container.trailingAnchor,
                    constant: rightImage != nil ? config.rightImageSpacing : -config.contentEdgeInset.trailing)
            ])
        }
        
        configure(with: config)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        _titleLabel.text = title
    }
    
    public override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) {
        _titleLabel.attributedText = title
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        leftImageView.image = image
    }
    
    
    // MARK: - Private
    
    private func configure(with style: TSButton.Configuration) {
        container.isUserInteractionEnabled = false
        
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.isUserInteractionEnabled = false
        
        rightImageView.contentMode = .scaleAspectFit
    }
    
    private func updateHighlightState() {
        UIView.animate(withDuration: 0.15) {
            self.isHighlighted ? self.highlightType.apply(to: self) : self.highlightType.undo(for: self)
        }
    }
    
    private func updateButtonEnabledState() {
        self.alpha = self.isEnabled ? 1 : 0.25
    }
}




