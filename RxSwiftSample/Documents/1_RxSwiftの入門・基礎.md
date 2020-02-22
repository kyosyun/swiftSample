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
  - オブサーバーパターン: プログラムないのイベントを他のオブジェクトへ通知する処理で使われるデザインパターンの一種  
  - シーケンス: あらかじめ定められた順序または手続きに従って制御の各段階を逐次進めていく制御。可視化するのが簡単な概念  
  - シーケンスをObservaleにすることで、視認しやすく用意に制御出来るようになる。  
  - Event
  ```
  enum Event<Element>  {
      case Next(Element)      // next element of a sequence
      case Error(ErrorType)   // sequence failed with error
      case Completed          // sequence terminated successfully
  }
  ```  
  `Complete`または`Error`イベントで内部リソースを開放する  
  すぐに開放するには`dispose`
