//
//  NoteDataSource.swift
//  NotesWithSearchBar
//
//  Created by technomix on 18.01.23.
//

import Foundation
class NoteDataSource{
    static var shared = NoteDataSource()
    var notes : [Note] = []
}
