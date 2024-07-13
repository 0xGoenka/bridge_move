
module bridge::bridge {
    use std::string::String;
    use std::debug;
    use sui::event;
    use sui::coin::Coin;
    use sui::coin;
    use sui::sui::SUI;
    use sui::url::{Self,Url};



    const ERROR_INSUFFICIENT_FUNDS: u64 = 1;
    const MIN_INFERENCE_COST: u64 = 50_000_000;
    

    public struct EventGenerate has copy, drop  {
        prompt: String, 
        negative_prompt: String, 
        model_name: String,
        callback_type: String,
        sender: address,
    }   

    public struct JARJAR_Nft has key, store { // @TODO CHECK WITH STORE
        id: UID,
        name: String,
        description: String,
        url: Url,
    }

    public struct OwnerCap has key { id: UID, owner: address }

    fun init(ctx: &mut TxContext) {
        transfer::share_object(
    OwnerCap {
        id: object::new(ctx),
        owner: tx_context::sender(ctx),
      }
    );
  }


    public fun generate(
        prompt: String, 
        negative_prompt: String, 
        model_name: String,
        callback_type: String,
        payment: Coin<SUI>,
        ownercap: &mut OwnerCap,
        ctx: &mut TxContext
        ) {

        let value: u64 = coin::value(&payment);

        assert!(value == MIN_INFERENCE_COST, ERROR_INSUFFICIENT_FUNDS);

        transfer::public_transfer(payment, ownercap.owner);

        event::emit(EventGenerate {
            prompt,
            negative_prompt,
            model_name,
            callback_type,
            sender: tx_context::sender(ctx),
        });
    }

    public fun callback(
        url: vector<u8>,
        name: String,
        authorAddr: address,
        ctx: &mut TxContext
        ) {
        // assert!(tx_context::sender(ctx) == );
        let nft = JARJAR_Nft {
            id: object::new(ctx),
            name,
            url: url::new_unsafe_from_bytes(url),
            description: name,
            };
        debug::print(&nft);
        transfer::public_transfer(nft, authorAddr);
    }

    public fun name(nft: &JARJAR_Nft): &String {
        &nft.name
    }

    /// Get the NFT's `description`
    public fun description(nft: &JARJAR_Nft): &String {
        &nft.description
    }

    /// Get the NFT's `url`
    public fun url(nft: &JARJAR_Nft): &Url {
        &nft.url
    }
}
