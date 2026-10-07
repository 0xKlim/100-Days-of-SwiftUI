//
//  ContentView.swift
//  -04_Consolidation_HabitTracker
//
//  Created by Vladislav on 30.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(value: activity) {
                        ItemRowView(activity: activity)
                    }
                }
                .onDelete(perform: deleteActivities(at: ))
            }
            .navigationTitle("Habit tracker")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add activity", systemImage: "plus") {
                        showingSheet = true
                    }
                }
            }
            .navigationDestination(for: ActivityItem.self) { activityItem in
                DetailView(activity: activityItem, onSave: updateActivities(activity:))
            }
            .sheet(isPresented: $showingSheet) {
                NavigationStack {
                    DetailView(activity: nil, onSave: updateActivities(activity:))
                }
            }
        }
    }
    
    func deleteActivities(at indexes: IndexSet) {
        activities.items.remove(atOffsets: indexes)
    }
    
    func updateActivities(activity: ActivityItem) {
        if let index = activities.items.firstIndex(where: {activity.id == $0.id}) {
            activities.items[index] = activity
        } else {
            activities.items.append(activity)
        }
    }
}

private struct ItemRowView: View {
    let activity: ActivityItem
    
    var body: some View {
        HStack {
            Text(activity.name)
            
            Spacer()
            Text(activity.completionCount.formatted())
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
