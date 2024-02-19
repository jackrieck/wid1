// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SolanaWalletMgr} from "../src/SolanaWalletMgr.sol";
import {WorldIDIdentityManagerRouterMock} from "src/test/mock/WorldIDIdentityManagerRouterMock.sol";
import {PRBTest} from "@prb/test/PRBTest.sol";

contract SolanaWalletMgrTest is PRBTest {
    SolanaWalletMgr public verifySolanaAddress;

    function setUp() public {
        verifySolanaAddress = new SolanaWalletMgr(1, "foo", "bar");
    }
}
