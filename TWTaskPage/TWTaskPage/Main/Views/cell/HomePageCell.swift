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
        static let nameHeight: CGFloat = 20.0
        static let timeTop: CGFloat = 20
        static let titleTop: CGFloat = 23
        static let imagesHeight: CGFloat = 39
        static let imageHeight: CGFloat = 23
        static let lineHeight: CGFloat = 1
        static let bottomHeight: CGFloat = 8
        static let eightMargin: CGFloat = 8
        static let sisteenMargin: CGFloat = 16
        static let imageOffset: CGFloat = Constants.imageHeight * 0.5 + 5
        static let imageSpace: CGFloat = 5
        static let imageColor = UIColor.init(51, 51, 51)
        static let visitorImageName = "visitor"
        static let replyImageName = "reply"
        static let defaultIconName = "bar_me_gray"
    }

    private lazy var icon = UIImageView()
    private lazy var name = UILabel()
    private lazy var time = UILabel()
    private lazy var title = UILabel()
    
    private lazy var lineView = UIView()
    private lazy var replyView = UIView()
    private lazy var replyImage = UIImageView()
    private lazy var replyLabel = UILabel()
    private lazy var visitorView = UIView()
    private lazy var visitorImage = UIImageView()
    private lazy var visitorLabel = UILabel()
    private lazy var bottomView = UIView()
    
    var contentModel: DataModel! {
        didSet {
            self.name.text = self.contentModel.author?.loginname
            self.title.text = self.contentModel.title
            self.time.text = CommonFunctions.formatTime(self.contentModel.createTime ?? "")
            if let avatar = self.contentModel.author?.avatarUrl {
                LoadAndCacheImages.shard.obtainImage(avatar) { data, _ in
                    if let dataTemp = data {
                        self.icon.image = UIImage(data: dataTemp)
                    }
                }
            }
            if let replyCount = self.contentModel.replyCount {
                self.replyLabel.text = "\(replyCount)"
            }
            
            if let visitCount = self.contentModel.visitCount {
                self.visitorLabel.text = "\(visitCount)"
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
        contentView.addSubview(icon)
        contentView.addSubview(name)
        contentView.addSubview(time)
        contentView.addSubview(title)
        contentView.addSubview(lineView)
        contentView.addSubview(replyView)
        replyView.addSubview(replyImage)
        replyView.addSubview(replyLabel)
        contentView.addSubview(visitorView)
        visitorView.addSubview(visitorImage)
        visitorView.addSubview(visitorLabel)
        contentView.addSubview(bottomView)
        
        self.icon.image = UIImage(named: Constants.defaultIconName)
        
        CommonFunctions.setCornerForView(view: icon, wid: 1, radius: Constants.iconWidthAndHeight * 0.5, borderColor: .clear)
        icon.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.width.height.equalTo(Constants.iconWidthAndHeight)
        }
        
        name.snp.makeConstraints { maker in
            maker.top.equalTo(icon.snp.top)
            maker.left.equalTo(icon.snp.right).offset(Constants.eightMargin)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.height.equalTo(Constants.nameHeight)
        }
        
        time.snp.makeConstraints { maker in
            maker.top.equalTo(name.snp.bottom).offset(Constants.eightMargin)
            maker.left.equalTo(icon.snp.right).offset(Constants.eightMargin)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.bottom.equalTo(icon.snp.bottom)
        }
        
        title.snp.makeConstraints { maker in
            maker.top.equalTo(icon.snp.bottom).offset(Constants.sisteenMargin)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
        }
        
        lineView.backgroundColor = .systemGroupedBackground
        lineView.snp.makeConstraints { maker in
            maker.top.equalTo(title.snp.bottom).offset(Constants.sisteenMargin)
            maker.left.equalToSuperview().offset(Constants.defaultLeading)
            maker.right.equalToSuperview().offset(Constants.defaultTrailing)
            maker.height.equalTo(Constants.lineHeight)
        }
        
        replyView.snp.makeConstraints { maker in
            maker.top.equalTo(lineView.snp.bottom)
            maker.left.equalToSuperview()
            maker.width.equalTo(SCREEN_WIDTH * 0.5)
            maker.height.equalTo(Constants.imagesHeight)
        }
        
        replyImage.image = UIImage(named: Constants.replyImageName)
        replyImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.centerX.equalToSuperview().offset(-Constants.imageOffset)
            maker.width.height.equalTo(Constants.imageHeight)
        }
        
        replyLabel.textColor = Constants.imageColor
        replyLabel.font = UIFont.systemFont(ofSize: 14)
        replyLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.left.equalTo(replyImage.snp.right).offset(Constants.imageSpace)
            maker.height.equalTo(Constants.imageHeight)
        }
        
        visitorView.snp.makeConstraints { maker in
            maker.top.equalTo(replyView.snp.top)
            maker.left.equalTo(replyView.snp_rightMargin)
            maker.width.equalTo(SCREEN_WIDTH * 0.5)
            maker.height.equalTo(Constants.imagesHeight)
        }
        
        
        visitorImage.image = UIImage(named: Constants.visitorImageName)
        visitorImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.centerX.equalToSuperview().offset(-Constants.imageOffset)
            maker.width.height.equalTo(Constants.imageHeight)
        }
        
        visitorLabel.textColor = Constants.imageColor
        visitorLabel.font = UIFont.systemFont(ofSize: 14)
        visitorLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(Constants.defaultTop)
            maker.left.equalTo(visitorImage.snp.right).offset(Constants.imageSpace)
            maker.height.equalTo(Constants.imageHeight)
        }
        
        bottomView.backgroundColor = .systemGroupedBackground
        bottomView.snp.makeConstraints { maker in
            maker.top.equalTo(replyView.snp.bottom)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(Constants.bottomHeight)
            maker.bottom.equalToSuperview()
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
