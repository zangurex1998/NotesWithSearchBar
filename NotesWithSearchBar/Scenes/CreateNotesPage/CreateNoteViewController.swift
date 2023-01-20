//
//  CreateNoteViewController.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import UIKit

class CreateNoteViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    //MARK: - Properties
    var note : Note = .init(header: "", text: "")
    var index : Int?
   
    
  
        
     
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let index = index {
                note = NoteDataSource.shared.notes[index]
            }
            headerTextField.text = note.header
            noteTextView.text = note.text
            setUpRightButton()
            setUpView()
            setUpLeftButton()
           
        }

        private func setUpRightButton(){
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .done, target: self, action: #selector(didTapPlusbutton))
        }
        @objc func didTapPlusbutton(){
            note.header = headerTextField.text ?? ""
            note.text = noteTextView.text ?? ""
            
            if let index = index {
                NoteDataSource.shared.notes[index] = note
            }else{
                NoteDataSource.shared.notes.append(note)
            }
            saveNotes()
            navigationController?.popViewController(animated: true)
            
            
        }
        private func setUpView(){
            noteTextView.layer.borderWidth = 1
            noteTextView.layer.borderColor = .init(gray: 100, alpha: 1)
            headerTextField.attributedPlaceholder = NSAttributedString(string: "Header", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        
        private func setUpLeftButton(){
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.bin.fill"), style: .done, target: self, action: #selector(didTapDelete))
        }
        @objc private func didTapDelete(){
            if let index = index {
                NoteDataSource.shared.notes.remove(at: index)
            }
            saveNotes()
            navigationController?.popViewController(animated: true)
           
        }
    
    private func saveNotes(){
        if let encodedData = try? JSONEncoder().encode(NoteDataSource.shared.notes){
            UserDefaults.standard.set(encodedData, forKey: "SavedNotes")
        }
    }
    
  
        
      
      

        
        
    }

