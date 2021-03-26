//
//  FilterCell.swift
//  TechnicalTest

import UIKit

class FilterCell: UITableViewCell {

    private var titleLabel = UILabel()
    private var imgSelect = UIImageView()
    var viewContainer = UIControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "FilterCell")
                
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(title: String?, isSelect: Bool?) {

        titleLabel.text = title
        
        if isSelect ?? false {
            
            imgSelect.image = UIImage(named:"icon_selected")
            imgSelect.layer.cornerRadius = imgSelect.frame.height / 2
            
        }else {
            
            imgSelect.image = UIImage(named:"icon_unselected")
            imgSelect.layer.cornerRadius = imgSelect.frame.height / 2
        }
    }
    
    private func addConstraints() {
        
        viewContainer = UIControl.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.contentView.frame.height))
        viewContainer.backgroundColor = .white
        self.contentView.addSubview(viewContainer)
        
        
        imgSelect  = UIImageView(frame:CGRect(x: 10, y: 12, width: 20, height: 20));
        imgSelect.contentMode = .scaleAspectFit
        viewContainer.addSubview(imgSelect)
        
        titleLabel = UILabel(frame: CGRect(x: imgSelect.frame.width + 25, y: 0, width: viewContainer.frame.width-10, height: self.contentView.frame.height))
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .white
        viewContainer.addSubview(titleLabel)
   
    }
}
