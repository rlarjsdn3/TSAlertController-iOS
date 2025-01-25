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

final class FadeAndScaldeDownAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
    ///
    private var duration: TimeInterval

    ///
    private var presenting: Bool
    
    ///
    init(duration: TimeInterval, presenting: Bool) {
        self.duration = duration
        self.presenting = presenting
    }
    
    ///
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return duration
    }
    
    ///
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let containerView = transitionContext.containerView as UIView?,
              let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
                
        //
        if presenting {
            containerView.addSubview(toVC.view)
            toVC.view.applyCenterXYConstraint(in: containerView) //

            //
            toVC.view.alpha = 0
            toVC.view.transform = CGAffineTransformMakeScale(1.1, 1.1)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseIn,
                       animations: {
            //
            if self.presenting {
                toVC.view.alpha = 1
                toVC.view.transform = .identity
            //
            } else {
                fromVC.view.alpha = 0
            }
        }, completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            
            //
            if (success && !self.presenting) {
                fromVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        })
    }
}
