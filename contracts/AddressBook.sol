pragma solidity 0.8.4;

contract AddressBook {
    //maps an address to an address array
    //As an example your address to a list of addresses you are interested in.  This supports multiple people having an address book

    mapping(address => address[]) private _addresses;

    //maps an address to another map of address to a string
    //example - your address mapped to a mapping of your address book to its alias

    mapping(address => mapping(address => string)) private _aliases;

    //returns the list of addresses in the _addresses map
    function getAddressArray(address addr) public returns (address[] memory) {
        return _addresses[addr];
    }

    //adds address to your list of addresses in the _addresses map.
    //Uses push since it is an array
    //adds your address, address and alias to the _aliases map
    function addAddress(address addr, string memory alia) public {
        _addresses[msg.sender].push(addr);
        _aliases[msg.sender][addr] = alia;
    }

    function removeAddress(address addr) public {
        // get the length of the addresses in the array from the msg sender
        uint256 length = _addresses[msg.sender].length;
        for (uint256 i = 0; i < length; i++) {
            // if the address that you want to remove = one of the addresses you own
            //and is one of the iterations of the loop
            if (addr == _addresses[msg.sender][i]) {
                //once we find the item in the array we need to delete the item
                //then shift each item down 1.  You can't just delete an item in the middle of an array
                //make sure the length of the address is not < 1 (this is needed because we are going to reorder the array)
                if (1 < _addresses[msg.sender].length && i < length - 1) {
                    //shift the last item in the array to the position of the item that we are removing
                    _addresses[msg.sender][i] = _addresses[msg.sender][
                        length - 1
                    ];
                }

                // delete the item we just swapped from
                delete _addresses[msg.sender][length - 1];
                //then decrement the length of the array by 1
                _addresses[msg.sender].length--;
                //delete the alias for it
                delete _aliases[msg.sender][addr];
                //_state[msg.sender]++;
                break;
            }
        }
    }

    //Gets the alias for your address
    function getAlias(address addrowner, address addr)
        public
        returns (string memory)
    {
        return _aliases[addrowner][addr];
    }
}
