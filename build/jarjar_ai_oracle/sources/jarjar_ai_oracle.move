
module jarjar_ai_oracle::jarjar_ai_oracle {
    use std::string::String;
    use sui::event;
    use sui::coin::Coin;
    use sui::coin;
    use sui::sui::SUI;

    const ERROR_INSUFFICIENT_FUNDS: u64 = 1;
    const ERROR_NOT_OWNER: u64 = 2;
    
    public struct EventGenerate has copy, drop  {
        prompt_data: String,
        callback_data: String,
        model_name: String,
        sender: address,
        value: u64,
    }   

    public struct OwnerCap has key { id: UID, owner: address, oracle_price: u64 }

    fun init(ctx: &mut TxContext) {
        transfer::share_object(
    OwnerCap {
        id: object::new(ctx),
        owner: tx_context::sender(ctx),
        oracle_price: 100_000_000,
      }
    );
    } 

    public fun get_owner_cap_address(ownercap: &OwnerCap): address {
        ownercap.owner
    }

    public fun get_oracle_price(ownercap: &OwnerCap): u64 {
        ownercap.oracle_price
    }

    public fun update_oracle_price(oracle_price: u64, ownercap: &mut OwnerCap, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == ownercap.owner, ERROR_NOT_OWNER);
        ownercap.oracle_price = oracle_price;
    }

    public fun generate(
        prompt_data: String,  
        callback_data: String,
        model_name: String,
        payment: Coin<SUI>,
        ownercap: &mut OwnerCap,
        ctx: &mut TxContext
        ) {

        let value: u64 = coin::value(&payment);

        assert!(value == get_oracle_price(ownercap), ERROR_INSUFFICIENT_FUNDS);

        transfer::public_transfer(payment, ownercap.owner);

        event::emit(EventGenerate {
            prompt_data,
            callback_data,
            model_name,
            sender: tx_context::sender(ctx),
            value,
        });
    }
}
