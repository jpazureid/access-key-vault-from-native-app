# access-key-vault-from-native-app

Shows how to access Azure Key Vault from PowerShell

## アクセス トークン取得のためのアプリケーション設定手順

まずは、Azure AD 上にネイティブ アプリケーションを登録します。すでに登録済みの場合、作成済みのアプリについて同様の設定を実施済みかご確認ください。

1. Azure ポータルに管理者でサインインします。
2. [Azure Active Directory] を開きます。
3. [アプリの登録] を選択します。
4. [+ 新しいアプリケーションの登録] を選択します。
5. 名前に任意のものを入力し、アプリケーションの種類は [ネイティブ] を設定します。
6. サインオン URL にはアプリの応答 URL (例として https://localhost を設定します。
7. アプリを作成したら、そのアプリのアプリケーション ID をメモします。
8. [設定] を選択し、[必要なアクセス許可] を選択します。
9. [+ 追加] から [Azure Key Vault] を選択します。
10. [Have full access to the Azure Key Vault service] を選択して保存を押下します。

## アプリの設定内容の変更

KeyVaultforNativeApp.txt を開き、以下の箇所を登録したアプリに合わせて変更します。$tenantId を貴社のテナントに、$clientId を登録したアプリの ID に変更ください。

```powershell
$tenantId = "yourtenant.onmicrosoft.com" 
$resource = "https://vault.azure.net" 
$clientId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
$redirectUri = "https://localhost"
```

また、スクリプトの中ほどにあるKey Vault の URL を貴社でお持ちのものに変更ください。サンプルでは、以下のようにしておりますが、これは SQLPassword というシークレットの値を取得するという例です。

```powershell
$url = "https://yourkeyvault.vault.azure.net/secrets/SQLPassword?api-version=2016-10-01"
```

## アプリの実行

GetModuleByNuget.ps1 を実行ください。実行すると、Tools フォルダーができ、フォルダー内に必要なモジュールが配置されます。本スクリプトは、もう一つの KeyVaultforNativeApp.ps1 の実行に必要なモジュールを取得してくるためのものです。

この状態で、事前に内容を貴社に合わせておいた KeyVaultforNativeApp.ps1 を実行ください。認証画面が表示され、サインインすることで、そのユーザーで Key Vault にアクセスします。