import SwiftUI

struct AppState: Equatable {
  var userData: UserData = UserData()
}

extension AppState {
  
  struct UserData: Equatable {
    
    /// Общее количество денег до следующего крупного пополнения (зарплата/премия)
    var totalCash: Int {
      didSet {
        UserDefaults.standard.set(totalCash, forKey: "totalCash")
      }
    }
    
    /// Количество дней до ближайшей зарплаты
    var daysBeforePay: Int {
      didSet {
        UserDefaults.standard.set(daysBeforePay, forKey: "daysBeforePay")
      }
    }
    
    /// Количество денег на сегодня
    var todayCash: Int {
      didSet {
        UserDefaults.standard.set(todayCash, forKey: "todayCash")
      }
    }
    
    init() {
      
      if (UserDefaults.standard.object(forKey: "totalCash") == nil) {
        
        // Начальная общая сумма всех накоплений до следующей зарплаты
        UserDefaults.standard.set(21_000, forKey: "totalCash")
      }
      
      if (UserDefaults.standard.object(forKey: "daysBeforePay") == nil) {
        
        // Начальная общая сумма всех наконплений до следующей зарплаты
        UserDefaults.standard.set(11, forKey: "daysBeforePay")
      }
      
      // Устанавливаем начальное значение количества денег на сегодня,
      // при первом запуске приложения
      if (UserDefaults.standard.object(forKey: "todayCash") == nil) {
        
        let tempTotalCash: Int = UserDefaults.standard.object(forKey: "totalCash") as! Int
        
        let tempDaysBeforePay: Int = UserDefaults.standard.object(forKey: "daysBeforePay") as! Int
        
        UserDefaults.standard.setValue(
          (tempTotalCash / tempDaysBeforePay),
          forKey: "todayCash")
      }
      
      self.totalCash      = UserDefaults.standard.object(forKey: "totalCash") as! Int
      self.daysBeforePay  = UserDefaults.standard.object(forKey: "daysBeforePay") as! Int
      self.todayCash      = UserDefaults.standard.object(forKey: "todayCash") as! Int
    }
  }
}
