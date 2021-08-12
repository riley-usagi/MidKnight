import SwiftUI

struct NewDayScreen: View {
  
  
  // MARK: - Variables
  @Environment(\.container) private var container: Container
  
  @State private var targets: Loadable<LazyList<Target>>
  
  @Binding var displayStatus: Bool
  
  let cancelBag: CancelBag = CancelBag()
  
  var body: some View {
    content
  }
  
  
  // MARK: - Initializers
  
  init(targets: Loadable<LazyList<Target>> = .notRequested, displayStatus: Binding<Bool>) {
    self._targets = .init(initialValue: targets)
    self._displayStatus = displayStatus
  }
}


private extension NewDayScreen {
  
  private var content: some View {
    switch targets {
    
    case .notRequested:
      return AnyView(notRequestedView)
    case .isLoading(_, _):
      return AnyView(loadingView)
    case let .loaded(loadedTargets):
      return AnyView(loadedView(loadedTargets))
    case .failed(_):
      return AnyView(Text(""))
    }
  }
}

private extension NewDayScreen {
  var notRequestedView: some View {
    EmptyView()
      .onAppear {
        container.interactors.targetsInteractor.targetsFromCoreData(targets: $targets)
      }
  }
}


private extension NewDayScreen {
  var loadingView: some View {
    ActivityIndicatorView()
  }
}


private extension NewDayScreen {
  
  func loadedView(_ loadedTargets: LazyList<Target>) -> some View {
    VStack {
      HStack {
        Text("Choose your target")
      }
      
      Divider()
      
      List {
        
        ForEach(loadedTargets) { target in
          HStack {
            Text(target.name)
              .font(.title)
            Spacer(minLength: 0)
            Text("Status: \(target.currentValue) of \(target.targetValue)")
          }
          .padding()
          .onTapGesture {
            container.interactors.targetsInteractor.updateTarget(target)
              .sink { _ in } receiveValue: { updatingResult in
                if updatingResult {
                  displayStatus = false
                }
              }
              .store(in: cancelBag)
          }
        }
      }
    }
    .padding()
  }
}
