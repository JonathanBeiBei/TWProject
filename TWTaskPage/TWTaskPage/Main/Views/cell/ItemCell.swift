//
//  ItemCell.swift
//  TWTaskPage
//
//  Created by Beibei Zhu on 2021/9/16.
//

import UIKit

class ItemCell: UITableViewCell {
    private struct Constants {
        static let defaultLeading: CGFloat = 16.0
        static let defaultTrailing: CGFloat = -16.0
        static let defaultTop: CGFloat = 8.0
        static let marginHeight: CGFloat = 10.0
        static let defaultBottom: CGFloat = -8.0
    }

    var titleLab = UILabel()
    var contentLab = UILabel()

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
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(contentLab)
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        contentLab.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLab.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.defaultLeading),
            titleLab.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: Constants.defaultTrailing),
            titleLab.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.defaultTop),
            
            contentLab.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.defaultLeading),
            contentLab.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: Constants.defaultTrailing),
            contentLab.topAnchor.constraint(equalTo: self.titleLab.bottomAnchor, constant: Constants.marginHeight),
            contentLab.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: Constants.defaultBottom),
        ])
    
        titleLab.font = UIFont.systemFont(ofSize: 16)
        titleLab.numberOfLines = 0
        contentLab.font = UIFont.systemFont(ofSize: 16)
        contentLab.numberOfLines = 0
        titleLab.text = "test title"
        contentLab.text = "test content"
    }
//
//    func setupData(_ model: SentenceCellModel) {
//
//        titleLab.lineSpace(8, text: model.titleEN ?? "")
//        contentLab.lineSpace(8, text: model.contentCN ?? "")
//
//    }
//
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
