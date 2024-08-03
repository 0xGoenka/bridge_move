
// #[test_only]
// module bridge::brige_tests {
//     // uncomment this line to import the module
//     use bridge::bridge;

//     // const ENotImplemented: u64 = 0;

//     #[test]
//     fun test_brige_main() {
//         // pass
//         let url: vector<u8> = b"Hello, World!";     
//         let name: vector<u8> = b"Goodbye, World!";
//         let authorAddr: address = @0x858598439650c7403db1be4ae4bfc97964a940bd78a7a61e558bee1cb14bedaa;
//         let ctx = &mut tx_context::dummy();
//         // bridge::generate(prompt, negative_prompt, model_name, callback_type, ctx);
//         bridge::callback(url.to_string(), name.to_string(), authorAddr, ctx)
//     }

//     // #[test, expected_failure(abort_code = ::bridge::bridge_tests::ENotImplemented)]
//     // fun test_brige_fail() {
//     //     abort ENotImplemented
//     // }
// }

