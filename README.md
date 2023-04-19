# ipfs-index-provider

Docker container for [IPNI Index Provider](https://github.com/ipni/index-provider) to run as a sidecar with [IPFS nodes backed by Storj datastore](https://github.com/storj/ipfs-go-ds-storj).

## Run With Docker

```
docker run --rm -d \
    --network host \
    -e PROVIDER_SERVER_PORT=3103
    -e PROVIDER_ROUTING_PORT=50617
    -e PROVIDER_IDENTITY_PEER_ID=<peer_id>
    -e PROVIDER_IDENTITY_PRIVATE_KEY=<priv_key>
    -e PROVIDER_DIRECT_ANNOUNCE_URLS='["https://cid.contact/ingest/announce"]'
    -e PROVIDER_KUBO_ID=<peer_id>
    -e PROVIDER_KUBO_ADDRS='["/ip4/<ip4_addr>/tcp/4001","/ip4/<ip4_addr>/udp/4001/quic","/ip6/<ip6_addr>/tcp/4001","/ip6/<ip6_addr>/udp/4001/quic"]'
    storjlabs/ipfs-index-provider:<tag>
```

Docker images are published to https://hub.docker.com/r/storjlabs/ipfs-index-provider.

`PROVIDER_SERVER_PORT` must be set to the port number the index provider will listen for incoming request from IPNI indexers to download available advertisements.

`PROVIDER_ROUTING_PORT` must be set to the port number the index provider will listen for IPFS nodes to advertise their content.

`PROVIDER_IDENTITY_PEER_ID` can be set optionally to preserve the node identity between runs. The current peer ID can be found under `Identity.PeerID` in the config file.

`PROVIDER_IDENTITY_PRIVATE_KEY` must be set if `PROVIDER_IDENTITY_PEER_ID` is set, and the provided private key must match the peer ID. The current private key can be found under `Identity.PrivKey` in the config file.

`PROVIDER_DIRECT_ANNOUNCE_URLS` must be set to the list of ingest HTTP URLs of IPNI indexers to directly announce for new advertisements.

`PROVIDER_KUBO_ID` must be set to the peer ID of the IPFS (Kubo) node which this index provider is providing advertisements for.

`PROVIDER_KUBO_ADDRS` must be set to the list of public addresses of the IPFS (Kubo) node which this index provider is providing advertisements for.
