//
//  BaseTableViewCell.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/3/10.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    func addRippleEffect(to referenceView: UIView) {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
        
        let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
        let rippleShape = CAShapeLayer()
        rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
        rippleShape.path = path.cgPath
        rippleShape.fillColor = UIColor.yellow.cgColor
        rippleShape.strokeColor = UIColor.yellow.cgColor
        rippleShape.lineWidth = 4
        rippleShape.position = shapePosition
        rippleShape.opacity = 0
        
        referenceView.layer.addSublayer(rippleShape)
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        //scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1, 1, 1))
        
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = nil
        
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        //animation.animations = [opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = CFTimeInterval(0.7)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        
        rippleShape.add(animation, forKey: "rippleEffect")

    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //addRippleEffect(to: self)
        
        
        let scaleFactor : CGFloat = 1.0
        let animationColor : UIColor = UISetting.shared.buttonColor
        let animationDuration : Double = 0.5
        
        
        let coverView = UIView(frame: self.bounds)
       
        coverView.layer.cornerRadius = 10
        //coverView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        coverView.clipsToBounds = true
        coverView.backgroundColor = UIColor.clear
        self.contentView.addSubview(coverView)

        let touch = touches.first!
        let point = touch.location(in: self)

        let ourTouchView = UIView(frame: CGRect(x: point.x - 5, y: point.y - 5, width: 10, height: 10))
        //print(ourTouchView)
        //print(point)


        let circleMaskPathInitial = UIBezierPath(ovalIn: ourTouchView.frame)
        let radius = max((self.bounds.width * scaleFactor) , (self.bounds.height * scaleFactor))
        let circleMaskPathFinal = UIBezierPath(ovalIn: ourTouchView.frame.insetBy(dx: -radius, dy: -radius))
        
        
        let rippleLayer = CAShapeLayer()
        rippleLayer.opacity = 0.4
        rippleLayer.fillColor = animationColor.cgColor
        //rippleLayer.path = circleMaskPathFinal.cgPath
        
        rippleLayer.path = UIBezierPath(rect: self.bounds).cgPath
        //rippleLayer.masksToBounds = true
        coverView.layer.addSublayer(rippleLayer)

        //fade up
        let fadeUp = CABasicAnimation(keyPath: "opacity")
        fadeUp.beginTime = CACurrentMediaTime()
        fadeUp.duration = animationDuration * 0.6
        fadeUp.toValue = 0.6
        fadeUp.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeUp.fillMode = CAMediaTimingFillMode.forwards
        fadeUp.isRemovedOnCompletion = false
        rippleLayer.add(fadeUp, forKey: nil)

        //fade down
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.beginTime = CACurrentMediaTime() + animationDuration * 0.60
        fade.duration = animationDuration * 0.40
        fade.toValue = 0
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fade.fillMode = CAMediaTimingFillMode.forwards
        fade.isRemovedOnCompletion = false
        rippleLayer.add(fade, forKey: nil)

        //change path
        CATransaction.begin()
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.beginTime = CACurrentMediaTime()
        maskLayerAnimation.duration = animationDuration
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        CATransaction.setCompletionBlock({
            
            coverView.removeFromSuperview()
            
        })
        rippleLayer.add(maskLayerAnimation, forKey: "path")
        CATransaction.commit()
        
        
        //super.touchesBegan(touches, with: event)
        
    }
    */
}
