//
//  DataStore.swift
//  ToDoTrainee
//
//  Created by Kostiantyn Kaniuka on 08.12.2022.
//

import Foundation

class DataStore: ObservableObject {
    @Published var toDos: [ToDo] = []
    
    init() {
        print(FileManager().docExists(named: fileName))
        loadToDos()
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.append(toDo)
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.firstIndex(where: {$0.id == toDo.id}) else { return }
        toDos[index] = toDo
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.remove(atOffsets: indexSet)
    }
    
    func loadToDos() {
        FileManager().readDocment(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    toDos = try decoder.decode([ToDo].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveToDos() {
        print("Saving toDos to file system eventually")
    }
}
