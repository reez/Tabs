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


## License
[MIT](https://choosealicense.com/licenses/mit/)
