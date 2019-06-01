#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "Rpc.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class AbandonChannelRequest;
@class AbandonChannelResponse;
@class AddInvoiceResponse;
@class ChanBackupExportRequest;
@class ChanBackupSnapshot;
@class ChanInfoRequest;
@class ChangePasswordRequest;
@class ChangePasswordResponse;
@class ChannelBackup;
@class ChannelBackupSubscription;
@class ChannelBalanceRequest;
@class ChannelBalanceResponse;
@class ChannelEdge;
@class ChannelEventSubscription;
@class ChannelEventUpdate;
@class ChannelGraph;
@class ChannelGraphRequest;
@class ChannelPoint;
@class CloseChannelRequest;
@class CloseStatusUpdate;
@class ClosedChannelsRequest;
@class ClosedChannelsResponse;
@class ConnectPeerRequest;
@class ConnectPeerResponse;
@class DebugLevelRequest;
@class DebugLevelResponse;
@class DeleteAllPaymentsRequest;
@class DeleteAllPaymentsResponse;
@class DisconnectPeerRequest;
@class DisconnectPeerResponse;
@class EstimateFeeRequest;
@class EstimateFeeResponse;
@class ExportChannelBackupRequest;
@class FeeReportRequest;
@class FeeReportResponse;
@class ForwardingHistoryRequest;
@class ForwardingHistoryResponse;
@class GenSeedRequest;
@class GenSeedResponse;
@class GetInfoRequest;
@class GetInfoResponse;
@class GetTransactionsRequest;
@class GraphTopologySubscription;
@class GraphTopologyUpdate;
@class InitWalletRequest;
@class InitWalletResponse;
@class Invoice;
@class InvoiceSubscription;
@class ListChannelsRequest;
@class ListChannelsResponse;
@class ListInvoiceRequest;
@class ListInvoiceResponse;
@class ListPaymentsRequest;
@class ListPaymentsResponse;
@class ListPeersRequest;
@class ListPeersResponse;
@class ListUnspentRequest;
@class ListUnspentResponse;
@class NetworkInfo;
@class NetworkInfoRequest;
@class NewAddressRequest;
@class NewAddressResponse;
@class NodeInfo;
@class NodeInfoRequest;
@class OpenChannelRequest;
@class OpenStatusUpdate;
@class PayReq;
@class PayReqString;
@class PaymentHash;
@class PendingChannelsRequest;
@class PendingChannelsResponse;
@class PolicyUpdateRequest;
@class PolicyUpdateResponse;
@class QueryRoutesRequest;
@class QueryRoutesResponse;
@class RestoreBackupResponse;
@class RestoreChanBackupRequest;
@class SendCoinsRequest;
@class SendCoinsResponse;
@class SendManyRequest;
@class SendManyResponse;
@class SendRequest;
@class SendResponse;
@class SendToRouteRequest;
@class SignMessageRequest;
@class SignMessageResponse;
@class StopRequest;
@class StopResponse;
@class Transaction;
@class TransactionDetails;
@class UnlockWalletRequest;
@class UnlockWalletResponse;
@class VerifyChanBackupResponse;
@class VerifyMessageRequest;
@class VerifyMessageResponse;
@class WalletBalanceRequest;
@class WalletBalanceResponse;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
  #import "google/api/Annotations.pbobjc.h"
#endif

@class GRPCProtoCall;
@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;


NS_ASSUME_NONNULL_BEGIN

@protocol WalletUnlocker2 <NSObject>

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
 */
