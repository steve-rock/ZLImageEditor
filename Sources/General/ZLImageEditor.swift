//
//  ZLImageEditor.swift
//  ZLImageEditor
//
//  Created by long on 2020/9/8.
//
//  Copyright (c) 2020 Long Zhang <495181165@qq.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import UIKit

let version = "2.0.1"

public struct ZLImageEditorWrapper<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ZLImageEditorCompatible: AnyObject { }

public protocol ZLImageEditorCompatibleValue { }

extension ZLImageEditorCompatible {
    public var zl: ZLImageEditorWrapper<Self> {
        get { ZLImageEditorWrapper(self) }
        set { }
    }
    
    public static var zl: ZLImageEditorWrapper<Self>.Type {
        get { ZLImageEditorWrapper<Self>.self }
        set { }
    }
}

extension ZLImageEditorCompatibleValue {
    public var zl: ZLImageEditorWrapper<Self> {
        get { ZLImageEditorWrapper(self) }
        set { }
    }
}

extension UIImage: ZLImageEditorCompatible {
    func tintColor(_ color: UIColor) -> UIImage? {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        } else {
            return self
        }
    }
}
extension CIImage: ZLImageEditorCompatible { }
extension UIColor: ZLImageEditorCompatible {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF, blue: hex & 0xFF)
    }
}

extension UIView: ZLImageEditorCompatible { }
extension UIGraphicsImageRenderer: ZLImageEditorCompatible { }

extension String: ZLImageEditorCompatibleValue { }
extension CGFloat: ZLImageEditorCompatibleValue { }
