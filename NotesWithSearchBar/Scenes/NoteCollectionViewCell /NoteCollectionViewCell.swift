//
//  NoteCollectionViewCell.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLabel()
    }
    
    private func setUpLabel(){
        addSubview(label)
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = .init(x: 0, y: 0, width: 100, height: 100)
    }
    
    func configure(with header : Note){
        label.text = header.header 
    }
    
}
