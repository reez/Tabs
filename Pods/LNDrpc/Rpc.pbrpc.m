#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "Rpc.pbrpc.h"
#import "Rpc.pbobjc.h"
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriter+Immediate.h>

//#import "google/api/Annotations.pbobjc.h"

@implementation WalletUnlocker

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"lnrpc"
                 serviceName:@"WalletUnlocker"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"lnrpc"
                 serviceName:@"WalletUnlocker"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark GenSeed(GenSeedRequest) returns (GenSeedResponse)

/**
 * *
 * GenSeed is the first method that should be used to instantiate a new lnd
 * instance. This method allows a caller to generate a new aezeed cipher seed
 * given an optional passphrase. If provided, the passphrase will be necessary
 * to decrypt the cipherseed to expose the internal wallet seed.
 * 
 * Once the cipherseed is obtained and verified by the user, the InitWallet
 * method should be used to commit the newly generated seed, and create the
 * wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)genSeedWithRequest:(GenSeedRequest *)request handler:(void(^)(GenSeedResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGenSeedWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * GenSeed is the first method that should be used to instantiate a new lnd
 * instance. This method allows a caller to generate a new aezeed cipher seed
 * given an optional passphrase. If provided, the passphrase will be necessary
 * to decrypt the cipherseed to expose the internal wallet seed.
 * 
 * Once the cipherseed is obtained and verified by the user, the InitWallet
 * method should be used to commit the newly generated seed, and create the
 * wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGenSeedWithRequest:(GenSeedRequest *)request handler:(void(^)(GenSeedResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GenSeed"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GenSeedResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * GenSeed is the first method that should be used to instantiate a new lnd
 * instance. This method allows a caller to generate a new aezeed cipher seed
 * given an optional passphrase. If provided, the passphrase will be necessary
 * to decrypt the cipherseed to expose the internal wallet seed.
 * 
 * Once the cipherseed is obtained and verified by the user, the InitWallet
 * method should be used to commit the newly generated seed, and create the
 * wallet.
 */
- (GRPCUnaryProtoCall *)genSeedWithMessage:(GenSeedRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GenSeed"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GenSeedResponse class]];
}

#pragma mark InitWallet(InitWalletRequest) returns (InitWalletResponse)

/**
 * * 
 * InitWallet is used when lnd is starting up for the first time to fully
 * initialize the daemon and its internal wallet. At the very least a wallet
 * password must be provided. This will be used to encrypt sensitive material
 * on disk.
 * 
 * In the case of a recovery scenario, the user can also specify their aezeed
 * mnemonic and passphrase. If set, then the daemon will use this prior state
 * to initialize its internal wallet.
 * 
 * Alternatively, this can be used along with the GenSeed RPC to obtain a
 * seed, then present it to the user. Once it has been verified by the user,
 * the seed can be fed into this RPC in order to commit the new wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)initWalletWithRequest:(InitWalletRequest *)request handler:(void(^)(InitWalletResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToInitWalletWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * 
 * InitWallet is used when lnd is starting up for the first time to fully
 * initialize the daemon and its internal wallet. At the very least a wallet
 * password must be provided. This will be used to encrypt sensitive material
 * on disk.
 * 
 * In the case of a recovery scenario, the user can also specify their aezeed
 * mnemonic and passphrase. If set, then the daemon will use this prior state
 * to initialize its internal wallet.
 * 
 * Alternatively, this can be used along with the GenSeed RPC to obtain a
 * seed, then present it to the user. Once it has been verified by the user,
 * the seed can be fed into this RPC in order to commit the new wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToInitWalletWithRequest:(InitWalletRequest *)request handler:(void(^)(InitWalletResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"InitWallet"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[InitWalletResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * 
 * InitWallet is used when lnd is starting up for the first time to fully
 * initialize the daemon and its internal wallet. At the very least a wallet
 * password must be provided. This will be used to encrypt sensitive material
 * on disk.
 * 
 * In the case of a recovery scenario, the user can also specify their aezeed
 * mnemonic and passphrase. If set, then the daemon will use this prior state
 * to initialize its internal wallet.
 * 
 * Alternatively, this can be used along with the GenSeed RPC to obtain a
 * seed, then present it to the user. Once it has been verified by the user,
 * the seed can be fed into this RPC in order to commit the new wallet.
 */
//- (GRPCUnaryProtoCall *)initWalletWithMessage:(InitWalletRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
//  return [self RPCToMethod:@"InitWallet"
//                   message:message
//           responseHandler:handler
//               callOptions:callOptions
//             responseClass:[InitWalletResponse class]];
//}

#pragma mark UnlockWallet(UnlockWalletRequest) returns (UnlockWalletResponse)

