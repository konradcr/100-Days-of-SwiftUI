//
//  ScoresView.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//

import SwiftUI

struct ScoresView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Result.entity(),
        sortDescriptors:  [NSSortDescriptor(keyPath: \Result.totalResult, ascending: false)]
    ) var results: FetchedResults<Result>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(results, id: \.self) { result in
                        HStack {
                            Text("Total: \(result.wrappedTotalResult)")
                            ForEach(result.diceArray, id: \.dieResult) { newDie in
                                Text("Die: \(newDie.wrappedDieResult)")
                            }
                        }
                    }
                    .onDelete(perform: removeResult(at:))
                }
            }
            .navigationBarTitle(Text("Scores"))
            .navigationBarItems(trailing: EditButton())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func removeResult(at offsets: IndexSet) {
        for index in offsets {
            let result = results[index]
            for die in result.diceArray {
                moc.delete(die)
            }
            moc.delete(result)

            do {
                try moc.save()
            } catch {
                print("Error with save after delete Result")
            }
        }
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
