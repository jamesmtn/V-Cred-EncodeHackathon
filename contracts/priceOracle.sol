pragma solidity ^0.6.8;
pragma experimental ABIEncoderV2;


interface IStdReference {
    /// A structure returned whenever someone requests for standard reference data.
    struct ReferenceData {
        uint256 rate; // base/quote exchange rate, multiplied by 1e18.
        uint256 lastUpdatedBase; // UNIX epoch of the last time when base price gets updated.
        uint256 lastUpdatedQuote; // UNIX epoch of the last time when quote price gets updated.
    }

    /// Returns the price data for the given base/quote pair. Revert if not available.
    function getReferenceData(string memory _base, string memory _quote)
        external
        view
        returns (ReferenceData memory);

    /// Similar to getReferenceData, but with multiple base/quote pairs at once.
    function getReferenceDataBulk(string[] memory _bases, string[] memory _quotes)
        external
        view
        returns (ReferenceData[] memory);
}

contract priceOracle {
    
    IStdReference ref;
    uint256 public price;

    constructor(IStdReference _ref) public {
        ref = _ref;
    }

    function getPrice(string memory token1, string memory token2) public view returns (uint256){
        IStdReference.ReferenceData memory data = ref.getReferenceData(token1,token2);
        return data.rate;   
    }


}