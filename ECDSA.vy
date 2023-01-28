# @version ^0.3.7

"""
@title ECDSA
@license MIT
@author Casper Kjær Rasmussen @maythebytesbewithyou
"""

@external
@pure
def recover(_hash: bytes32, _signature: Bytes[65]) -> address:
    """
    @dev Recover the signer's address from the signed message and signature.
    @param _hash - bytes32, the hash is the signed message.
    @param _signature - Bytes[65], the signature is generated by signing the message.
    """
    if len(_signature) != 65:
        return empty(address)
    r: bytes32 = extract32(_signature, 0)
    s: bytes32 = extract32(_signature, 32)
    v: uint8 = convert(slice(_signature, 64, 1), uint8)

    if v < 27:
        v += 27
    if v in [27, 28]:
        return ecrecover(_hash, v, r, s)
    return empty(address)