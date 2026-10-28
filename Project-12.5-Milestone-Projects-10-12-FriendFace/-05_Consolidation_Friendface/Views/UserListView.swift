//
//  UserListView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 28.10.2026.
//

import SwiftUI
import SwiftData

struct UserListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    
    init(filter: UserFilter, sort: [SortDescriptor<User>]) {
        let predicate: Predicate<User>
        
        switch filter {
        case .all:
            predicate = #Predicate { _ in true }
        case .online:
            predicate = #Predicate { $0.isActive }
        case .offline:
            predicate = #Predicate { !$0.isActive }
        }
        
        self._users = Query(filter: predicate, sort: sort)
    }
    
    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(value: user) {
                    UserRowView(name: user.name, isActive: user.isActive)
                }
            }
            .onDelete(perform: deleteUser(at:))
        }
    }
    
    func deleteUser(at indexes: IndexSet) {
        for index in indexes {
            modelContext.delete(users[index])
        }
    }
}

#Preview {
    UserListView(filter: .all, sort: [SortDescriptor<User>(\.name)])
}