- (GRPCUnaryProtoCall *)genSeedWithMessage:(GenSeedRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)initWalletWithMessage:(InitWalletRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UnlockWallet(UnlockWalletRequest) returns (UnlockWalletResponse)

/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 */
- (GRPCUnaryProtoCall *)unlockWalletWithMessage:(UnlockWalletRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ChangePassword(ChangePasswordRequest) returns (ChangePasswordResponse)

/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 */
- (GRPCUnaryProtoCall *)changePasswordWithMessage:(ChangePasswordRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

@protocol Lightning2 <NSObject>

#pragma mark WalletBalance(WalletBalanceRequest) returns (WalletBalanceResponse)

/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet. 
 */
- (GRPCUnaryProtoCall *)walletBalanceWithMessage:(WalletBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ChannelBalance(ChannelBalanceRequest) returns (ChannelBalanceResponse)

/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 */
- (GRPCUnaryProtoCall *)channelBalanceWithMessage:(ChannelBalanceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetTransactions(GetTransactionsRequest) returns (TransactionDetails)

/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 */
- (GRPCUnaryProtoCall *)getTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark EstimateFee(EstimateFeeRequest) returns (EstimateFeeResponse)

/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 */
- (GRPCUnaryProtoCall *)estimateFeeWithMessage:(EstimateFeeRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendCoins(SendCoinsRequest) returns (SendCoinsResponse)

/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 */
- (GRPCUnaryProtoCall *)sendCoinsWithMessage:(SendCoinsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ListUnspent(ListUnspentRequest) returns (ListUnspentResponse)

/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 */
- (GRPCUnaryProtoCall *)listUnspentWithMessage:(ListUnspentRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SubscribeTransactions(GetTransactionsRequest) returns (stream Transaction)

/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 */
- (GRPCUnaryProtoCall *)subscribeTransactionsWithMessage:(GetTransactionsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendMany(SendManyRequest) returns (SendManyResponse)

/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 */
- (GRPCUnaryProtoCall *)sendManyWithMessage:(SendManyRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark NewAddress(NewAddressRequest) returns (NewAddressResponse)

/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 */
- (GRPCUnaryProtoCall *)newAddressWithMessage:(NewAddressRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SignMessage(SignMessageRequest) returns (SignMessageResponse)

/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 */
- (GRPCUnaryProtoCall *)signMessageWithMessage:(SignMessageRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark VerifyMessage(VerifyMessageRequest) returns (VerifyMessageResponse)

/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 */
- (GRPCUnaryProtoCall *)verifyMessageWithMessage:(VerifyMessageRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ConnectPeer(ConnectPeerRequest) returns (ConnectPeerResponse)

/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 */
- (GRPCUnaryProtoCall *)connectPeerWithMessage:(ConnectPeerRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DisconnectPeer(DisconnectPeerRequest) returns (DisconnectPeerResponse)

/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 */
- (GRPCUnaryProtoCall *)disconnectPeerWithMessage:(DisconnectPeerRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ListPeers(ListPeersRequest) returns (ListPeersResponse)

/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 */
- (GRPCUnaryProtoCall *)listPeersWithMessage:(ListPeersRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetInfo(GetInfoRequest) returns (GetInfoResponse)

/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 */
- (GRPCUnaryProtoCall *)getInfoWithMessage:(GetInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark PendingChannels(PendingChannelsRequest) returns (PendingChannelsResponse)

/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 */
- (GRPCUnaryProtoCall *)pendingChannelsWithMessage:(PendingChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ListChannels(ListChannelsRequest) returns (ListChannelsResponse)

/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 */
- (GRPCUnaryProtoCall *)listChannelsWithMessage:(ListChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SubscribeChannelEvents(ChannelEventSubscription) returns (stream ChannelEventUpdate)

/**
 * * lncli: `subscribechannelevents`
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 */
- (GRPCUnaryProtoCall *)subscribeChannelEventsWithMessage:(ChannelEventSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ClosedChannels(ClosedChannelsRequest) returns (ClosedChannelsResponse)

/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that 
 * this node was a participant in.
 */
- (GRPCUnaryProtoCall *)closedChannelsWithMessage:(ClosedChannelsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark OpenChannelSync(OpenChannelRequest) returns (ChannelPoint)

/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 */
- (GRPCUnaryProtoCall *)openChannelSyncWithMessage:(OpenChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark OpenChannel(OpenChannelRequest) returns (stream OpenStatusUpdate)

/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 */
- (GRPCUnaryProtoCall *)openChannelWithMessage:(OpenChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)closeChannelWithMessage:(CloseChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AbandonChannel(AbandonChannelRequest) returns (AbandonChannelResponse)

/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 */
- (GRPCUnaryProtoCall *)abandonChannelWithMessage:(AbandonChannelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendPayment(stream SendRequest) returns (stream SendResponse)

/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 */
- (GRPCStreamingProtoCall *)sendPaymentWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendPaymentSync(SendRequest) returns (SendResponse)

/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 */
- (GRPCUnaryProtoCall *)sendPaymentSyncWithMessage:(SendRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendToRoute(stream SendToRouteRequest) returns (stream SendResponse)

/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 */
- (GRPCStreamingProtoCall *)sendToRouteWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SendToRouteSync(SendToRouteRequest) returns (SendResponse)

/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 */
- (GRPCUnaryProtoCall *)sendToRouteSyncWithMessage:(SendToRouteRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark AddInvoice(Invoice) returns (AddInvoiceResponse)

/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 */
- (GRPCUnaryProtoCall *)addInvoiceWithMessage:(Invoice *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)listInvoicesWithMessage:(ListInvoiceRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark LookupInvoice(PaymentHash) returns (Invoice)

/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 */
- (GRPCUnaryProtoCall *)lookupInvoiceWithMessage:(PaymentHash *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)subscribeInvoicesWithMessage:(InvoiceSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DecodePayReq(PayReqString) returns (PayReq)

/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 */
- (GRPCUnaryProtoCall *)decodePayReqWithMessage:(PayReqString *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ListPayments(ListPaymentsRequest) returns (ListPaymentsResponse)

/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 */
- (GRPCUnaryProtoCall *)listPaymentsWithMessage:(ListPaymentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DeleteAllPayments(DeleteAllPaymentsRequest) returns (DeleteAllPaymentsResponse)

/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 */
- (GRPCUnaryProtoCall *)deleteAllPaymentsWithMessage:(DeleteAllPaymentsRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DescribeGraph(ChannelGraphRequest) returns (ChannelGraph)

/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 */
- (GRPCUnaryProtoCall *)describeGraphWithMessage:(ChannelGraphRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetChanInfo(ChanInfoRequest) returns (ChannelEdge)

/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 */
- (GRPCUnaryProtoCall *)getChanInfoWithMessage:(ChanInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNodeInfo(NodeInfoRequest) returns (NodeInfo)

/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 */
- (GRPCUnaryProtoCall *)getNodeInfoWithMessage:(NodeInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark QueryRoutes(QueryRoutesRequest) returns (QueryRoutesResponse)

/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The retuned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 */
- (GRPCUnaryProtoCall *)queryRoutesWithMessage:(QueryRoutesRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark GetNetworkInfo(NetworkInfoRequest) returns (NetworkInfo)

/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 */
- (GRPCUnaryProtoCall *)getNetworkInfoWithMessage:(NetworkInfoRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark StopDaemon(StopRequest) returns (StopResponse)

/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 */
- (GRPCUnaryProtoCall *)stopDaemonWithMessage:(StopRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark SubscribeChannelGraph(GraphTopologySubscription) returns (stream GraphTopologyUpdate)

/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 */
- (GRPCUnaryProtoCall *)subscribeChannelGraphWithMessage:(GraphTopologySubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark DebugLevel(DebugLevelRequest) returns (DebugLevelResponse)

/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 */
- (GRPCUnaryProtoCall *)debugLevelWithMessage:(DebugLevelRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark FeeReport(FeeReportRequest) returns (FeeReportResponse)

/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 */
- (GRPCUnaryProtoCall *)feeReportWithMessage:(FeeReportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark UpdateChannelPolicy(PolicyUpdateRequest) returns (PolicyUpdateResponse)

/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 */
- (GRPCUnaryProtoCall *)updateChannelPolicyWithMessage:(PolicyUpdateRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)forwardingHistoryWithMessage:(ForwardingHistoryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ExportChannelBackup(ExportChannelBackupRequest) returns (ChannelBackup)

/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 */
- (GRPCUnaryProtoCall *)exportChannelBackupWithMessage:(ExportChannelBackupRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark ExportAllChannelBackups(ChanBackupExportRequest) returns (ChanBackupSnapshot)

/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 */
- (GRPCUnaryProtoCall *)exportAllChannelBackupsWithMessage:(ChanBackupExportRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark VerifyChanBackup(ChanBackupSnapshot) returns (VerifyChanBackupResponse)

/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 */
- (GRPCUnaryProtoCall *)verifyChanBackupWithMessage:(ChanBackupSnapshot *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark RestoreChannelBackups(RestoreChanBackupRequest) returns (RestoreBackupResponse)

/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 */
- (GRPCUnaryProtoCall *)restoreChannelBackupsWithMessage:(RestoreChanBackupRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

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
 */
- (GRPCUnaryProtoCall *)subscribeChannelBackupsWithMessage:(ChannelBackupSubscription *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

@protocol WalletUnlocker <NSObject>

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
 */
- (void)genSeedWithRequest:(GenSeedRequest *)request handler:(void(^)(GenSeedResponse *_Nullable response, NSError *_Nullable error))handler;

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
- (GRPCProtoCall *)RPCToGenSeedWithRequest:(GenSeedRequest *)request handler:(void(^)(GenSeedResponse *_Nullable response, NSError *_Nullable error))handler;


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
 */
- (void)initWalletWithRequest:(InitWalletRequest *)request handler:(void(^)(InitWalletResponse *_Nullable response, NSError *_Nullable error))handler;

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
- (GRPCProtoCall *)RPCToInitWalletWithRequest:(InitWalletRequest *)request handler:(void(^)(InitWalletResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UnlockWallet(UnlockWalletRequest) returns (UnlockWalletResponse)

/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 */
- (void)unlockWalletWithRequest:(UnlockWalletRequest *)request handler:(void(^)(UnlockWalletResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `unlock`
 * UnlockWallet is used at startup of lnd to provide a password to unlock
 * the wallet database.
 */
- (GRPCProtoCall *)RPCToUnlockWalletWithRequest:(UnlockWalletRequest *)request handler:(void(^)(UnlockWalletResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ChangePassword(ChangePasswordRequest) returns (ChangePasswordResponse)

/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 */
- (void)changePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `changepassword`
 * ChangePassword changes the password of the encrypted wallet. This will
 * automatically unlock the wallet database if successful.
 */
- (GRPCProtoCall *)RPCToChangePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordResponse *_Nullable response, NSError *_Nullable error))handler;


@end

@protocol Lightning <NSObject>

#pragma mark WalletBalance(WalletBalanceRequest) returns (WalletBalanceResponse)

/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet. 
 */
- (void)walletBalanceWithRequest:(WalletBalanceRequest *)request handler:(void(^)(WalletBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `walletbalance`
 * WalletBalance returns total unspent outputs(confirmed and unconfirmed), all
 * confirmed unspent outputs and all unconfirmed unspent outputs under control
 * of the wallet. 
 */
- (GRPCProtoCall *)RPCToWalletBalanceWithRequest:(WalletBalanceRequest *)request handler:(void(^)(WalletBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ChannelBalance(ChannelBalanceRequest) returns (ChannelBalanceResponse)

/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 */
- (void)channelBalanceWithRequest:(ChannelBalanceRequest *)request handler:(void(^)(ChannelBalanceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `channelbalance`
 * ChannelBalance returns the total funds available across all open channels
 * in satoshis.
 */
- (GRPCProtoCall *)RPCToChannelBalanceWithRequest:(ChannelBalanceRequest *)request handler:(void(^)(ChannelBalanceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetTransactions(GetTransactionsRequest) returns (TransactionDetails)

/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 */
- (void)getTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(TransactionDetails *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `listchaintxns`
 * GetTransactions returns a list describing all the known transactions
 * relevant to the wallet.
 */
- (GRPCProtoCall *)RPCToGetTransactionsWithRequest:(GetTransactionsRequest *)request handler:(void(^)(TransactionDetails *_Nullable response, NSError *_Nullable error))handler;


#pragma mark EstimateFee(EstimateFeeRequest) returns (EstimateFeeResponse)

/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 */
- (void)estimateFeeWithRequest:(EstimateFeeRequest *)request handler:(void(^)(EstimateFeeResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `estimatefee`
 * EstimateFee asks the chain backend to estimate the fee rate and total fees
 * for a transaction that pays to multiple specified outputs.
 */
- (GRPCProtoCall *)RPCToEstimateFeeWithRequest:(EstimateFeeRequest *)request handler:(void(^)(EstimateFeeResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SendCoins(SendCoinsRequest) returns (SendCoinsResponse)

/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 */
- (void)sendCoinsWithRequest:(SendCoinsRequest *)request handler:(void(^)(SendCoinsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `sendcoins`
 * SendCoins executes a request to send coins to a particular address. Unlike
 * SendMany, this RPC call only allows creating a single output at a time. If
 * neither target_conf, or sat_per_byte are set, then the internal wallet will
 * consult its fee model to determine a fee for the default confirmation
 * target.
 */
- (GRPCProtoCall *)RPCToSendCoinsWithRequest:(SendCoinsRequest *)request handler:(void(^)(SendCoinsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListUnspent(ListUnspentRequest) returns (ListUnspentResponse)

/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 */
- (void)listUnspentWithRequest:(ListUnspentRequest *)request handler:(void(^)(ListUnspentResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `listunspent`
 * ListUnspent returns a list of all utxos spendable by the wallet with a
 * number of confirmations between the specified minimum and maximum.
 */
- (GRPCProtoCall *)RPCToListUnspentWithRequest:(ListUnspentRequest *)request handler:(void(^)(ListUnspentResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeTransactions(GetTransactionsRequest) returns (stream Transaction)

/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 */
- (void)subscribeTransactionsWithRequest:(GetTransactionsRequest *)request eventHandler:(void(^)(BOOL done, Transaction *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * *
 * SubscribeTransactions creates a uni-directional stream from the server to
 * the client in which any newly discovered transactions relevant to the
 * wallet are sent over.
 */
- (GRPCProtoCall *)RPCToSubscribeTransactionsWithRequest:(GetTransactionsRequest *)request eventHandler:(void(^)(BOOL done, Transaction *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark SendMany(SendManyRequest) returns (SendManyResponse)

/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 */
- (void)sendManyWithRequest:(SendManyRequest *)request handler:(void(^)(SendManyResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `sendmany`
 * SendMany handles a request for a transaction that creates multiple specified
 * outputs in parallel. If neither target_conf, or sat_per_byte are set, then
 * the internal wallet will consult its fee model to determine a fee for the
 * default confirmation target.
 */
- (GRPCProtoCall *)RPCToSendManyWithRequest:(SendManyRequest *)request handler:(void(^)(SendManyResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark NewAddress(NewAddressRequest) returns (NewAddressResponse)

/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 */
- (void)newAddressWithRequest:(NewAddressRequest *)request handler:(void(^)(NewAddressResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `newaddress`
 * NewAddress creates a new address under control of the local wallet.
 */
- (GRPCProtoCall *)RPCToNewAddressWithRequest:(NewAddressRequest *)request handler:(void(^)(NewAddressResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SignMessage(SignMessageRequest) returns (SignMessageResponse)

/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 */
- (void)signMessageWithRequest:(SignMessageRequest *)request handler:(void(^)(SignMessageResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `signmessage`
 * SignMessage signs a message with this node's private key. The returned
 * signature string is `zbase32` encoded and pubkey recoverable, meaning that
 * only the message digest and signature are needed for verification.
 */
- (GRPCProtoCall *)RPCToSignMessageWithRequest:(SignMessageRequest *)request handler:(void(^)(SignMessageResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VerifyMessage(VerifyMessageRequest) returns (VerifyMessageResponse)

/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 */
- (void)verifyMessageWithRequest:(VerifyMessageRequest *)request handler:(void(^)(VerifyMessageResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `verifymessage`
 * VerifyMessage verifies a signature over a msg. The signature must be
 * zbase32 encoded and signed by an active node in the resident node's
 * channel database. In addition to returning the validity of the signature,
 * VerifyMessage also returns the recovered pubkey from the signature.
 */
- (GRPCProtoCall *)RPCToVerifyMessageWithRequest:(VerifyMessageRequest *)request handler:(void(^)(VerifyMessageResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ConnectPeer(ConnectPeerRequest) returns (ConnectPeerResponse)

/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 */
- (void)connectPeerWithRequest:(ConnectPeerRequest *)request handler:(void(^)(ConnectPeerResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `connect`
 * ConnectPeer attempts to establish a connection to a remote peer. This is at
 * the networking level, and is used for communication between nodes. This is
 * distinct from establishing a channel with a peer.
 */
- (GRPCProtoCall *)RPCToConnectPeerWithRequest:(ConnectPeerRequest *)request handler:(void(^)(ConnectPeerResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DisconnectPeer(DisconnectPeerRequest) returns (DisconnectPeerResponse)

/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 */
- (void)disconnectPeerWithRequest:(DisconnectPeerRequest *)request handler:(void(^)(DisconnectPeerResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `disconnect`
 * DisconnectPeer attempts to disconnect one peer from another identified by a
 * given pubKey. In the case that we currently have a pending or active channel
 * with the target peer, then this action will be not be allowed.
 */
- (GRPCProtoCall *)RPCToDisconnectPeerWithRequest:(DisconnectPeerRequest *)request handler:(void(^)(DisconnectPeerResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListPeers(ListPeersRequest) returns (ListPeersResponse)

/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 */
- (void)listPeersWithRequest:(ListPeersRequest *)request handler:(void(^)(ListPeersResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `listpeers`
 * ListPeers returns a verbose listing of all currently active peers.
 */
- (GRPCProtoCall *)RPCToListPeersWithRequest:(ListPeersRequest *)request handler:(void(^)(ListPeersResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetInfo(GetInfoRequest) returns (GetInfoResponse)

/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 */
- (void)getInfoWithRequest:(GetInfoRequest *)request handler:(void(^)(GetInfoResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `getinfo`
 * GetInfo returns general information concerning the lightning node including
 * it's identity pubkey, alias, the chains it is connected to, and information
 * concerning the number of open+pending channels.
 */
- (GRPCProtoCall *)RPCToGetInfoWithRequest:(GetInfoRequest *)request handler:(void(^)(GetInfoResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark PendingChannels(PendingChannelsRequest) returns (PendingChannelsResponse)

/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 */
- (void)pendingChannelsWithRequest:(PendingChannelsRequest *)request handler:(void(^)(PendingChannelsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * TODO(roasbeef): merge with below with bool?
 * 
 * * lncli: `pendingchannels`
 * PendingChannels returns a list of all the channels that are currently
 * considered "pending". A channel is pending if it has finished the funding
 * workflow and is waiting for confirmations for the funding txn, or is in the
 * process of closure, either initiated cooperatively or non-cooperatively.
 */
- (GRPCProtoCall *)RPCToPendingChannelsWithRequest:(PendingChannelsRequest *)request handler:(void(^)(PendingChannelsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListChannels(ListChannelsRequest) returns (ListChannelsResponse)

/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 */
- (void)listChannelsWithRequest:(ListChannelsRequest *)request handler:(void(^)(ListChannelsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `listchannels`
 * ListChannels returns a description of all the open channels that this node
 * is a participant in.
 */
- (GRPCProtoCall *)RPCToListChannelsWithRequest:(ListChannelsRequest *)request handler:(void(^)(ListChannelsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeChannelEvents(ChannelEventSubscription) returns (stream ChannelEventUpdate)

/**
 * * lncli: `subscribechannelevents`
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 */
- (void)subscribeChannelEventsWithRequest:(ChannelEventSubscription *)request eventHandler:(void(^)(BOOL done, ChannelEventUpdate *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * * lncli: `subscribechannelevents`
 * SubscribeChannelEvents creates a uni-directional stream from the server to
 * the client in which any updates relevant to the state of the channels are
 * sent over. Events include new active channels, inactive channels, and closed
 * channels.
 */
- (GRPCProtoCall *)RPCToSubscribeChannelEventsWithRequest:(ChannelEventSubscription *)request eventHandler:(void(^)(BOOL done, ChannelEventUpdate *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark ClosedChannels(ClosedChannelsRequest) returns (ClosedChannelsResponse)

/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that 
 * this node was a participant in.
 */
- (void)closedChannelsWithRequest:(ClosedChannelsRequest *)request handler:(void(^)(ClosedChannelsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `closedchannels`
 * ClosedChannels returns a description of all the closed channels that 
 * this node was a participant in.
 */
- (GRPCProtoCall *)RPCToClosedChannelsWithRequest:(ClosedChannelsRequest *)request handler:(void(^)(ClosedChannelsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark OpenChannelSync(OpenChannelRequest) returns (ChannelPoint)

/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 */
- (void)openChannelSyncWithRequest:(OpenChannelRequest *)request handler:(void(^)(ChannelPoint *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * OpenChannelSync is a synchronous version of the OpenChannel RPC call. This
 * call is meant to be consumed by clients to the REST proxy. As with all
 * other sync calls, all byte slices are intended to be populated as hex
 * encoded strings.
 */
- (GRPCProtoCall *)RPCToOpenChannelSyncWithRequest:(OpenChannelRequest *)request handler:(void(^)(ChannelPoint *_Nullable response, NSError *_Nullable error))handler;


#pragma mark OpenChannel(OpenChannelRequest) returns (stream OpenStatusUpdate)

/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 */
- (void)openChannelWithRequest:(OpenChannelRequest *)request eventHandler:(void(^)(BOOL done, OpenStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * * lncli: `openchannel`
 * OpenChannel attempts to open a singly funded channel specified in the
 * request to a remote peer. Users are able to specify a target number of
 * blocks that the funding transaction should be confirmed in, or a manual fee
 * rate to us for the funding transaction. If neither are specified, then a
 * lax block confirmation target is used.
 */
- (GRPCProtoCall *)RPCToOpenChannelWithRequest:(OpenChannelRequest *)request eventHandler:(void(^)(BOOL done, OpenStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler;


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
 */
- (void)closeChannelWithRequest:(CloseChannelRequest *)request eventHandler:(void(^)(BOOL done, CloseStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler;

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
- (GRPCProtoCall *)RPCToCloseChannelWithRequest:(CloseChannelRequest *)request eventHandler:(void(^)(BOOL done, CloseStatusUpdate *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark AbandonChannel(AbandonChannelRequest) returns (AbandonChannelResponse)

/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 */
- (void)abandonChannelWithRequest:(AbandonChannelRequest *)request handler:(void(^)(AbandonChannelResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `abandonchannel`
 * AbandonChannel removes all channel state from the database except for a
 * close summary. This method can be used to get rid of permanently unusable
 * channels due to bugs fixed in newer versions of lnd. Only available
 * when in debug builds of lnd.
 */
- (GRPCProtoCall *)RPCToAbandonChannelWithRequest:(AbandonChannelRequest *)request handler:(void(^)(AbandonChannelResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SendPayment(stream SendRequest) returns (stream SendResponse)

/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 */
- (void)sendPaymentWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * * lncli: `sendpayment`
 * SendPayment dispatches a bi-directional streaming RPC for sending payments
 * through the Lightning Network. A single RPC invocation creates a persistent
 * bi-directional stream allowing clients to rapidly send payments through the
 * Lightning Network with a single persistent connection.
 */
- (GRPCProtoCall *)RPCToSendPaymentWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark SendPaymentSync(SendRequest) returns (SendResponse)

/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 */
- (void)sendPaymentSyncWithRequest:(SendRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * SendPaymentSync is the synchronous non-streaming version of SendPayment.
 * This RPC is intended to be consumed by clients of the REST proxy.
 * Additionally, this RPC expects the destination's public key and the payment
 * hash (if any) to be encoded as hex strings.
 */
- (GRPCProtoCall *)RPCToSendPaymentSyncWithRequest:(SendRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SendToRoute(stream SendToRouteRequest) returns (stream SendResponse)

/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 */
- (void)sendToRouteWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * * lncli: `sendtoroute`
 * SendToRoute is a bi-directional streaming RPC for sending payment through
 * the Lightning Network. This method differs from SendPayment in that it
 * allows users to specify a full route manually. This can be used for things
 * like rebalancing, and atomic swaps.
 */
- (GRPCProtoCall *)RPCToSendToRouteWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, SendResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark SendToRouteSync(SendToRouteRequest) returns (SendResponse)

/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 */
- (void)sendToRouteSyncWithRequest:(SendToRouteRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * SendToRouteSync is a synchronous version of SendToRoute. It Will block
 * until the payment either fails or succeeds.
 */
- (GRPCProtoCall *)RPCToSendToRouteSyncWithRequest:(SendToRouteRequest *)request handler:(void(^)(SendResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark AddInvoice(Invoice) returns (AddInvoiceResponse)

/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 */
- (void)addInvoiceWithRequest:(Invoice *)request handler:(void(^)(AddInvoiceResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `addinvoice`
 * AddInvoice attempts to add a new invoice to the invoice database. Any
 * duplicated invoices are rejected, therefore all invoices *must* have a
 * unique payment preimage.
 */
- (GRPCProtoCall *)RPCToAddInvoiceWithRequest:(Invoice *)request handler:(void(^)(AddInvoiceResponse *_Nullable response, NSError *_Nullable error))handler;


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
 */
- (void)listInvoicesWithRequest:(ListInvoiceRequest *)request handler:(void(^)(ListInvoiceResponse *_Nullable response, NSError *_Nullable error))handler;

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
- (GRPCProtoCall *)RPCToListInvoicesWithRequest:(ListInvoiceRequest *)request handler:(void(^)(ListInvoiceResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark LookupInvoice(PaymentHash) returns (Invoice)

/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 */
- (void)lookupInvoiceWithRequest:(PaymentHash *)request handler:(void(^)(Invoice *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `lookupinvoice`
 * LookupInvoice attempts to look up an invoice according to its payment hash.
 * The passed payment hash *must* be exactly 32 bytes, if not, an error is
 * returned.
 */
- (GRPCProtoCall *)RPCToLookupInvoiceWithRequest:(PaymentHash *)request handler:(void(^)(Invoice *_Nullable response, NSError *_Nullable error))handler;


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
 */
- (void)subscribeInvoicesWithRequest:(InvoiceSubscription *)request eventHandler:(void(^)(BOOL done, Invoice *_Nullable response, NSError *_Nullable error))eventHandler;

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
- (GRPCProtoCall *)RPCToSubscribeInvoicesWithRequest:(InvoiceSubscription *)request eventHandler:(void(^)(BOOL done, Invoice *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark DecodePayReq(PayReqString) returns (PayReq)

/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 */
- (void)decodePayReqWithRequest:(PayReqString *)request handler:(void(^)(PayReq *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `decodepayreq`
 * DecodePayReq takes an encoded payment request string and attempts to decode
 * it, returning a full description of the conditions encoded within the
 * payment request.
 */
- (GRPCProtoCall *)RPCToDecodePayReqWithRequest:(PayReqString *)request handler:(void(^)(PayReq *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ListPayments(ListPaymentsRequest) returns (ListPaymentsResponse)

/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 */
- (void)listPaymentsWithRequest:(ListPaymentsRequest *)request handler:(void(^)(ListPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `listpayments`
 * ListPayments returns a list of all outgoing payments.
 */
- (GRPCProtoCall *)RPCToListPaymentsWithRequest:(ListPaymentsRequest *)request handler:(void(^)(ListPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DeleteAllPayments(DeleteAllPaymentsRequest) returns (DeleteAllPaymentsResponse)

/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 */
- (void)deleteAllPaymentsWithRequest:(DeleteAllPaymentsRequest *)request handler:(void(^)(DeleteAllPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * DeleteAllPayments deletes all outgoing payments from DB.
 */
- (GRPCProtoCall *)RPCToDeleteAllPaymentsWithRequest:(DeleteAllPaymentsRequest *)request handler:(void(^)(DeleteAllPaymentsResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark DescribeGraph(ChannelGraphRequest) returns (ChannelGraph)

/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 */
- (void)describeGraphWithRequest:(ChannelGraphRequest *)request handler:(void(^)(ChannelGraph *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `describegraph`
 * DescribeGraph returns a description of the latest graph state from the
 * point of view of the node. The graph information is partitioned into two
 * components: all the nodes/vertexes, and all the edges that connect the
 * vertexes themselves.  As this is a directed graph, the edges also contain
 * the node directional specific routing policy which includes: the time lock
 * delta, fee information, etc.
 */
- (GRPCProtoCall *)RPCToDescribeGraphWithRequest:(ChannelGraphRequest *)request handler:(void(^)(ChannelGraph *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetChanInfo(ChanInfoRequest) returns (ChannelEdge)

/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 */
- (void)getChanInfoWithRequest:(ChanInfoRequest *)request handler:(void(^)(ChannelEdge *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `getchaninfo`
 * GetChanInfo returns the latest authenticated network announcement for the
 * given channel identified by its channel ID: an 8-byte integer which
 * uniquely identifies the location of transaction's funding output within the
 * blockchain.
 */
- (GRPCProtoCall *)RPCToGetChanInfoWithRequest:(ChanInfoRequest *)request handler:(void(^)(ChannelEdge *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNodeInfo(NodeInfoRequest) returns (NodeInfo)

/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 */
- (void)getNodeInfoWithRequest:(NodeInfoRequest *)request handler:(void(^)(NodeInfo *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `getnodeinfo`
 * GetNodeInfo returns the latest advertised, aggregated, and authenticated
 * channel information for the specified node identified by its public key.
 */
- (GRPCProtoCall *)RPCToGetNodeInfoWithRequest:(NodeInfoRequest *)request handler:(void(^)(NodeInfo *_Nullable response, NSError *_Nullable error))handler;


#pragma mark QueryRoutes(QueryRoutesRequest) returns (QueryRoutesResponse)

/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The retuned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 */
- (void)queryRoutesWithRequest:(QueryRoutesRequest *)request handler:(void(^)(QueryRoutesResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `queryroutes`
 * QueryRoutes attempts to query the daemon's Channel Router for a possible
 * route to a target destination capable of carrying a specific amount of
 * satoshis. The retuned route contains the full details required to craft and
 * send an HTLC, also including the necessary information that should be
 * present within the Sphinx packet encapsulated within the HTLC.
 */
- (GRPCProtoCall *)RPCToQueryRoutesWithRequest:(QueryRoutesRequest *)request handler:(void(^)(QueryRoutesResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark GetNetworkInfo(NetworkInfoRequest) returns (NetworkInfo)

/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 */
- (void)getNetworkInfoWithRequest:(NetworkInfoRequest *)request handler:(void(^)(NetworkInfo *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `getnetworkinfo`
 * GetNetworkInfo returns some basic stats about the known channel graph from
 * the point of view of the node.
 */
- (GRPCProtoCall *)RPCToGetNetworkInfoWithRequest:(NetworkInfoRequest *)request handler:(void(^)(NetworkInfo *_Nullable response, NSError *_Nullable error))handler;


#pragma mark StopDaemon(StopRequest) returns (StopResponse)

/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 */
- (void)stopDaemonWithRequest:(StopRequest *)request handler:(void(^)(StopResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `stop`
 * StopDaemon will send a shutdown request to the interrupt handler, triggering
 * a graceful shutdown of the daemon.
 */
- (GRPCProtoCall *)RPCToStopDaemonWithRequest:(StopRequest *)request handler:(void(^)(StopResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SubscribeChannelGraph(GraphTopologySubscription) returns (stream GraphTopologyUpdate)

/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 */
- (void)subscribeChannelGraphWithRequest:(GraphTopologySubscription *)request eventHandler:(void(^)(BOOL done, GraphTopologyUpdate *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * *
 * SubscribeChannelGraph launches a streaming RPC that allows the caller to
 * receive notifications upon any changes to the channel graph topology from
 * the point of view of the responding node. Events notified include: new
 * nodes coming online, nodes updating their authenticated attributes, new
 * channels being advertised, updates in the routing policy for a directional
 * channel edge, and when channels are closed on-chain.
 */
- (GRPCProtoCall *)RPCToSubscribeChannelGraphWithRequest:(GraphTopologySubscription *)request eventHandler:(void(^)(BOOL done, GraphTopologyUpdate *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark DebugLevel(DebugLevelRequest) returns (DebugLevelResponse)

/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 */
- (void)debugLevelWithRequest:(DebugLevelRequest *)request handler:(void(^)(DebugLevelResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `debuglevel`
 * DebugLevel allows a caller to programmatically set the logging verbosity of
 * lnd. The logging can be targeted according to a coarse daemon-wide logging
 * level, or in a granular fashion to specify the logging for a target
 * sub-system.
 */
- (GRPCProtoCall *)RPCToDebugLevelWithRequest:(DebugLevelRequest *)request handler:(void(^)(DebugLevelResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark FeeReport(FeeReportRequest) returns (FeeReportResponse)

/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 */
- (void)feeReportWithRequest:(FeeReportRequest *)request handler:(void(^)(FeeReportResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `feereport`
 * FeeReport allows the caller to obtain a report detailing the current fee
 * schedule enforced by the node globally for each channel.
 */
- (GRPCProtoCall *)RPCToFeeReportWithRequest:(FeeReportRequest *)request handler:(void(^)(FeeReportResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark UpdateChannelPolicy(PolicyUpdateRequest) returns (PolicyUpdateResponse)

/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 */
- (void)updateChannelPolicyWithRequest:(PolicyUpdateRequest *)request handler:(void(^)(PolicyUpdateResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `updatechanpolicy`
 * UpdateChannelPolicy allows the caller to update the fee schedule and
 * channel policies for all channels globally, or a particular channel.
 */
- (GRPCProtoCall *)RPCToUpdateChannelPolicyWithRequest:(PolicyUpdateRequest *)request handler:(void(^)(PolicyUpdateResponse *_Nullable response, NSError *_Nullable error))handler;


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
 */
- (void)forwardingHistoryWithRequest:(ForwardingHistoryRequest *)request handler:(void(^)(ForwardingHistoryResponse *_Nullable response, NSError *_Nullable error))handler;

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
- (GRPCProtoCall *)RPCToForwardingHistoryWithRequest:(ForwardingHistoryRequest *)request handler:(void(^)(ForwardingHistoryResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ExportChannelBackup(ExportChannelBackupRequest) returns (ChannelBackup)

/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 */
- (void)exportChannelBackupWithRequest:(ExportChannelBackupRequest *)request handler:(void(^)(ChannelBackup *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `exportchanbackup`
 * ExportChannelBackup attempts to return an encrypted static channel backup
 * for the target channel identified by it channel point. The backup is
 * encrypted with a key generated from the aezeed seed of the user. The
 * returned backup can either be restored using the RestoreChannelBackup
 * method once lnd is running, or via the InitWallet and UnlockWallet methods
 * from the WalletUnlocker service.
 */
- (GRPCProtoCall *)RPCToExportChannelBackupWithRequest:(ExportChannelBackupRequest *)request handler:(void(^)(ChannelBackup *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ExportAllChannelBackups(ChanBackupExportRequest) returns (ChanBackupSnapshot)

/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 */
- (void)exportAllChannelBackupsWithRequest:(ChanBackupExportRequest *)request handler:(void(^)(ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * ExportAllChannelBackups returns static channel backups for all existing
 * channels known to lnd. A set of regular singular static channel backups for
 * each channel are returned. Additionally, a multi-channel backup is returned
 * as well, which contains a single encrypted blob containing the backups of
 * each channel.
 */
- (GRPCProtoCall *)RPCToExportAllChannelBackupsWithRequest:(ChanBackupExportRequest *)request handler:(void(^)(ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))handler;


#pragma mark VerifyChanBackup(ChanBackupSnapshot) returns (VerifyChanBackupResponse)

/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 */
- (void)verifyChanBackupWithRequest:(ChanBackupSnapshot *)request handler:(void(^)(VerifyChanBackupResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * *
 * VerifyChanBackup allows a caller to verify the integrity of a channel backup
 * snapshot. This method will accept either a packed Single or a packed Multi.
 * Specifying both will result in an error.
 */
- (GRPCProtoCall *)RPCToVerifyChanBackupWithRequest:(ChanBackupSnapshot *)request handler:(void(^)(VerifyChanBackupResponse *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RestoreChannelBackups(RestoreChanBackupRequest) returns (RestoreBackupResponse)

/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 */
- (void)restoreChannelBackupsWithRequest:(RestoreChanBackupRequest *)request handler:(void(^)(RestoreBackupResponse *_Nullable response, NSError *_Nullable error))handler;

/**
 * * lncli: `restorechanbackup`
 * RestoreChannelBackups accepts a set of singular channel backups, or a
 * single encrypted multi-chan backup and attempts to recover any funds
 * remaining within the channel. If we are able to unpack the backup, then the
 * new channel will be shown under listchannels, as well as pending channels.
 */
- (GRPCProtoCall *)RPCToRestoreChannelBackupsWithRequest:(RestoreChanBackupRequest *)request handler:(void(^)(RestoreBackupResponse *_Nullable response, NSError *_Nullable error))handler;


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
 */
- (void)subscribeChannelBackupsWithRequest:(ChannelBackupSubscription *)request eventHandler:(void(^)(BOOL done, ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))eventHandler;

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
- (GRPCProtoCall *)RPCToSubscribeChannelBackupsWithRequest:(ChannelBackupSubscription *)request eventHandler:(void(^)(BOOL done, ChanBackupSnapshot *_Nullable response, NSError *_Nullable error))eventHandler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface WalletUnlocker : GRPCProtoService<WalletUnlocker, WalletUnlocker2>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Lightning : GRPCProtoService<Lightning, Lightning2>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

