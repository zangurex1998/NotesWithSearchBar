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
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
