
isucon10 予選問題
========================================



最終提出 Checklist 
----------------------------------------

- [ ] レギュレーションの要件は正しく満たされているか
- [ ] 再起動した際に正しく動くか
- [ ] ベンチマークは完遂できるか
- [ ] 各種Loggingをオフにしたか
    - mysql
        - [ ] slow query
    - nginx
        - [ ] access log
    - app
        - [ ] newrelic logger
        - [ ] stdout
    - newrelic
        - [ ] newrelic infrastrucre agent
