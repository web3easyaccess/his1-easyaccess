// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "forge-std/Test.sol";
import "../contracts/Main.sol";

contract Main2Test is Test {
    Main public main;
    address eoa = makeAddr("eoa");
    uint256 nonce = 0x111;
    uint8 v = 0x11;
    bytes32 r = "22";
    bytes32 s = "33";

    function setUp() public {
        vm.prank(eoa);
        main = new Main();
    }

    function testQueryContractAddr() public {
        vm.prank(eoa);
        assertEq(main.queryContractAddr(eoa, 0, 0, 0, 0), address(0));
    }

    function testPermitRegister() public {
        vm.startPrank(eoa);
        main.permitRegister(eoa, nonce, v, r, s);
        emit log_address(main.userContracts(eoa));
    }

    function testPermitTransferETH() public {
        address to = makeAddr("to");
        address userContract = main.userContracts(eoa);
        vm.startPrank(eoa);
        vm.deal(userContract, 2 ether);
        emit log_uint(userContract.balance);
        main.permitRegister(eoa, nonce, v, r, s);
        main.permitTransferETH(to, 1 ether, eoa, nonce, v, r, s);
        // assertEq(to.balance, 1 ether);
    }
}