/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)unlockWalletWithRequest:(UnlockWalletRequest *)request handler:(void(^)(UnlockWalletResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUnlockWalletWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUnlockWalletWithRequest:(UnlockWalletRequest *)request handler:(void(^)(UnlockWalletResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UnlockWallet"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[UnlockWalletResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 */
- (GRPCUnaryProtoCall *)unlockWalletWithMessage:(UnlockWalletRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UnlockWallet"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[UnlockWalletResponse class]];
}

#pragma mark ChangePassword(ChangePasswordRequest) returns (ChangePasswordResponse)

/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)changePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToChangePasswordWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToChangePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ChangePassword"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChangePasswordResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 */
- (GRPCUnaryProtoCall *)changePasswordWithMessage:(ChangePasswordRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ChangePassword"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChangePasswordResponse class]];
}

@end
@implementation Lightning

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"lnrpc"
                 serviceName:@"Lightning"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"lnrpc"
                 serviceName:@"Lightning"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark WalletBalance(WalletBalanceRequest) returns (WalletBalanceResponse)

/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)walletBalanceWithRequest:(WalletBalanceRequest *)request handler:(void(^)(WalletBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToWalletBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToWalletBalanceWithRequest:(WalletBalanceRequest *)request handler:(void(^)(WalletBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"WalletBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[WalletBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet.
 */
- (GRPCUnaryProtoCall *)walletBalanceWithMessage:(WalletBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"WalletBalance"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[WalletBalanceResponse class]];
}

#pragma mark ChannelBalance(ChannelBalanceRequest) returns (ChannelBalanceResponse)

/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)channelBalanceWithRequest:(ChannelBalanceRequest *)request handler:(void(^)(ChannelBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToChannelBalanceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToChannelBalanceWithRequest:(ChannelBalanceRequest *)request handler:(void(^)(ChannelBalanceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ChannelBalance"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelBalanceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 */
- (GRPCUnaryProtoCall *)channelBalanceWithMessage:(ChannelBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ChannelBalance"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelBalanceResponse class]];
}

#pragma mark GetTransactions(GetTransactionsRequest) returns (TransactionDetails)

/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(TransactionDetails *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetTransactionsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(TransactionDetails *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TransactionDetails class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 */
- (GRPCUnaryProtoCall *)getTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetTransactions"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[TransactionDetails class]];
}

#pragma mark EstimateFee(EstimateFeeRequest) returns (EstimateFeeResponse)

/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)estimateFeeWithRequest:(EstimateFeeRequest *)request handler:(void(^)(EstimateFeeResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToEstimateFeeWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToEstimateFeeWithRequest:(EstimateFeeRequest *)request handler:(void(^)(EstimateFeeResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"EstimateFee"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[EstimateFeeResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 */
- (GRPCUnaryProtoCall *)estimateFeeWithMessage:(EstimateFeeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"EstimateFee"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[EstimateFeeResponse class]];
}

#pragma mark SendCoins(SendCoinsRequest) returns (SendCoinsResponse)

/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendCoinsWithRequest:(SendCoinsRequest *)request handler:(void(^)(SendCoinsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSendCoinsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendCoinsWithRequest:(SendCoinsRequest *)request handler:(void(^)(SendCoinsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SendCoins"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SendCoinsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 */
- (GRPCUnaryProtoCall *)sendCoinsWithMessage:(SendCoinsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendCoins"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendCoinsResponse class]];
}

#pragma mark ListUnspent(ListUnspentRequest) returns (ListUnspentResponse)

/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)listUnspentWithRequest:(ListUnspentRequest *)request handler:(void(^)(ListUnspentResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListUnspentWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToListUnspentWithRequest:(ListUnspentRequest *)request handler:(void(^)(ListUnspentResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListUnspent"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListUnspentResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 */
- (GRPCUnaryProtoCall *)listUnspentWithMessage:(ListUnspentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ListUnspent"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ListUnspentResponse class]];
}

#pragma mark SubscribeTransactions(GetTransactionsRequest) returns (stream Transaction)

/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeTransactionsWithRequest:(GetTransactionsRequest *)request eventHandler:(void(^)(BOOL done, Transaction *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSubscribeTransactionsWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeTransactionsWithRequest:(GetTransactionsRequest *)request eventHandler:(void(^)(BOOL done, Transaction *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SubscribeTransactions"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Transaction class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 */
- (GRPCUnaryProtoCall *)subscribeTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeTransactions"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[Transaction class]];
}

#pragma mark SendMany(SendManyRequest) returns (SendManyResponse)

/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendManyWithRequest:(SendManyRequest *)request handler:(void(^)(SendManyResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSendManyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendManyWithRequest:(SendManyRequest *)request handler:(void(^)(SendManyResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SendMany"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SendManyResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 */
- (GRPCUnaryProtoCall *)sendManyWithMessage:(SendManyRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendMany"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendManyResponse class]];
}

#pragma mark NewAddress(NewAddressRequest) returns (NewAddressResponse)

/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)newAddressWithRequest:(NewAddressRequest *)request handler:(void(^)(NewAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToNewAddressWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToNewAddressWithRequest:(NewAddressRequest *)request handler:(void(^)(NewAddressResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"NewAddress"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NewAddressResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 */
- (GRPCUnaryProtoCall *)newAddressWithMessage:(NewAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"NewAddress"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[NewAddressResponse class]];
}

#pragma mark SignMessage(SignMessageRequest) returns (SignMessageResponse)

/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)signMessageWithRequest:(SignMessageRequest *)request handler:(void(^)(SignMessageResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSignMessageWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSignMessageWithRequest:(SignMessageRequest *)request handler:(void(^)(SignMessageResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SignMessage"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SignMessageResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 */
- (GRPCUnaryProtoCall *)signMessageWithMessage:(SignMessageRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SignMessage"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SignMessageResponse class]];
}

#pragma mark VerifyMessage(VerifyMessageRequest) returns (VerifyMessageResponse)

/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)verifyMessageWithRequest:(VerifyMessageRequest *)request handler:(void(^)(VerifyMessageResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyMessageWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToVerifyMessageWithRequest:(VerifyMessageRequest *)request handler:(void(^)(VerifyMessageResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyMessage"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyMessageResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 */
- (GRPCUnaryProtoCall *)verifyMessageWithMessage:(VerifyMessageRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyMessage"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[VerifyMessageResponse class]];
}

#pragma mark ConnectPeer(ConnectPeerRequest) returns (ConnectPeerResponse)

/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)connectPeerWithRequest:(ConnectPeerRequest *)request handler:(void(^)(ConnectPeerResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToConnectPeerWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToConnectPeerWithRequest:(ConnectPeerRequest *)request handler:(void(^)(ConnectPeerResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ConnectPeer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ConnectPeerResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 */
- (GRPCUnaryProtoCall *)connectPeerWithMessage:(ConnectPeerRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ConnectPeer"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ConnectPeerResponse class]];
}

#pragma mark DisconnectPeer(DisconnectPeerRequest) returns (DisconnectPeerResponse)

/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)disconnectPeerWithRequest:(DisconnectPeerRequest *)request handler:(void(^)(DisconnectPeerResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDisconnectPeerWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDisconnectPeerWithRequest:(DisconnectPeerRequest *)request handler:(void(^)(DisconnectPeerResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DisconnectPeer"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DisconnectPeerResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 */
- (GRPCUnaryProtoCall *)disconnectPeerWithMessage:(DisconnectPeerRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DisconnectPeer"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DisconnectPeerResponse class]];
}

#pragma mark ListPeers(ListPeersRequest) returns (ListPeersResponse)

/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)listPeersWithRequest:(ListPeersRequest *)request handler:(void(^)(ListPeersResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListPeersWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToListPeersWithRequest:(ListPeersRequest *)request handler:(void(^)(ListPeersResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListPeers"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListPeersResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 */
- (GRPCUnaryProtoCall *)listPeersWithMessage:(ListPeersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ListPeers"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ListPeersResponse class]];
}

#pragma mark GetInfo(GetInfoRequest) returns (GetInfoResponse)

/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getInfoWithRequest:(GetInfoRequest *)request handler:(void(^)(GetInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetInfoWithRequest:(GetInfoRequest *)request handler:(void(^)(GetInfoResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GetInfoResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 */
- (GRPCUnaryProtoCall *)getInfoWithMessage:(GetInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GetInfoResponse class]];
}

#pragma mark PendingChannels(PendingChannelsRequest) returns (PendingChannelsResponse)

/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)pendingChannelsWithRequest:(PendingChannelsRequest *)request handler:(void(^)(PendingChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToPendingChannelsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToPendingChannelsWithRequest:(PendingChannelsRequest *)request handler:(void(^)(PendingChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"PendingChannels"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PendingChannelsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 */
- (GRPCUnaryProtoCall *)pendingChannelsWithMessage:(PendingChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"PendingChannels"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PendingChannelsResponse class]];
}

#pragma mark ListChannels(ListChannelsRequest) returns (ListChannelsResponse)

/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)listChannelsWithRequest:(ListChannelsRequest *)request handler:(void(^)(ListChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListChannelsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToListChannelsWithRequest:(ListChannelsRequest *)request handler:(void(^)(ListChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListChannels"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListChannelsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 */
- (GRPCUnaryProtoCall *)listChannelsWithMessage:(ListChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ListChannels"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ListChannelsResponse class]];
}

#pragma mark SubscribeChannelEvents(ChannelEventSubscription) returns (stream ChannelEventUpdate)

/**
 * *
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeChannelEventsWithRequest:(ChannelEventSubscription *)request eventHandler:(void(^)(BOOL done, ChannelEventUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSubscribeChannelEventsWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeChannelEventsWithRequest:(ChannelEventSubscription *)request eventHandler:(void(^)(BOOL done, ChannelEventUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SubscribeChannelEvents"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelEventUpdate class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 */
- (GRPCUnaryProtoCall *)subscribeChannelEventsWithMessage:(ChannelEventSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeChannelEvents"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelEventUpdate class]];
}

#pragma mark ClosedChannels(ClosedChannelsRequest) returns (ClosedChannelsResponse)

/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that
 * this node was a participant in.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)closedChannelsWithRequest:(ClosedChannelsRequest *)request handler:(void(^)(ClosedChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToClosedChannelsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that
 * this node was a participant in.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToClosedChannelsWithRequest:(ClosedChannelsRequest *)request handler:(void(^)(ClosedChannelsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ClosedChannels"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ClosedChannelsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that
 * this node was a participant in.
 */
- (GRPCUnaryProtoCall *)closedChannelsWithMessage:(ClosedChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ClosedChannels"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ClosedChannelsResponse class]];
}

#pragma mark OpenChannelSync(OpenChannelRequest) returns (ChannelPoint)

/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)openChannelSyncWithRequest:(OpenChannelRequest *)request handler:(void(^)(ChannelPoint *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToOpenChannelSyncWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToOpenChannelSyncWithRequest:(OpenChannelRequest *)request handler:(void(^)(ChannelPoint *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"OpenChannelSync"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelPoint class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 */
- (GRPCUnaryProtoCall *)openChannelSyncWithMessage:(OpenChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"OpenChannelSync"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelPoint class]];
}

#pragma mark OpenChannel(OpenChannelRequest) returns (stream OpenStatusUpdate)

/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)openChannelWithRequest:(OpenChannelRequest *)request eventHandler:(void(^)(BOOL done, OpenStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToOpenChannelWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToOpenChannelWithRequest:(OpenChannelRequest *)request eventHandler:(void(^)(BOOL done, OpenStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"OpenChannel"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[OpenStatusUpdate class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 */
- (GRPCUnaryProtoCall *)openChannelWithMessage:(OpenChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"OpenChannel"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[OpenStatusUpdate class]];
}

#pragma mark ChannelAcceptor(stream ChannelAcceptResponse) returns (stream ChannelAcceptRequest)

/**
 * *
 * ChannelAcceptor dispatches a bi-directional streaming RPC in which
 * OpenChannel requests are sent to the client and the client responds with
 * a boolean that tells LND whether or not to accept the channel. This allows
 * node operators to specify their own criteria for accepting inbound channels
 * through a single persistent connection.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)channelAcceptorWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, ChannelAcceptRequest *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToChannelAcceptorWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * ChannelAcceptor dispatches a bi-directional streaming RPC in which
 * OpenChannel requests are sent to the client and the client responds with
 * a boolean that tells LND whether or not to accept the channel. This allows
 * node operators to specify their own criteria for accepting inbound channels
 * through a single persistent connection.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToChannelAcceptorWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, ChannelAcceptRequest *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"ChannelAcceptor"
            requestsWriter:requestWriter
             responseClass:[ChannelAcceptRequest class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * ChannelAcceptor dispatches a bi-directional streaming RPC in which
 * OpenChannel requests are sent to the client and the client responds with
 * a boolean that tells LND whether or not to accept the channel. This allows
 * node operators to specify their own criteria for accepting inbound channels
 * through a single persistent connection.
 */
- (GRPCStreamingProtoCall *)channelAcceptorWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ChannelAcceptor"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelAcceptRequest class]];
}

#pragma mark CloseChannel(CloseChannelRequest) returns (stream CloseStatusUpdate)

/**
 * * lncli: `closechannel`
 * CloseChannel attempts to close an active channel identified by its channel
 * outpoint (ChannelPoint). The actions of this method can additionally be
 * augmented to attempt a force close after a timeout period in the case of an
 * inactive peer. If a non-force close (cooperative closure) is requested,
 * then the user can specify either a target number of blocks until the
 * closure transaction is confirmed, or a manual fee rate. If neither are
 * specified, then a default lax, block confirmation target is used.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)closeChannelWithRequest:(CloseChannelRequest *)request eventHandler:(void(^)(BOOL done, CloseStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToCloseChannelWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `closechannel`
 * CloseChannel attempts to close an active channel identified by its channel
 * outpoint (ChannelPoint). The actions of this method can additionally be
 * augmented to attempt a force close after a timeout period in the case of an
 * inactive peer. If a non-force close (cooperative closure) is requested,
 * then the user can specify either a target number of blocks until the
 * closure transaction is confirmed, or a manual fee rate. If neither are
 * specified, then a default lax, block confirmation target is used.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToCloseChannelWithRequest:(CloseChannelRequest *)request eventHandler:(void(^)(BOOL done, CloseStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"CloseChannel"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CloseStatusUpdate class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * * lncli: `closechannel`
 * CloseChannel attempts to close an active channel identified by its channel
 * outpoint (ChannelPoint). The actions of this method can additionally be
 * augmented to attempt a force close after a timeout period in the case of an
 * inactive peer. If a non-force close (cooperative closure) is requested,
 * then the user can specify either a target number of blocks until the
 * closure transaction is confirmed, or a manual fee rate. If neither are
 * specified, then a default lax, block confirmation target is used.
 */
- (GRPCUnaryProtoCall *)closeChannelWithMessage:(CloseChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"CloseChannel"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[CloseStatusUpdate class]];
}

#pragma mark AbandonChannel(AbandonChannelRequest) returns (AbandonChannelResponse)

/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)abandonChannelWithRequest:(AbandonChannelRequest *)request handler:(void(^)(AbandonChannelResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAbandonChannelWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAbandonChannelWithRequest:(AbandonChannelRequest *)request handler:(void(^)(AbandonChannelResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AbandonChannel"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AbandonChannelResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 */
- (GRPCUnaryProtoCall *)abandonChannelWithMessage:(AbandonChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AbandonChannel"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AbandonChannelResponse class]];
}

#pragma mark SendPayment(stream SendRequest) returns (stream SendResponse)

/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendPaymentWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSendPaymentWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendPaymentWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SendPayment"
            requestsWriter:requestWriter
             responseClass:[SendResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 */
- (GRPCStreamingProtoCall *)sendPaymentWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendPayment"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendResponse class]];
}

#pragma mark SendPaymentSync(SendRequest) returns (SendResponse)

/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendPaymentSyncWithRequest:(SendRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSendPaymentSyncWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendPaymentSyncWithRequest:(SendRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SendPaymentSync"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SendResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 */
- (GRPCUnaryProtoCall *)sendPaymentSyncWithMessage:(SendRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendPaymentSync"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendResponse class]];
}

#pragma mark SendToRoute(stream SendToRouteRequest) returns (stream SendResponse)

/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendToRouteWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSendToRouteWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendToRouteWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SendToRoute"
            requestsWriter:requestWriter
             responseClass:[SendResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 */
- (GRPCStreamingProtoCall *)sendToRouteWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendToRoute"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendResponse class]];
}

#pragma mark SendToRouteSync(SendToRouteRequest) returns (SendResponse)

/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)sendToRouteSyncWithRequest:(SendToRouteRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToSendToRouteSyncWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSendToRouteSyncWithRequest:(SendToRouteRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"SendToRouteSync"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[SendResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 */
- (GRPCUnaryProtoCall *)sendToRouteSyncWithMessage:(SendToRouteRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SendToRouteSync"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[SendResponse class]];
}

#pragma mark AddInvoice(Invoice) returns (AddInvoiceResponse)

/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)addInvoiceWithRequest:(Invoice *)request handler:(void(^)(AddInvoiceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToAddInvoiceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToAddInvoiceWithRequest:(Invoice *)request handler:(void(^)(AddInvoiceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"AddInvoice"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[AddInvoiceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 */
- (GRPCUnaryProtoCall *)addInvoiceWithMessage:(Invoice *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"AddInvoice"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[AddInvoiceResponse class]];
}

#pragma mark ListInvoices(ListInvoiceRequest) returns (ListInvoiceResponse)

/**
 * * lncli: `listinvoices`
 * ListInvoices returns a list of all the invoices currently stored within the
 * database. Any active debug invoices are ignored. It has full support for
 * paginated responses, allowing users to query for specific invoices through
 * their add_index. This can be done by using either the first_index_offset or
 * last_index_offset fields included in the response as the index_offset of the
 * next request. By default, the first 100 invoices created will be returned.
 * Backwards pagination is also supported through the Reversed flag.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)listInvoicesWithRequest:(ListInvoiceRequest *)request handler:(void(^)(ListInvoiceResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListInvoicesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listinvoices`
 * ListInvoices returns a list of all the invoices currently stored within the
 * database. Any active debug invoices are ignored. It has full support for
 * paginated responses, allowing users to query for specific invoices through
 * their add_index. This can be done by using either the first_index_offset or
 * last_index_offset fields included in the response as the index_offset of the
 * next request. By default, the first 100 invoices created will be returned.
 * Backwards pagination is also supported through the Reversed flag.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToListInvoicesWithRequest:(ListInvoiceRequest *)request handler:(void(^)(ListInvoiceResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListInvoices"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListInvoiceResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listinvoices`
 * ListInvoices returns a list of all the invoices currently stored within the
 * database. Any active debug invoices are ignored. It has full support for
 * paginated responses, allowing users to query for specific invoices through
 * their add_index. This can be done by using either the first_index_offset or
 * last_index_offset fields included in the response as the index_offset of the
 * next request. By default, the first 100 invoices created will be returned.
 * Backwards pagination is also supported through the Reversed flag.
 */
- (GRPCUnaryProtoCall *)listInvoicesWithMessage:(ListInvoiceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ListInvoices"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ListInvoiceResponse class]];
}

#pragma mark LookupInvoice(PaymentHash) returns (Invoice)

/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)lookupInvoiceWithRequest:(PaymentHash *)request handler:(void(^)(Invoice *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLookupInvoiceWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToLookupInvoiceWithRequest:(PaymentHash *)request handler:(void(^)(Invoice *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"LookupInvoice"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Invoice class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 */
- (GRPCUnaryProtoCall *)lookupInvoiceWithMessage:(PaymentHash *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"LookupInvoice"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[Invoice class]];
}

#pragma mark SubscribeInvoices(InvoiceSubscription) returns (stream Invoice)

/**
 * *
 * SubscribeInvoices returns a uni-directional stream (server -> client) for
 * notifying the client of newly added/settled invoices. The caller can
 * optionally specify the add_index and/or the settle_index. If the add_index
 * is specified, then we'll first start by sending add invoice events for all
 * invoices with an add_index greater than the specified value.  If the
 * settle_index is specified, the next, we'll send out all settle events for
 * invoices with a settle_index greater than the specified value.  One or both
 * of these fields can be set. If no fields are set, then we'll only send out
 * the latest add/settle events.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeInvoicesWithRequest:(InvoiceSubscription *)request eventHandler:(void(^)(BOOL done, Invoice *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSubscribeInvoicesWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SubscribeInvoices returns a uni-directional stream (server -> client) for
 * notifying the client of newly added/settled invoices. The caller can
 * optionally specify the add_index and/or the settle_index. If the add_index
 * is specified, then we'll first start by sending add invoice events for all
 * invoices with an add_index greater than the specified value.  If the
 * settle_index is specified, the next, we'll send out all settle events for
 * invoices with a settle_index greater than the specified value.  One or both
 * of these fields can be set. If no fields are set, then we'll only send out
 * the latest add/settle events.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeInvoicesWithRequest:(InvoiceSubscription *)request eventHandler:(void(^)(BOOL done, Invoice *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SubscribeInvoices"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[Invoice class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * SubscribeInvoices returns a uni-directional stream (server -> client) for
 * notifying the client of newly added/settled invoices. The caller can
 * optionally specify the add_index and/or the settle_index. If the add_index
 * is specified, then we'll first start by sending add invoice events for all
 * invoices with an add_index greater than the specified value.  If the
 * settle_index is specified, the next, we'll send out all settle events for
 * invoices with a settle_index greater than the specified value.  One or both
 * of these fields can be set. If no fields are set, then we'll only send out
 * the latest add/settle events.
 */
- (GRPCUnaryProtoCall *)subscribeInvoicesWithMessage:(InvoiceSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeInvoices"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[Invoice class]];
}

#pragma mark DecodePayReq(PayReqString) returns (PayReq)

/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)decodePayReqWithRequest:(PayReqString *)request handler:(void(^)(PayReq *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDecodePayReqWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDecodePayReqWithRequest:(PayReqString *)request handler:(void(^)(PayReq *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DecodePayReq"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PayReq class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 */
- (GRPCUnaryProtoCall *)decodePayReqWithMessage:(PayReqString *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DecodePayReq"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PayReq class]];
}

#pragma mark ListPayments(ListPaymentsRequest) returns (ListPaymentsResponse)

/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)listPaymentsWithRequest:(ListPaymentsRequest *)request handler:(void(^)(ListPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToListPaymentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToListPaymentsWithRequest:(ListPaymentsRequest *)request handler:(void(^)(ListPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ListPayments"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ListPaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 */
- (GRPCUnaryProtoCall *)listPaymentsWithMessage:(ListPaymentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ListPayments"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ListPaymentsResponse class]];
}

#pragma mark DeleteAllPayments(DeleteAllPaymentsRequest) returns (DeleteAllPaymentsResponse)

/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)deleteAllPaymentsWithRequest:(DeleteAllPaymentsRequest *)request handler:(void(^)(DeleteAllPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDeleteAllPaymentsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDeleteAllPaymentsWithRequest:(DeleteAllPaymentsRequest *)request handler:(void(^)(DeleteAllPaymentsResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DeleteAllPayments"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DeleteAllPaymentsResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 */
- (GRPCUnaryProtoCall *)deleteAllPaymentsWithMessage:(DeleteAllPaymentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DeleteAllPayments"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DeleteAllPaymentsResponse class]];
}

#pragma mark DescribeGraph(ChannelGraphRequest) returns (ChannelGraph)

/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)describeGraphWithRequest:(ChannelGraphRequest *)request handler:(void(^)(ChannelGraph *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDescribeGraphWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDescribeGraphWithRequest:(ChannelGraphRequest *)request handler:(void(^)(ChannelGraph *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DescribeGraph"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelGraph class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 */
- (GRPCUnaryProtoCall *)describeGraphWithMessage:(ChannelGraphRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DescribeGraph"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelGraph class]];
}

#pragma mark GetChanInfo(ChanInfoRequest) returns (ChannelEdge)

/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getChanInfoWithRequest:(ChanInfoRequest *)request handler:(void(^)(ChannelEdge *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetChanInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetChanInfoWithRequest:(ChanInfoRequest *)request handler:(void(^)(ChannelEdge *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetChanInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelEdge class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 */
- (GRPCUnaryProtoCall *)getChanInfoWithMessage:(ChanInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetChanInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelEdge class]];
}

#pragma mark GetNodeInfo(NodeInfoRequest) returns (NodeInfo)

/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getNodeInfoWithRequest:(NodeInfoRequest *)request handler:(void(^)(NodeInfo *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNodeInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetNodeInfoWithRequest:(NodeInfoRequest *)request handler:(void(^)(NodeInfo *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNodeInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NodeInfo class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 */
- (GRPCUnaryProtoCall *)getNodeInfoWithMessage:(NodeInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNodeInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[NodeInfo class]];
}

#pragma mark QueryRoutes(QueryRoutesRequest) returns (QueryRoutesResponse)

/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The returned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)queryRoutesWithRequest:(QueryRoutesRequest *)request handler:(void(^)(QueryRoutesResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToQueryRoutesWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The returned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToQueryRoutesWithRequest:(QueryRoutesRequest *)request handler:(void(^)(QueryRoutesResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"QueryRoutes"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[QueryRoutesResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The returned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 */
- (GRPCUnaryProtoCall *)queryRoutesWithMessage:(QueryRoutesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"QueryRoutes"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[QueryRoutesResponse class]];
}

#pragma mark GetNetworkInfo(NetworkInfoRequest) returns (NetworkInfo)

/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)getNetworkInfoWithRequest:(NetworkInfoRequest *)request handler:(void(^)(NetworkInfo *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToGetNetworkInfoWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToGetNetworkInfoWithRequest:(NetworkInfoRequest *)request handler:(void(^)(NetworkInfo *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"GetNetworkInfo"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[NetworkInfo class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 */
- (GRPCUnaryProtoCall *)getNetworkInfoWithMessage:(NetworkInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"GetNetworkInfo"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[NetworkInfo class]];
}

#pragma mark StopDaemon(StopRequest) returns (StopResponse)

/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)stopDaemonWithRequest:(StopRequest *)request handler:(void(^)(StopResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToStopDaemonWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToStopDaemonWithRequest:(StopRequest *)request handler:(void(^)(StopResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"StopDaemon"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[StopResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 */
- (GRPCUnaryProtoCall *)stopDaemonWithMessage:(StopRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"StopDaemon"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[StopResponse class]];
}

#pragma mark SubscribeChannelGraph(GraphTopologySubscription) returns (stream GraphTopologyUpdate)

/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeChannelGraphWithRequest:(GraphTopologySubscription *)request eventHandler:(void(^)(BOOL done, GraphTopologyUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSubscribeChannelGraphWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeChannelGraphWithRequest:(GraphTopologySubscription *)request eventHandler:(void(^)(BOOL done, GraphTopologyUpdate *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SubscribeChannelGraph"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[GraphTopologyUpdate class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 */
- (GRPCUnaryProtoCall *)subscribeChannelGraphWithMessage:(GraphTopologySubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeChannelGraph"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[GraphTopologyUpdate class]];
}

#pragma mark DebugLevel(DebugLevelRequest) returns (DebugLevelResponse)

/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)debugLevelWithRequest:(DebugLevelRequest *)request handler:(void(^)(DebugLevelResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToDebugLevelWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToDebugLevelWithRequest:(DebugLevelRequest *)request handler:(void(^)(DebugLevelResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"DebugLevel"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[DebugLevelResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 */
- (GRPCUnaryProtoCall *)debugLevelWithMessage:(DebugLevelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"DebugLevel"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[DebugLevelResponse class]];
}

#pragma mark FeeReport(FeeReportRequest) returns (FeeReportResponse)

/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)feeReportWithRequest:(FeeReportRequest *)request handler:(void(^)(FeeReportResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToFeeReportWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToFeeReportWithRequest:(FeeReportRequest *)request handler:(void(^)(FeeReportResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"FeeReport"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[FeeReportResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 */
- (GRPCUnaryProtoCall *)feeReportWithMessage:(FeeReportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"FeeReport"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[FeeReportResponse class]];
}

#pragma mark UpdateChannelPolicy(PolicyUpdateRequest) returns (PolicyUpdateResponse)

/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)updateChannelPolicyWithRequest:(PolicyUpdateRequest *)request handler:(void(^)(PolicyUpdateResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToUpdateChannelPolicyWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToUpdateChannelPolicyWithRequest:(PolicyUpdateRequest *)request handler:(void(^)(PolicyUpdateResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"UpdateChannelPolicy"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[PolicyUpdateResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 */
- (GRPCUnaryProtoCall *)updateChannelPolicyWithMessage:(PolicyUpdateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"UpdateChannelPolicy"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[PolicyUpdateResponse class]];
}

#pragma mark ForwardingHistory(ForwardingHistoryRequest) returns (ForwardingHistoryResponse)

/**
 * * lncli: `fwdinghistory`
 * ForwardingHistory allows the caller to query the htlcswitch for a record of
 * all HTLCs forwarded within the target time range, and integer offset
 * within that time range. If no time-range is specified, then the first chunk
 * of the past 24 hrs of forwarding history are returned.
 * 
 * A list of forwarding events are returned. The size of each forwarding event
 * is 40 bytes, and the max message size able to be returned in gRPC is 4 MiB.
 * As a result each message can only contain 50k entries.  Each response has
 * the index offset of the last entry. The index offset can be provided to the
 * request to allow the caller to skip a series of records.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)forwardingHistoryWithRequest:(ForwardingHistoryRequest *)request handler:(void(^)(ForwardingHistoryResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToForwardingHistoryWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `fwdinghistory`
 * ForwardingHistory allows the caller to query the htlcswitch for a record of
 * all HTLCs forwarded within the target time range, and integer offset
 * within that time range. If no time-range is specified, then the first chunk
 * of the past 24 hrs of forwarding history are returned.
 * 
 * A list of forwarding events are returned. The size of each forwarding event
 * is 40 bytes, and the max message size able to be returned in gRPC is 4 MiB.
 * As a result each message can only contain 50k entries.  Each response has
 * the index offset of the last entry. The index offset can be provided to the
 * request to allow the caller to skip a series of records.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToForwardingHistoryWithRequest:(ForwardingHistoryRequest *)request handler:(void(^)(ForwardingHistoryResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ForwardingHistory"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ForwardingHistoryResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `fwdinghistory`
 * ForwardingHistory allows the caller to query the htlcswitch for a record of
 * all HTLCs forwarded within the target time range, and integer offset
 * within that time range. If no time-range is specified, then the first chunk
 * of the past 24 hrs of forwarding history are returned.
 * 
 * A list of forwarding events are returned. The size of each forwarding event
 * is 40 bytes, and the max message size able to be returned in gRPC is 4 MiB.
 * As a result each message can only contain 50k entries.  Each response has
 * the index offset of the last entry. The index offset can be provided to the
 * request to allow the caller to skip a series of records.
 */
- (GRPCUnaryProtoCall *)forwardingHistoryWithMessage:(ForwardingHistoryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ForwardingHistory"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ForwardingHistoryResponse class]];
}

#pragma mark ExportChannelBackup(ExportChannelBackupRequest) returns (ChannelBackup)

/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)exportChannelBackupWithRequest:(ExportChannelBackupRequest *)request handler:(void(^)(ChannelBackup *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExportChannelBackupWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToExportChannelBackupWithRequest:(ExportChannelBackupRequest *)request handler:(void(^)(ChannelBackup *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExportChannelBackup"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChannelBackup class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 */
- (GRPCUnaryProtoCall *)exportChannelBackupWithMessage:(ExportChannelBackupRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ExportChannelBackup"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChannelBackup class]];
}

#pragma mark ExportAllChannelBackups(ChanBackupExportRequest) returns (ChanBackupSnapshot)

/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)exportAllChannelBackupsWithRequest:(ChanBackupExportRequest *)request handler:(void(^)(ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToExportAllChannelBackupsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToExportAllChannelBackupsWithRequest:(ChanBackupExportRequest *)request handler:(void(^)(ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ExportAllChannelBackups"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChanBackupSnapshot class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 */
- (GRPCUnaryProtoCall *)exportAllChannelBackupsWithMessage:(ChanBackupExportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"ExportAllChannelBackups"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChanBackupSnapshot class]];
}

#pragma mark VerifyChanBackup(ChanBackupSnapshot) returns (VerifyChanBackupResponse)

/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)verifyChanBackupWithRequest:(ChanBackupSnapshot *)request handler:(void(^)(VerifyChanBackupResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToVerifyChanBackupWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToVerifyChanBackupWithRequest:(ChanBackupSnapshot *)request handler:(void(^)(VerifyChanBackupResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"VerifyChanBackup"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[VerifyChanBackupResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 */
- (GRPCUnaryProtoCall *)verifyChanBackupWithMessage:(ChanBackupSnapshot *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"VerifyChanBackup"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[VerifyChanBackupResponse class]];
}

#pragma mark RestoreChannelBackups(RestoreChanBackupRequest) returns (RestoreBackupResponse)

/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)restoreChannelBackupsWithRequest:(RestoreChanBackupRequest *)request handler:(void(^)(RestoreBackupResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRestoreChannelBackupsWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToRestoreChannelBackupsWithRequest:(RestoreChanBackupRequest *)request handler:(void(^)(RestoreBackupResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RestoreChannelBackups"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RestoreBackupResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 */
- (GRPCUnaryProtoCall *)restoreChannelBackupsWithMessage:(RestoreChanBackupRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"RestoreChannelBackups"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[RestoreBackupResponse class]];
}

#pragma mark SubscribeChannelBackups(ChannelBackupSubscription) returns (stream ChanBackupSnapshot)

/**
 * *
 * SubscribeChannelBackups allows a client to sub-subscribe to the most up to
 * date information concerning the state of all channel backups. Each time a
 * new channel is added, we return the new set of channels, along with a
 * multi-chan backup containing the backup info for all channels. Each time a
 * channel is closed, we send a new update, which contains new new chan back
 * ups, but the updated set of encrypted multi-chan backups with the closed
 * channel(s) removed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)subscribeChannelBackupsWithRequest:(ChannelBackupSubscription *)request eventHandler:(void(^)(BOOL done, ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSubscribeChannelBackupsWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * *
 * SubscribeChannelBackups allows a client to sub-subscribe to the most up to
 * date information concerning the state of all channel backups. Each time a
 * new channel is added, we return the new set of channels, along with a
 * multi-chan backup containing the backup info for all channels. Each time a
 * channel is closed, we send a new update, which contains new new chan back
 * ups, but the updated set of encrypted multi-chan backups with the closed
 * channel(s) removed.
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCToSubscribeChannelBackupsWithRequest:(ChannelBackupSubscription *)request eventHandler:(void(^)(BOOL done, ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SubscribeChannelBackups"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChanBackupSnapshot class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * *
 * SubscribeChannelBackups allows a client to sub-subscribe to the most up to
 * date information concerning the state of all channel backups. Each time a
 * new channel is added, we return the new set of channels, along with a
 * multi-chan backup containing the backup info for all channels. Each time a
 * channel is closed, we send a new update, which contains new new chan back
 * ups, but the updated set of encrypted multi-chan backups with the closed
 * channel(s) removed.
 */
- (GRPCUnaryProtoCall *)subscribeChannelBackupsWithMessage:(ChannelBackupSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"SubscribeChannelBackups"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[ChanBackupSnapshot class]];
}

@end
#endif
