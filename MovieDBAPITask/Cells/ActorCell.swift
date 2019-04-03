//
//  ActorCell.swift
//  MovieDBAPITask
//
//  Created by Sherif  Wagih on 4/2/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import UIKit
import Kingfisher
class ActorCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
        backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let actorImage:UIImageView = {
        var image = UIImageView()
        image.kf.indicatorType = .activity
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        //label.text = "Sherif"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 29)
        return label
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
        containerView.addSubview(nameLabel)
        nameLabel.anchorToView(top: actorImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,size:.init(width: 0, height: 50))
    }
    func configureCell(actor:Actor)
    {
        let imageURL = URL(string: "\(BASE_IMAGE_URL)\(actor.profile_path ?? "")")
        actorImage.kf.setImage(
            with: imageURL,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        nameLabel.text = actor.name
    }
}
