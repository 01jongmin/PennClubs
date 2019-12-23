import UIKit

class TagCell: UICollectionViewCell {
    
    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor(red:0.85, green:0.92, blue:0.98, alpha:1.0)
        layer.cornerRadius = 13
    }
    
    let tagLabel = UILabel()
    let cell = UIView()
    
    func set(tags: Tag) {
        tagLabel.text = tags.name
        tagLabel.textColor = UIColor(red:0.14, green:0.40, blue:0.58, alpha:1.0)
        tagLabel.font = UIFont(name: "HelveticaNeue-Bold" , size: 12)
        self.addSubview(tagLabel)
        
        super.layoutIfNeeded()
//        self.layoutSubviews()
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
        
//        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
