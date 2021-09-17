//
//  HomePageCell.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/17.
//

import UIKit

class HomePageCell: UITableViewCell {
    private struct Constants {
        static let defaultLeading: CGFloat = 16.0
        static let defaultTrailing: CGFloat = -16.0
        static let iconWidthAndHeight: CGFloat = 60
        static let defaultTop: CGFloat = 8.0
        static let marginHeight: CGFloat = 10.0
        static let defaultBottom: CGFloat = -8.0
        static let defaultIconName = "bar_me_gray"
    }

    lazy var icon = UIImageView()
    lazy var name = UILabel()
    lazy var title = UILabel()
    
    var contentModel: DataModel! {
        didSet {
            self.name.text = self.contentModel.author?.loginname
            self.title.text = self.contentModel.title
            if let avatar = self.contentModel.author?.avatarUrl {
                LoadAndCacheImages.shard.obtainImage(avatar) { data, _ in
                    if let dataTemp = data {
                        self.icon.image = UIImage(data: dataTemp)
                    }
                }
            }
        }
    }
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupUI() {
        self.contentView.addSubview(icon)
        self.contentView.addSubview(name)
        self.contentView.addSubview(title)
        
        self.icon.image = UIImage(named: Constants.defaultIconName)
        icon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.width.equalTo(Constants.iconWidthAndHeight)
            maker.height.equalTo(Constants.iconWidthAndHeight)
        }
        
        
        name.snp.makeConstraints { maker in
            maker.top.equalTo(icon.snp_topMargin)
            maker.left.equalTo(icon.snp_rightMargin).offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
        }
        
        title.snp.makeConstraints { maker in
            maker.top.equalTo(name.snp_bottomMargin).offset(Constants.marginHeight)
            maker.left.equalTo(icon.snp_rightMargin).offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.bottom.equalToSuperview().offset(Constants.defaultTrailing)
        }
        
        name.font = UIFont.systemFont(ofSize: 16)
        name.numberOfLines = 1
        title.font = UIFont.systemFont(ofSize: 16)
        title.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
