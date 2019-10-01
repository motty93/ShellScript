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
