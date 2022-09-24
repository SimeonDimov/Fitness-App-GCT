//
//  HealthStore.swift
//  Fitness App
//
//  Created by Simeon Dimov on 20/09/2022.
//

import Foundation
import HealthKit



extension Date {
    static func thursdayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}



class HealthStore {
    
    var healthStore: HKHealthStore?
     var query: HKStatisticsCollectionQuery?
     
     init() {
         if HKHealthStore.isHealthDataAvailable() {
             healthStore = HKHealthStore()
         }
     }
    
    
    
    func calculatePace(completion: @escaping (HKStatisticsCollection?)-> Void){
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.vo2Max)!
        let startTime = Calendar.current.date(byAdding: .day, value: +0 , to: Date())
        let anchorDate = Date.thursdayAt12AM()
        let hourly = DateComponents(day:1)
        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: Date(), options: .strictStartDate)
        
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .mostRecent , anchorDate: anchorDate, intervalComponents: hourly)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in completion(statisticsCollection)
        }
        if let healthStore = healthStore, let query = self.query{
            healthStore.execute(query)
        }
    }
        func requestAuthorization(completion: @escaping (Bool) -> Void) {
                
                let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.vo2Max)!
                
                guard let healthStore = self.healthStore else { return completion(false) }
                
                healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
                    completion(success)
                }
                
            }
        
    }

