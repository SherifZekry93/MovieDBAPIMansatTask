//
//  ActorCell.swift
//  MovieDBAPITask
//
//  Created by Sherif  Wagih on 4/2/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import SDWebImage
class ActorCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let actorImage:UIImageView = {
        let image = UIImageView()
        image.sd_setShowActivityIndicatorView(true)
        image.sd_setIndicatorStyle(.gray)
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews()
    {
        addSubview(containerView)
        containerView.anchorToView(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10),size: .init(width: 0, height: 300))
        containerView.addSubview(actorImage)
        actorImage.anchorToView(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 250))
        backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    func configureCell(actor:Actor)
    {
        
        let imageURL = URL(string: "\(BASE_IMAGE_URL)\(actor.profile_path)")
        actorImage.sd_setImage(with: imageURL, completed: nil)
    }
}
