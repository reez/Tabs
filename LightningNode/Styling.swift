//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

/// UIView

let autolayoutStyle: (UIView) -> Void = {
    $0.translatesAutoresizingMaskIntoConstraints = false
}

let mediumLayoutMarginsStyle: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(8), left: .mr_grid(8), bottom: .mr_grid(8), right: .mr_grid(8))
}

let baseLayoutMarginsStyle: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(6), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
}

let topLayoutMarginsStyle: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(12), left: .mr_grid(6), bottom: .mr_grid(6), right: .mr_grid(6))
}

let leftLayoutMarginsStyle: (UIView) -> Void = {
    $0.layoutMargins = UIEdgeInsets(top: .mr_grid(6), left: .mr_grid(12), bottom: .mr_grid(0), right: .mr_grid(12))
}


/// UIStackView

let rootStackViewStyle: (UIStackView) -> Void =
    autolayoutStyle
        <> {
            $0.isLayoutMarginsRelativeArrangement = true
            $0.spacing = .mr_grid(6)
}

let verticalStackViewStyle: (UIStackView) -> Void =
    rootStackViewStyle
        <> {
            $0.axis = .vertical
}

let horizontalStackViewStyle: (UIStackView) -> Void =
    rootStackViewStyle
        <> {
            $0.axis = .horizontal
}

let centerStackViewStyle: (UIStackView) -> Void = {
    $0.alignment = .center
}


/// UILabel

let centerTextStyle: (UILabel) -> Void = {
    $0.textAlignment = .center
}

let smallCapsTextStyle: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
}

let subheadlineTextStyle: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
}

let title1BoldTextStyle: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1).bolded
}

let title3TextStyle: (UILabel) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
}

let baseTextStyle: (UILabel) -> Void = {
    $0.numberOfLines = 0
}

let infoTextStyle: (UILabel) -> Void = {
    $0.textColor = .mr_black
    $0.font = UIFont.preferredFont(forTextStyle: .caption1).smallCaps
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.numberOfLines = 0
}

let finePrintStyle: (UILabel) -> Void =
    centerTextStyle
        <> baseTextStyle
        <> { $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)}


/// UITextField

let baseTextFieldStyle: (UITextField) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: .subheadline)
    $0.borderStyle = .roundedRect
}

let bodyBoldTextFieldStyle: (UITextField) -> Void = {
    $0.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).bolded
}


/// UIButton

let baseButtonStyle: (UIButton) -> Void = {
    $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

let unfilledButtonStyle =
    baseButtonStyle
        <> {
            $0.backgroundColor = .white
            $0.tintColor = .white
            $0.setTitleColor(.mr_blue, for: .normal)
}


/// M13Checkbox

let checkboxStyle: (M13Checkbox) -> Void = {
    $0.animationDuration = 0.50
    $0.setCheckState(.unchecked, animated: true)
    $0.tintColor = .mr_green
    $0.secondaryTintColor = .mr_lightGray
    $0.checkmarkLineWidth = 6.0
    $0.boxLineWidth = 3.0
    $0.boxType = .circle
}


/// Extensions

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
    public static let mr_gray = UIColor(white: 0.5, alpha: 1.0)
    public static let mr_lightGray = UIColor(white: 0.95, alpha: 1.0)
    public static let mr_green = UIColor(red: 121/255, green: 242/255, blue: 176/255, alpha: 1)
    public static let mr_purple = UIColor(red: 151/255, green: 77/255, blue: 255/255, alpha: 1)
    public static let mr_red = UIColor(red: 255/255, green: 100/255, blue: 87/255, alpha: 1)
    public static let mr_yellow = UIColor(red: 255/255, green: 240/255, blue: 128/255, alpha: 1)
    public static let mr_gold = UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1)
}

extension CGFloat {
    static func mr_grid(_ n: Int) -> CGFloat {
        return CGFloat(n) * 4
    }
}


/// Date Formatters

public var mrDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMM d, yyyy h:mm:ss a"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter
}
