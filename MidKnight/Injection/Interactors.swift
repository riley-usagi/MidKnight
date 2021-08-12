extension Container {
  
  struct Interactors {
    
    let targetsInteractor: TargetsInteractor
    
    let moneyInteractor: MoneyInteractor
    
    init(
      targetsInteractor: TargetsInteractor,
      moneyInteractor: MoneyInteractor
    ) {
      self.targetsInteractor  = targetsInteractor
      self.moneyInteractor    = moneyInteractor
    }
    
    static var stub: Self {
      .init(
        targetsInteractor: StubTargetsInteractor(),
        moneyInteractor: StubMoneyInteractor()
      )
    }
  }
}
