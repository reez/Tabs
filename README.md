[![Build Status](https://travis-ci.org/reez/Tabs.svg?branch=master)](https://travis-ci.org/reez/Tabs)
[![GitHub license](https://img.shields.io/github/license/LN-Zap/zap-iOS.svg)](LICENSE)
[![codecov](https://codecov.io/gh/reez/Tabs/branch/master/graph/badge.svg)](https://codecov.io/gh/reez/Tabs)

# Tabs

<p align='left'>
<a href='https://matthewramsden.com'>
<img src='https://raw.githubusercontent.com/reez/Tabs/master/Docs/iPhoneXS.png' height='450' alt='screenshot' />
</a>
</p>

### [📲 Download on the iOS App Store](https://itunes.apple.com/us/app/tabs-keep-up-with-your-node/id1448527011?ls=1&mt=8)

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

## License

[MIT](Tabs/LICENSE.md) © Matthew Ramsden

See [LICENSE](Tabs/LICENSE.md) for more information.
