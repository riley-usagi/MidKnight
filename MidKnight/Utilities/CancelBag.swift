import Combine

/// Объект для сбора "подписок", которые в дальнейшем будут уничтожены.
///
/// Он же - "Мешок с подписками."
final class CancelBag {
  
  /// Список собранных подписок
  fileprivate(set) var subscriptions = Set<AnyCancellable>()
  
  /// Удаление всех подписок
  func cancel() {
    subscriptions.removeAll()
  }
}

extension AnyCancellable {
  
  /// Метод добавления подписки в список подписок
  /// - Parameter cancelBag: Мешок с подписками
  func store(in cancelBag: CancelBag) {
    cancelBag.subscriptions.insert(self)
  }
}
