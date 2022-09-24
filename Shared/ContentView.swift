//
//  ContentView.swift
//  Shared
//
//  Created by Simeon Dimov on 15/09/2022.
//

import SwiftUI
import HealthKit
struct ContentView: View {
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    
        var body: some View {
        Text("Hello, world 12312323")
            .padding()
            .onAppear {
                          if let healthStore = healthStore {
                              healthStore.requestAuthorization { success in
                                  if success {
                                      healthStore.calculatePace { statisticsCollection in
                                          if let statisticsCollection = statisticsCollection {
                                              // update the UI
                                              
                                              
                                              print(statisticsCollection)
                                          }
                                      }
                                  }
                              }
                          }
                      }
          }}
                

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
