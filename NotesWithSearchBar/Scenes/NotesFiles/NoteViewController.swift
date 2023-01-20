//
//  NoteViewController.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import UIKit

class NoteViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - properties
    let searchController = UISearchController()
    var note = NoteDataSource.shared.notes
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        notificationListener()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpSearchController()
        setUpRightButton()
        getNotes()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    
    }
    deinit {
        removeObserver()
    }
    
    //MARK: - Methods
    private func notificationListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(observedNotification), name: .name, object: nil)
    }
    @objc func observedNotification(notification : Notification){
       guard let notification = notification.userInfo?["username"] else {return}
        navigationItem.title = "\(notification)'s Notes"
    }
    private func removeObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    private func setUpCollectionView(){
        collectionView.backgroundColor = .black
        self.note = NoteDataSource.shared.notes
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "NoteCollectionViewCell")
    }
    private func setUpSearchController(){
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setUpRightButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .done, target: self, action: #selector(didTapAddButton))
    }
    @objc func didTapAddButton(){
        let vc = UIStoryboard(name: "CreateNote", bundle: nil).instantiateViewController(withIdentifier: "createNote") as! CreateNoteViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    private func getNotes(){
        guard let data = UserDefaults.standard.data(forKey: "SavedNotes") else {return}
        guard let savedNotes = try? JSONDecoder().decode([Note].self, from: data) else {return}
        NoteDataSource.shared.notes = savedNotes
        print(NoteDataSource.shared.notes)
    }
       
}

   

//MARK:  - UICollectionViewDelegate

extension NoteViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "CreateNote", bundle: nil).instantiateViewController(withIdentifier: "createNote") as! CreateNoteViewController
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - UICollectionViewDataSource
extension NoteViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NoteDataSource.shared.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCollectionViewCell", for: indexPath) as! NoteCollectionViewCell
        cell.configure(with: NoteDataSource.shared.notes[indexPath.row])
        return cell
    }
    
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension NoteViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = view.frame.width / 4
        let height = width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 4, left: 10, bottom: 0, right: 10)
    }
}
//MARK: - UISearchResultsUpdating
extension NoteViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text.isEmpty{
            self.note = NoteDataSource.shared.notes
            
        }else{
            NoteDataSource.shared.notes = self.note.filter{$0.header.lowercased().contains(text.lowercased())}
            
        }
        self.collectionView.reloadData()
        
    }
    
    
}




