//
//  ModelType.swift
//  ToDoTrainee
//
//  Created by Kostiantyn Kaniuka on 09.12.2022.
//

import SwiftUI

enum ModalType: Identifiable, View {
    case new
    case update(ToDo)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return ToDoFormView(formVM: ToDoFormViewModel())
        case .update(let toDO):
            return ToDoFormView(formVM: ToDoFormViewModel(toDO))
        }
    }
}
