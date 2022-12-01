//
//  FLTView.swift
//  flutter_unionad
//
//  感谢nullptrx，本类是来自https://github.com/nullptrx/pangle_flutter
//

import Foundation

class ADContainerView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha < 0.01 {
            // interaction disable
            // hidden
            // nearly invisble
            return nil
        }
        let windowPoint = self.convert(point, to: UIApplication.shared.delegate?.window!!)

        let targetView = self.superview?.superview
        let targetOverlayView = self.findTargetOverlayView(windowPoint)

        if self.isOverlay(targetView, targetOverlayView) {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }

    }

    func findTargetOverlayView(_ point: CGPoint) -> UIView? {

        guard let flutterView: UIView =  self.superview?.superview?.superview else {
            return nil
        }

        if String(describing: flutterView.classForCoder) == "FlutterView" {
            for v in flutterView.subviews {
                let contains = v.frame.contains(point)
                if String(describing: v.classForCoder) == "FlutterOverlayView" && contains {
                    return v
                }
            }
        }
        return nil
    }

    func isOverlay(_ view: UIView?, _ overlayView: UIView?) -> Bool {
        guard let v1 = view else {
            return false
        }
        guard let v2 = overlayView else {
            return false
        }

        if v1.frame.contains(v2.frame) || v2.frame.contains(v1.frame) {
            return true
        }
        if v1.frame.intersects(v2.frame) || v2.frame.intersects(v1.frame) {
            return true
        }

        return false
    }
}
