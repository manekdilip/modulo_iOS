//
//  DeviceListCell.swift
//  TechnicalTest

import UIKit

class DeviceListCell: UITableViewCell {

    private var titleLabel = Label()
    private var subtitleLabel = Label(type: .activeSubtitle)
    private var extraLabel = Label(type: .subtitle)
    private var bodyLabel = Label(type: .activeSubtitle)
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "DeviceListCell")
        self.addConstraints()
    }
    
    func setup(title: String?, subtitle: String?, extra: String?, body: String?, isUrl: Bool = false) {
        titleLabel.set(value: title)
        subtitleLabel.set(value: subtitle, color: isUrl ? UIColor.blue : UIColor.black)
        extraLabel.set(value: extra)
        bodyLabel.set(value: body)
    }
    
    private func addConstraints() {
        let views = ["title": titleLabel, "subtitle": subtitleLabel, "extra": extraLabel, "body": bodyLabel] as [String: Any]
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(extraLabel)
        contentView.addSubview(bodyLabel)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-12-[title][subtitle][extra][body]-12-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[title]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[subtitle]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[extra]-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[body]-|", options: [], metrics: nil, views: views))
    }
}

