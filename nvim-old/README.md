how to run tests:
first make sure lua, lua rocks, and `luarocks install busted` are all set up. 

then, run:
```
busted -p test_ lua/tests/
```
  - `-p` means the test files don't need some weird naming convention.  I believe it also implies that all my files beging with `test_`


