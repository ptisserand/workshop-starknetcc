#[contract]
mod Counter {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::contract_address_const;
    use starknet::ContractAddress;

    struct Storage {
        counter: felt252,
    }

    #[event]
    fn Tick(ticker: ContractAddress, value: felt252) {}


    #[constructor]
    fn constructor(
    ) {
        counter::write(0);
    }

    #[view]
    fn get_counter() -> felt252 {
        counter::read()
    }

    #[external]
    fn tick() {
        let ticker = get_caller_address();
        counter::write(counter::read() + 1);
        Tick(ticker, counter::read());
    }

    #[external]
    fn reset_counter() {
        counter::write(0);
    }
}
