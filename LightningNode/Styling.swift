//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import UIKit

func baseButtonStyle(_ button: UIButton) {
    button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

let baseButtonReuseStyle: (UIButton) -> Void = {
    $0.backgroundColor = .white
    $0.layer.borderColor = UIColor.white.cgColor
    $0.setTitle("", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.removeTarget(nil, action: nil, for: .allEvents)
}

let baseCellStyle: (UICollectionViewCell) -> Void = {
    $0.layer.shadowColor = UIColor.mr_black.cgColor 
    $0.layer.masksToBounds = false
    $0.layer.shadowOpacity = 0.3
    $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    $0.layer.shadowRadius = $0.contentView.layer.cornerRadius
}

let roundedStyle: (UIView) -> Void = {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
}

func borderStyle(color: UIColor, width: CGFloat) -> (UIView) -> Void {
    return {
        $0.layer.borderColor = color.cgColor
        $0.layer.borderWidth = width
    }
}

func backgroundStyle(color: UIColor) -> (UIView) -> Void {
    return {
        $0.backgroundColor = color
    }
}

let roundedButtonStyle =
    baseButtonStyle
        <> roundedStyle

let filledButtonStyle =
    roundedButtonStyle
        <> {
            $0.backgroundColor = .mr_black
            $0.tintColor = .white
            $0.setTitleColor(.white, for: .normal)
}

let borderButtonStyle  =
    roundedButtonStyle
        <> borderStyle(color: .mr_blue, width: 2)

let invoiceButtonStyle =
    filledButtonStyle
        <> { $0.backgroundColor = .mr_purple }

func fontStyle(ofSize size: CGFloat, weight: UIFont.Weight) -> (UILabel) -> Void {
    return {
        $0.font = .systemFont(ofSize: size, weight: weight)
    }
}

func fontStyle(_ myFont: UIFont) -> (UILabel) -> Void {
    return {
        $0.font = myFont
    }
}

func fontStyle(_ myFont: UIFont) -> (UITextField) -> Void {
    return {
        $0.font = myFont
    }
}

func textColorStyle(_ color: UIColor) -> (UILabel) -> Void {
    return {
        $0.textColor = color
    }
}

let baseLabelStyleSmallCaption: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .caption1).smallCaps)

let baseLabelStyleSmallSubheadline: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .subheadline).smallCaps)

let baseLabelStyleBoldCaption: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .caption1).bolded)

let baseLabelStyleBoldTitle: (UILabel) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .title1).bolded)

let baseTextFieldStyleBoldBody: (UITextField) -> Void =
    fontStyle(UIFont.preferredFont(forTextStyle: .body).bolded)

extension UIFont {
    public var smallCaps: UIFont {
        let upperCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kUpperCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kUpperCaseSmallCapsSelector
        ]
        let lowerCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kLowerCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kLowerCaseSmallCapsSelector
        ]
        let features = [upperCaseFeature, lowerCaseFeature]
        let smallCapsDescriptor = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings : features])
        return UIFont(descriptor: smallCapsDescriptor, size: 0)
    }
    
    public var largeCaps: UIFont {
        let upperCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kUpperCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier :  kUpperAndLowerCaseSelector// kDefaultUpperCaseSelector, kUpperCasePetiteCapsSelector, kUpperCaseSmallCapsSelector
        ]
        let lowerCaseFeature = [
            UIFontDescriptor.FeatureKey.featureIdentifier : kLowerCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier : kLowerCaseSmallCapsSelector
        ]
        let features = [upperCaseFeature, lowerCaseFeature]
        let smallCapsDescriptor = self.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings : features])
        return UIFont(descriptor: smallCapsDescriptor, size: 0)
    }
    
    public var bolded: UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.traitBold) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
}

extension UIColor {
    public static let mr_black = UIColor(white: 0.07, alpha: 1)
    public static let mr_blue = UIColor(red: 0/255, green: 172/255, blue: 255/255, alpha: 1)
    public static let mr_gray = UIColor(white: 0.95, alpha: 1.0)
    public static let mr_green = UIColor(red: 121/255, green: 242/255, blue: 176/255, alpha: 1)
    public static let mr_purple = UIColor(red: 151/255, green: 77/255, blue: 255/255, alpha: 1)
    public static let mr_red = UIColor(red: 235/255, green: 28/255, blue: 38/255, alpha: 1)
    public static let mr_yellow = UIColor(red: 255/255, green: 240/255, blue: 128/255, alpha: 1)
    public static let mr_gold = UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1)
}

class ScrollTriggeredControl: UIControl {
    private let dragThreshold: CGFloat = 80
    
    private var previousFraction: CGFloat = 0
    private var shouldTrigger = false
    private var offsetObservation: NSKeyValueObservation?
    
    private let imageView = UIImageView()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    private lazy var widthConstraint: NSLayoutConstraint = widthAnchor.constraint(equalToConstant: 0)
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = false
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        let centerConstraint = imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        centerConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            centerConstraint, widthConstraint
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        (superview as? UIScrollView).flatMap(observe)
    }
    
    private func observe(scrollView: UIScrollView) {
        offsetObservation = scrollView.observe(\.contentOffset) { [weak self] scrollView, _ in
            self?.updateOffset(for: scrollView)
        }
    }
    
    private func updateOffset(for scrollView: UIScrollView) {
        let offset = -scrollView.adjustedContentOffset.x
        let fraction = min(offset / dragThreshold, 1)
        widthConstraint.constant = max(offset, 0)
        imageView.alpha = fraction == 1 ? 1 : 0.5 * fraction
        
        if shouldTrigger, !scrollView.isTracking {
            sendActions(for: .primaryActionTriggered)
            shouldTrigger = false
        }
        
        if fraction < 1 {
            impactGenerator.prepare()
            shouldTrigger = false
        }
        
        if fraction == 1, previousFraction < 1, scrollView.isTracking {
            impactGenerator.impactOccurred()
            shouldTrigger = true
        }
        
        previousFraction = fraction
    }
}

extension UIScrollView {
    var adjustedContentOffset: CGPoint {
        var offset = contentOffset
        offset.x += adjustedContentInset.left
        offset.y += adjustedContentInset.top
        return offset
    }
}

extension CGFloat {
    static func mr_grid(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}

public var refreshedDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMM d, yyyy HH:mm:ss"
    formatter.timeZone = .current
    return formatter
}

public var monthDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMM d, yyyy"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}
