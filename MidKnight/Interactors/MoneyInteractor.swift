import Combine

protocol MoneyInteractor {
  func spendSomeMoney(value: String)
}

struct RealMoneyInteractor: MoneyInteractor {
  private let appState: Store<AppState>
  
  init(appState: Store<AppState>) {
    self.appState = appState
  }
  
  func spendSomeMoney(value: String) {

    let spendedValue: Int = Int(value)!
    
    if appState[\.userData.todayCash] > spendedValue && appState[\.userData.totalCash] > spendedValue {
      appState[\.userData.todayCash] -= spendedValue
      appState[\.userData.totalCash] -= spendedValue
    } else {
      appState[\.userData.todayCash] = 0
    }
  }
}

struct StubMoneyInteractor: MoneyInteractor {
  func spendSomeMoney(value: String) {}
}
