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
        static let iconWidthAndHeight: CGFloat = 50
        static let defaultTop: CGFloat = 8.0
        static let marginHeight: CGFloat = 10.0
        static let defaultBottom: CGFloat = -8.0
        static let defaultIconName = "bar_me_gray"
        static let nameHeight: CGFloat = 20.0
        static let timeTop: CGFloat = 20
        static let titleTop: CGFloat = 23
    }

    lazy var icon = UIImageView()
    lazy var name = UILabel()
    lazy var time = UILabel()
    lazy var title = UILabel()
    
    var contentModel: DataModel! {
        didSet {
            self.name.text = self.contentModel.author?.loginname
            self.title.text = self.contentModel.title
            self.time.text = CommonFunctions.formatTime(self.contentModel.create_at ?? "")
            if let avatar = self.contentModel.author?.avatarUrl {
                LoadAndCacheImages.shard.obtainImage(avatar) { data, _ in
                    if let dataTemp = data {
                        self.icon.image = UIImage(data: dataTemp)
                    }
                }
            }
            
//            print("^^^^^^^^^^^^^^^^^^^^")
//            
//            print("")
            
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
        self.contentView.addSubview(time)
        self.contentView.addSubview(title)
        
        self.icon.image = UIImage(named: Constants.defaultIconName)
        
        CommonFunctions.setCornerForView(view: icon, wid: 1, radius: Constants.iconWidthAndHeight * 0.5, borderColor: .clear)
        icon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.width.equalTo(Constants.iconWidthAndHeight)
            maker.height.equalTo(Constants.iconWidthAndHeight)
        }
        
        name.snp.makeConstraints { maker in
            maker.top.equalTo(icon.snp_topMargin).offset(Constants.defaultBottom)
            maker.left.equalTo(icon.snp_rightMargin).offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.height.equalTo(Constants.nameHeight)
        }
        
        time.snp.makeConstraints { maker in
            maker.top.equalTo(name.snp_bottomMargin).offset(Constants.timeTop)
            maker.left.equalTo(icon.snp_rightMargin).offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.bottom.equalTo(icon.snp_bottomMargin)
        }
        
        title.snp.makeConstraints { maker in
            maker.top.equalTo(icon.snp_bottomMargin).offset(Constants.titleTop)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.bottom.equalToSuperview().offset(Constants.defaultTrailing)
        }
        
        name.font = UIFont.boldSystemFont(ofSize: 18)
        name.textColor = MainColor
        time.font = UIFont.systemFont(ofSize: 13)
        time.textColor = .gray
        
        title.font = UIFont.systemFont(ofSize: 15)
        title.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
