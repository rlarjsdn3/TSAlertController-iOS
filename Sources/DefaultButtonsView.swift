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

class DefaultButtonsView: UIStackView {
   
    
    // MARK: - Intializer
    
    init(_ buttons: [TSButton],
         _ configuration: TSAlertController.Configuration) {
        super.init(frame: .zero)
        
        for button in buttons {
            addArrangedSubview(button)
        }
        
        configure(buttons, with: configuration)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    
    private func configure(_ buttons: [TSButton], with configuration: TSAlertController.Configuration) {
        self.axis = resolve(configuration.buttonLayoutAxis)
        self.spacing = configuration.spacing.buttonSpacing
        self.alignment = .fill
        self.distribution = .fillEqually
    }
    
}

// MARK: - Extnension

private extension DefaultButtonsView {
    
    func resolve(_ axis: TSAlertController.Configuration.ButtonLayoutAxis) -> NSLayoutConstraint.Axis {
        if case .vertical = axis {
            return .vertical
        }
        return .horizontal
    }
}
