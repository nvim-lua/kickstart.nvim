((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

((text) @injection.content
    (#has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language bash))

((php_only) @injection.content
    (#set! injection.combined)
    (#set! injection.language php_only))

((parameter) @injection.content
    (#set! injection.language php_only))
