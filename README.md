# 作業記録という名のREADME

<!-- TOC depthFrom:2 orderedList:false -->

- [これはなに?](#これはなに)
- [コマンドのインストール](#コマンドのインストール)
- [プロバイダを指定した最初の雛形を作る](#プロバイダを指定した最初の雛形を作る)
    - [前提条件](#前提条件)
    - [リソース定義](#リソース定義)

<!-- /TOC -->

## これはなに?

terraformの練習用です。
<https://www.terraform.io> を参考に進めていきます。

## コマンドのインストール

- <https://learn.hashicorp.com/terraform/getting-started/install.html> も参照
- terraformを入れる
  - tfenvを入れてバージョン管理できるようにする
  - ``tfenv install latest`` で最新版が入る

```bash

% brew install tfenv

% tfenv
tfenv 1.0.1
Usage: tfenv <command> [<options>]

Commands:
   install       Install a specific version of Terraform
   use           Switch a version to use
   uninstall     Uninstall a specific version of Terraform
   list          List all installed versions
   list-remote   List all installable versions

% tfenv install latest
Terraform v0.12.6 is already installed

% terraform -v
Terraform v0.12.6
```

## プロバイダを指定した最初の雛形を作る

### 前提条件

- aws cliを入れておく
- awsの認証情報 (API KEY)を ~/.aws/ 以下に設定済み

### リソース定義

- Ref. [Build Infrastructure](https://learn.hashicorp.com/terraform/getting-started/build)
- 基本の *.tf を作成し、設定を登録する
  - これがないと``terraform init``できない
  - 少なくとも、``provider`` を定義する
  - まずはじめに main.tf として配置
- 変数は ver.tf側に簡単に設定