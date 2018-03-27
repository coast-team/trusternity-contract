# Analysis of Ethereum block size (used in Trusternity paper)

We calculate how much a Trusternity client must download from Ethereum network. All computation is based on the formal specification of Ethereum yellow paper. In this section, we re-use all notation from the paper. Though there might be differences in the actual wallet implementation, our calculation based on formal specification provides a good base for estimating client's required bandwidth.

| Fields | Size(B) | Notes |
| ------------- |:-------------:| -----:|
|***Block header: 668 Bytes***|
|Hp, Ho, Hr , Ht, He, Hm |32 |Keccak 256-bit hashes|
|Hd, Hi, Hl, Hg, Hs |32 |scalar values|
|Hb | 256|
|Hn | 8| |
|Hc |20| |
|Hx |32 |Maximum|
|***Transaction: 281 Bytes***|
|Tn, Tp, Tg, Tv |32 |scalar values|
|Tt |20|
|Tw |1|
|Tr , Ts |32| Adx F yellow paper|
|Td |68| 4-32-32|
|***Transaction Receipt: 444 Bytes***|
|Rσ |32|
|Ru |8|
|Rb |256|
|Rl − Oa |20|
|Rl − Ot |96| 3 topics
|Rl − Od |32| ST Re

***Table 1: Block header, transaction and receipt size estimation based on section 4.3 and 4.4 of Ethereum yellow paper***

A Trusternity client downloads Ethereum block header, a list of transactions that is filtered by the bloom filter $B$ and the corresponding receipts for each transactions. We show our detail calculation for those three types in table 1. 

There are fields identified as arbitrary scalar values (i.e. $H_d$), we assume that those values can be presented with 32 bytes big integers. 
We also calculate the transaction data $T_d$ based on $TSC.Publish$. The field requires 4 bytes of method identifier following by 32 bytes for each parameters $epoch$ and $STR$.

Additionally, for each transaction, the client needs to download a proof to validate against the transaction root in the block header. 
Let $\eta$ is the number of transaction in a block, a proof for a transaction in the Ethereum transaction trie requires an authentication path length of $\frac{log_{2}\eta}{4}$. Since a node in the trie contains 16 items including the pointer to the transaction we want to prove, the authentication path requires at most additional 15 items at each node where each item is 32 bytes of data. The current mean is $\eta\approx10$ transactions per block. Thus, the proof is relatively small at 480 bytes.

Assume that average block time is 12 second and epoch time is 1 hour. For each epoch, $TC$ must download 300 block header and 1 transaction. Thus, the total bandwidth for 1 epoch is $668 * 300 + 281 + 444 + 480 = 201605$ bytes ($\approx 201.6 KB$)
