//
//  EditUserView.swift
//  12_SwiftDataProject
//
//  Created by Vladislav on 21.10.2026.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
            
//            if let jobs = user.jobs, !jobs.isEmpty {
            if !user.unwrappedJobs.isEmpty {
                Section("Jobs") {
                    ForEach(user.unwrappedJobs) { job in
                        HStack {
                            Text(job.name)
                            Spacer()
                            Text("Priority: \(job.priority.formatted())")
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditUserView(user: User(name: "Taylor Swift", city: "Nashville", joinDate: .now))
        .modelContainer(for: User.self, inMemory: true)
}
