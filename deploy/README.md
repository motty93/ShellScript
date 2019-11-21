## push.sh & pull.sh
デプロイを簡潔にできるスクリプト。
各プロジェクトのappルートに配置し、自分用にpasswordとssh鍵のパスを変更すれば使用可能。
例: pull.sh

```sh
#!/bin/bash

branch=$(git rev-parse --abbrev-ref HEAD)

expect -c "
set timeout 10
spawn git pull origin $branch
expect \"Enter passphrase for key '/home/user/.ssh/secret_keys/github_rsa':\" # pull時に表示されるものをそのままコピペ
send \"password\n\" # passwordをssh時に要求されるものへ置き換え
interact
"
```
上記設定後に以下を実行
```
$ chmod 755 pull.sh

$ ./pull.sh
```

push.shも同様

## pull & pushコマンドの作成

* `pull_and_push.sh`の中身を `.bashrc` or `.bash_profile` へ追記(zshを使っている場合は`.zshrc` などへ追記する)

* 変数 `GITHUB_NAME`, `GITHUB_PASSWORD`, `SSH_PASSWORD`を設定する

* git管理下プロジェクトでpull or pushを入力する(現在のブランチを取得して、pushとpullを行ってくれる)

* ssh鍵の場所がわかる場合は `mdfind` と`locate` が書いてあるif文を削除し、直接ssh鍵のパスを入力するとよい
