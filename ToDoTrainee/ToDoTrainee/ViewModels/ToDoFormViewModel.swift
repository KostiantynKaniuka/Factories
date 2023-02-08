//
//  ToDoFormViewModel.swift
//  ToDoTrainee
//
//  Created by Kostiantyn Kaniuka on 09.12.2022.
//

import Foundation

class ToDoFormViewModel: ObservableObject {
    @Published var name = " "
    @Published var completed = false
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        name.isEmpty
    }
    
    init() {
        
    }
    
    init(_ currentToDo: ToDo) {
        self.name = currentToDo.name
        self.completed = currentToDo.completed
        id = currentToDo.id
    }
}
