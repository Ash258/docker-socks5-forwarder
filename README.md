# Docker socks5 forwarder

Docker container, that expose simple no authentication proxy and send all requests to upstream SOCK5 proxy.

Since chromium browsers does not support socks5 authentication, the easiest way is to spawn local proxy server and redirect all requests to parent proxy.

```yml
services:
  socks5-forwarder:
    image: ghcr.io/ash258/socks5-forwarder
    ports:
    - "127.0.0.1:1080:1080"
    env:
      UPSTREAM_HOST: us.socks.nordhold.net
      UPSTREAM_PORT: 1080
      UPSTREAM_USER: user_name
      UPSTREAM_PASS: pass
    cap_add:
    - NET_ADMIN
```
