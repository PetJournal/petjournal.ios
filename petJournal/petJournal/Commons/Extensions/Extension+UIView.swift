//
//  Extension+UIView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 12/04/23.
//

import UIKit

extension UIView {
    
    static func fromXib() -> Self {
        let bundle = Bundle(for: Self.self)
        let views = UINib(nibName: String(describing: Self.self), bundle: bundle)
            .instantiate(withOwner: nil, options: nil) as! [UIView]
        return views.first as! Self
    }
    
    func fillSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = superview?.topAnchor {
            topAnchor.constraint(equalTo: top, constant: UIEdgeInsets.zero.top).isActive = true
        }
        if let left = superview?.leftAnchor {
            leftAnchor.constraint(equalTo: left, constant: UIEdgeInsets.zero.left).isActive = true
        }
        if let right = superview?.rightAnchor {
            rightAnchor.constraint(equalTo: right, constant: -UIEdgeInsets.zero.right).isActive = true
        }
        if let bottom = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: bottom, constant: -UIEdgeInsets.zero.bottom).isActive = true
        }
        if CGSize.zero.width != 0 {
            widthAnchor.constraint(equalToConstant: CGSize.zero.width).isActive = true
        }
        if CGSize.zero.height != 0 {
            heightAnchor.constraint(equalToConstant: CGSize.zero.height).isActive = true
        }
    }
}
