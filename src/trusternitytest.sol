import 'dapple/test.sol'; // virtual "dapple" package imported when `dapple test` is run
import 'trusternity.sol';

// Deriving from `Test` marks the contract as a test and gives you access to various test helpers.
contract TrusternityTest is Test {
    MyRegistry reg;
    Tester proxy_tester;
    
    // The function called "setUp" with no arguments is
    // called on a fresh instance of this contract before
    // each test.
    function setUp() {
        reg = new MyRegistry();
        proxy_tester = new Tester();
        proxy_tester._target(reg);
    }
    
    function testCreatorIsCreator() {
        assertEq( address(this), reg._creator() );
    }
    function testFailNonCreatorSet() {
        MyRegistry(proxy_tester).set("no", "stop");
    }
    event Set(bytes32 indexed key, bytes32 value);
    function testSetEvent() {
        expectEventsExact(reg);
        Set("hello", "hi");
        reg.set("hello", "hi");
    }
}