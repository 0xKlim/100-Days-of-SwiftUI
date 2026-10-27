//
//  UserDetailView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 27.10.2026.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    @Binding var path: [User]
    let getUser: (UUID) -> User?
    
    let sortedFriends: [Friend]
    
    init(user: User, path: Binding<[User]>, getUser: @escaping (UUID) -> User?) {
        self.user = user
        self._path = path
        self.getUser = getUser
        self.sortedFriends = user.friends.sorted {$0.name < $1.name}
    }
    
    var body: some View {
        Form {
            Section("User information"){
                UserDetailRowView(title: "Address", description: user.address)
                UserDetailRowView(title: "Age", description: user.age.formatted())
                UserDetailRowView(title: "Company", description: user.company)
                UserDetailRowView(title: "Email", description: user.email)
                UserDetailRowView(title: "Registered", description: user.registered.formatted(date: .abbreviated, time: .omitted))
                UserDetailRowView(title: "Tags", description: user.tags.joined(separator: ", "))
            }
            if !user.friends.isEmpty {
                Section("Friends") {
                    ForEach(sortedFriends) { friend in
                        if let user = getUser(friend.id) {
                            NavigationLink(value: user) {
                                UserRowView(name: user.name, isActive: user.isActive)
                            }
                        } else {
                            Text(friend.name)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                    UserOnlineStatusView(isActive: user.isActive)
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Home", systemImage: "house") {
                    path.removeAll()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UserDetailView(user: .example, path: .constant([User]())) { _ in
            nil
        }
    }
}
