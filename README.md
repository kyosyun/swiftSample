|プロジェクト|概要|ポイント|
|---|---|---|
|PictureSampleProject|カメラロール・写真撮影した内容を表示する|- UIImagePickerControllerを使ってカメラからの写真の読み込み。<br> - UIImagePickerControllerを使ってカメラロールから写真の読み込み <br> - 写真をローカルのディレクトリ(documentDirectory)に保存する <br> - 写真をローカルディレクトリから読み込む<br> - 表示している写真を圧縮する <br> - UIImageの容量を取得する<br> - |
|PictureSample2|UIImagePickerControllerではなく、AVCaptureSessionを利用してカメラ撮影を行う| - AVCaptureSessionを利用してカメラ撮影<br> - 撮影した写真をPhotoLibraryに保存を行う<br> -  ISOとシャッタースピードの処理 <br> - ホワイトバランスの調整 |
|sampleWebViewProject|ローカルのWebViewを表示する| - ローカルのHTMLファイルを読み込んでWKWebViewに表示する<br> - SwiftからJS操作を行う。<br> - SwiftからWebViewにデータを受け渡す<br>|
|sampleWebViewProject2|webViewの画像処理| - 画像をUIImageをBASE64Encodeして、WebViewに受け渡す|
|sampleWebView3|webViewのアクションによってNativeを操作する| - WebView内で発火したアクションをキャッチする<br> - WebViewからNativeへデータを受け渡す|
|CollectionViewSample|CollectionViewSample| - CollectionViewの利用 <br> - CollectionViewを下にスワイプしてViewの更新・リセット|
|TableViewControllerSample|tableViewControllerを利用してみる| -  UITableViewControllerの利用|
|FirebaseDynamicLinksSample|DynamicLinkを利用してみる| - DynamicLinkのチュートリアル実装<br> - DynamicLinkのURLをアプリで読み込み|
|GrowthPushSample|GrowthPushを利用してみる| - GrowthPushのSDK導入|
|RealmSample|Realmへの保存・ロード| - realmへの保存<br> - realmからの読み込み<br> - idを自動生成|
|mkMapViewSample|MKMapViewの利用| - 地図の表示<br> - 現在地の表示<br> - 現在地を地図の中心にする<br> - 住所を入力して該当箇所を表示・ピンを指す<br> - ロングタップの検出|
|TextViewWithPlaceHolder|PlaceHolder付きのTextViewの利用| - PlaceHolderをインスペクタクルで設定出来るようにする。|
|ScrollViewSample| - scrollViewの利用<br>| - scrollViewをstoryBoard経由で利用する。<br> - キーボード立ち上げ時に入力欄がキーボードで隠れない用にする|
|CropViewSample| - CropViewの利用<br>| - 画像を選択してCropVIewで画像をトリミングする。|
| LocalizationSample| - 様々な多言語対応を試してみる |- localizedString.stringsを利用した多言語対応<br> - storyboardの切り出しにより多言語対応<br> - 再起動しないで言語を切り替える <br> - Labelの多言語対応. <br> - 端末の言語読み込み. <br> - 言語によって画像の置き換え|
| LocalizedStringSample| - LocalizedString.stringsを使った多言語対応とTips|- 起動中に言語切替:NSLocalizedStringのOverride <br> - viewの再読み込み <br> - 端末言語をデフォルトにする <br> - swiftgenを利用 <br> UserDefaultsにおいてEnumを保存する|
| AVPlayerSample | - AVPlayerの利用| - URLから動画の読み込みを実施 <br> - 動画をSeekして、最初から再生 |
| QrCodeSample| - AVCaptureMetadataOutputを利用してQRコード読み取る | - QRコードを読み込む<br> - 読み込んだQRコードがURLだった場合はsafariで開く |
| QRCodeReaderSample | - AVCaptureSession / AVCaptureMetadataOutputObjectsDelegate を利用してQRコードの読み込み| - QRコードを読み込む<br> - 読み込んだQRコードに枠をつける |
| QRCodeImageReader | - CIQRCodeFeatureを使ったQRコードの読み込み| - ライブラリからの画像を読み込む <br> - 読み込んだ画像の中にQRコードがあれば解析して表示|
| TODO | - TODO <br>| - Libraryから動画の読み込み |
| TODO | - TODO <br>| - 弧の描画 |
| TODO | - TODO <br>| - 文字列の圧縮 |
| TODO | - TODO <br>| - 文字列からQRコードの生成 |
|SwiftUISample| - swiftUIを利用してみる| - TODO | 
|UserDefinedRuntimeAttributesSample| - UserDefinedAttributesを利用してみる<br>| - 色をつけてみる<br> |
|QRCodeCreator| - CIFilterを使ってQRコードの生成を行う。 | - QRコードの生成を行う。 | 
||||
