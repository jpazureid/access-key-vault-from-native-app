# access-key-vault-from-native-app

Shows how to access Azure Key Vault from PowerShell

## �A�N�Z�X �g�[�N���擾�̂��߂̃A�v���P�[�V�����ݒ�菇

�܂��́AAzure AD ��Ƀl�C�e�B�u �A�v���P�[�V������o�^���܂��B���łɓo�^�ς݂̏ꍇ�A�쐬�ς݂̃A�v���ɂ��ē��l�̐ݒ�����{�ς݂����m�F���������B

1. Azure �|�[�^���ɊǗ��҂ŃT�C���C�����܂��B
2. [Azure Active Directory] ���J���܂��B
3. [�A�v���̓o�^] ��I�����܂��B
4. [+ �V�����A�v���P�[�V�����̓o�^] ��I�����܂��B
5. ���O�ɔC�ӂ̂��̂���͂��A�A�v���P�[�V�����̎�ނ� [�l�C�e�B�u] ��ݒ肵�܂��B
6. �T�C���I�� URL �ɂ̓A�v���̉��� URL (��Ƃ��� https://localhost ��ݒ肵�܂��B
7. �A�v�����쐬������A���̃A�v���̃A�v���P�[�V���� ID ���������܂��B
8. [�ݒ�] ��I�����A[�K�v�ȃA�N�Z�X����] ��I�����܂��B
9. [+ �ǉ�] ���� [Azure Key Vault] ��I�����܂��B
10. [Have full access to the Azure Key Vault service] ��I�����ĕۑ����������܂��B

## �A�v���̐ݒ���e�̕ύX

KeyVaultforNativeApp.txt ���J���A�ȉ��̉ӏ���o�^�����A�v���ɍ��킹�ĕύX���܂��B$tenantId ���M�Ђ̃e�i���g�ɁA$clientId ��o�^�����A�v���� ID �ɕύX���������B

```powershell
$tenantId = "yourtenant.onmicrosoft.com" 
$resource = "https://vault.azure.net" 
$clientId = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
$redirectUri = "https://localhost"
```

�܂��A�X�N���v�g�̒��قǂɂ���Key Vault �� URL ���M�Ђł������̂��̂ɕύX���������B�T���v���ł́A�ȉ��̂悤�ɂ��Ă���܂����A����� SQLPassword �Ƃ����V�[�N���b�g�̒l���擾����Ƃ�����ł��B

```powershell
$url = "https://yourkeyvault.vault.azure.net/secrets/SQLPassword?api-version=2016-10-01"
```

## �A�v���̎��s

GetModuleByNuget.ps1 �����s���������B���s����ƁATools �t�H���_�[���ł��A�t�H���_�[���ɕK�v�ȃ��W���[�����z�u����܂��B�{�X�N���v�g�́A������� KeyVaultforNativeApp.ps1 �̎��s�ɕK�v�ȃ��W���[�����擾���Ă��邽�߂̂��̂ł��B

���̏�ԂŁA���O�ɓ��e���M�Ђɍ��킹�Ă����� KeyVaultforNativeApp.ps1 �����s���������B�F�؉�ʂ��\������A�T�C���C�����邱�ƂŁA���̃��[�U�[�� Key Vault �ɃA�N�Z�X���܂��B