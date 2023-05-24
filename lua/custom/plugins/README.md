### NULL-LS

`goland`:

```shell
go install github.com/incu6us/goimports-reviser/v3@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest

go install github.com/go-delve/delve/cmd/dlv@latest # for go debug
```

Substitute Mode
```shell
:V,s/pattern/
```

Check for key combination
```shell
:nmap # show all maps for normal mode
:nmap <leader> # show maps for the leader
:verbose nmap <leader> # show where the map was last set
:telescope keymaps
```

Open new Tab
```shell
<c>wT
```

Moving between tabs
```shell
gt # next tab
gT # previous tab
```
