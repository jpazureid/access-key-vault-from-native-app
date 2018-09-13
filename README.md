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

AccessKeyVaultFromNativeApp.ps1 を開き、以下の箇所を登録したアプリに合わせて変更します。$tenantId を貴社のテナントに、$clientId を登録したアプリの ID に変更ください。$keyvault には、事前に作成いただいている Key Vault 名を指定します。

```powershell
$tenantId = "yourtenant.onmicrosoft.com" # or GUID "01234567-89AB-CDEF-0123-456789ABCDEF"
$clientId = "FEDCBA98-7654-3210-FEDC-BA9876543210"
$keyvault = "yourkeyvaultname"
$redirectUri = "urn:ietf:wg:oauth:2.0:oob"
$resource = "https://vault.azure.net" 
```

## アプリの実行

GetAdModuleByNuget.ps1 を実行ください。実行すると Tools フォルダーができ、フォルダー内に必要なモジュールが配置されます。本スクリプトは、もう一つの AccessKeyVaultFromNativeApp.ps1 の実行に必要なモジュールを取得してくるためのものです。

この状態で、事前に内容を貴社に合わせておいた AccessKeyVaultFromNativeApp.ps1 を実行します。認証画面が表示されますので、Key Vault の処理を行いたいユーザーでサインインすることで、そのユーザーで処理が行われます。

本スクリプトでは以下の操作を順に行っています。

- Key Vault キーの作成 (TestKey)
- Key Vault キーの読み取り (TestKey)
- Key Vautl シークレットの作成 (TestSecret)
- Key Vautl シークレットの読み取り (TestSecret)

それぞれ以下のような結果が出力されることをご確認いただけます。

### Key Vault キーの作成と読み取り

要求は以下のとおりです。

```
POST https://yourkeyvaultname.vault.azure.net//keys/ContosoFirstKey/create?api-version=2016-10-01
Authorization: Bearer eyJ0eXAiOi{省略}3lISmxZIn0.eyJhdWQiOi{省略}joiMS4wIn0.FDlzA1xpic{省略}Nj_6yECdIw
```

以下の Body を POST 要求で送信しています。

```json
{
  "kty": "RSA",
  "attributes": {
    "enabled": true
  }
}
```

得られる応答 (出力) は以下のとおりです。

```json
{
    "key": {
        "kid": "https://yourkeyvaultname.vault.azure.net/keys/TestKey/25f66f574aa64bc5829139082e3ace63",
        "kty": "RSA",
        "key_ops": [
            "encrypt",
            "decrypt",
            "sign",
            "verify",
            "wrapKey",
            "unwrapKey"
        ],
        "n": "tuCbLWITBYLVGnXbFjFv4ns6YYb-XezCMuaQK0FuTPSHZ3p95vGfmB7iWmMvLEzeH4zoGbYtkGxpulMWU5QDfb_GM_N-bB0sjoiqOAj9LusR5ljGB8lmsfZvlu0TKol1Q0cn964Q99L9brI_wa90gt-qkaKFi-8Rs7Vq1BucrXnpAZpkafViz9MNWb_EshUUq424CA_O9UZn_W5jkkbEkvHkhedA3wLoYS9U97yvl6XtvU_P6NRFG7gKRuFDydQ6BqiYWnjAc3FOb1VaFWalt2i9E4LwR8RT5tfAj4bcbAM3aemFp0lZYM0XhtLXzauLDLI3cmkCCDKvKxkZbm_x6Q",
        "e": "AQAB"
    },
    "attributes": {
        "enabled": true,
        "created": 1536834933,
        "updated": 1536834933,
        "recoveryLevel": "Purgeable"
    }
}
```

### Key Vault シークレットの作成と読み取り

要求は以下のとおりです。

```
PUT https://jutakata02keyvault02.vault.azure.net//secrets/SQLPassword?api-version=2016-10-01 
Authorization: Bearer eyJ0eXAiOi{省略}3lISmxZIn0.eyJhdWQiOi{省略}joiMS4wIn0.FDlzA1xpic{省略}Nj_6yECdIw
```

以下の Body を POST 要求で送信しています。

```json
{
  "value": "Pa$$w0rd",
  "attributes": {
    "enabled": true
  }
}
```

得られる応答 (出力) は以下のとおりです。

```json
{
    "value": "Pa$$w0rd",
    "id": "https://yourkeyvaultname.vault.azure.net/secrets/TestSecret/886048f39c0d48c59bf66b25a4a0305c",
    "attributes": {
        "enabled": true,
        "created": 1536834955,
        "updated": 1536834955,
        "recoveryLevel": "Purgeable"
    }
}
```