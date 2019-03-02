[![Build Status](https://travis-ci.org/reez/LightningNode.svg?branch=master)](https://travis-ci.com/reez/LightningNode)
[![GitHub license](https://img.shields.io/github/license/LN-Zap/zap-iOS.svg)](LICENSE)

# Tabs

Tabs is an iOS app for keeping up with your Lightning Node.

## Table of contents
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)

## Installation

Use [Cocoapods](https://cocoapods.org) to install the dependencies.

```bash
pod install
```

## Usage

Use Tabs to connect to your Lightning Node to get the status or your node or create invoices.

Tabs is using [LND](https://github.com/lightningnetwork/lnd) to make [gRPC API requests](https://api.lightning.community/#sendmany) to your node, specifically:

- `/getinfo`
- `/addinvoice`

## Thanks

- [Chaincode Labs](https://github.com/chaincodelabs)
- [Zap iOS](https://github.com/LN-Zap/zap-iOS)
- [LND](https://github.com/lightningnetwork/lnd)
- [Stormotion blog](https://stormotion.io/blog/)
- [Cypher](https://mobile.twitter.com/cypherwordgame)

## License

[MIT](Tabs/LICENSE.md) © Matthew Ramsden

See [LICENSE](Tabs/LICENSE.md) for more information.
