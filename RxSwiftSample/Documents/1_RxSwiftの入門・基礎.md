# 目次
  - observable
  - Disposing
  - 暗黙的なobservableの保証
  - 初めて作るobservable
  - 仕事をするObservable
  - 共有サブスクリプション/ shareReplay
  - オペレーター
  - playgrounds
  - カスタムオペレーター
  - エラーハンドリング
  - コンパイルエラーをデバッグ
  - デバッグ
  - メモリリークのでばアッグ
  - KVO
  - UIレイヤー
  - HTTPリクエスト
  - RxDataSources
  - Driver
  - 実例
# Observable
  - Event
    -
  ```
  enum Event<Element>  {
      case Next(Element)      // next element of a sequence
      case Error(ErrorType)   // sequence failed with error
      case Completed          // sequence terminated successfully
  }
  ```  
  `Complete`または`Error`イベントで内部リソースを開放する  
  すぐに開放するには`dispose`
