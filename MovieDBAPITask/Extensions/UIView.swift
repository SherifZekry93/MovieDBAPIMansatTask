//
//  UIStoryBoard.swift
//  WorkForceApplication
//
//  Created by Sherif  Wagih on 12/19/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
extension UIView
{
    func anchorToView(top : NSLayoutYAxisAnchor? = nil ,leading : NSLayoutXAxisAnchor? = nil,bottom : NSLayoutYAxisAnchor? = nil,trailing : NSLayoutXAxisAnchor? = nil,padding:UIEdgeInsets = .zero,size:CGSize = .zero,centerH:Bool? = false, centerV:Bool? = false)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top
        {
            topAnchor.constraint(equalTo: top,constant:padding.top).isActive = true
        }
        if let bottom = bottom
        {
            bottomAnchor.constraint(equalTo: bottom,constant:-padding.bottom).isActive = true
        }
        if let right = trailing
        {
            trailingAnchor.constraint(equalTo: right,constant:-padding.right).isActive = true
        }
        if let left = leading
        {
            leadingAnchor.constraint(equalTo: left,constant:padding.left).isActive = true
        }
        if size.width != 0
        {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0
        {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if centerH == true
        {
            centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!).isActive = true
        }
        if centerV == true
        {
            centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!).isActive = true
        }
    }
    func fillSuperView()
    {
        self.anchorToView(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
}
