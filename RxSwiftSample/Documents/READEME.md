#目次
  - なぜRxなのか？
  - *RxSwiftの入門・基本*
  - 単位
    - Driver
    - ControlProperty
    - Variable
  - test
  - コツと共通エラー
  - デバッグ
  - Rxの裏にある数学
  - hot/cold observable sequece とはなにか
  - 公開APIのSample

# なぜRxなのか
- ストリームをどう扱うかという視点で、`組み立て可能・再利用可能・宣言的`に記述出来る
- ユニットテストが書きやすく安定的
- リソース管理が用意
- 単方向データフローとしてモデル化することで、ステートフルにかける。
ex) 非同期システムのモデル化において、状態を持たず人、抽象化して記載を行うことが出来る。認知的負荷を下げる。

## リアクティブプログラミングの提供するもの
- ストリームの生成・加工・監視

## ストリームの監視
 - タップ・文字列の生成・通信など同期・非同期問わずに出来る。  

## ストリームの加工
 - ストリーム上のデータに対して、filter/map/mergeなど出来る。(オペレータ)  
参考: http://rxmarbles.com/  
https://github.com/tid-kijyun/RxSwift/blob/translates-into-japanese/Documentation_ja/API.md  
https://github.com/tid-kijyun/RxSwift/blob/translates-into-japanese/Documentation_ja/GettingStarted.md#life-happens
