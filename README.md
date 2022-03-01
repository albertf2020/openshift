## Description

| VM Node | Private IP | Roles |
| --- | --- | --- |
| master | #{NETWORK_BASE}.101 | node, master, etcd |
| node01 | #{NETWORK_BASE}.102 | node |
| node02 | #{NETWORK_BASE}.103 | node |

### Bring Vagrant Up

```bash
$ ./all_in_own.sh 2>&1 | tee log.txt
```

### Open Web Console

In browser of your host, open the following page: https://master.example.com:8443/ and you should see OpenShift Web Console login page. The default login account is **admin/handhand**

