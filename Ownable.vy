# @version ^0.3.7

"""
@title Ownable
@license MIT
@author Casper Kjær Rasmussen / @maythebytesbewithyou
"""

event OwnershipTransferred:
    previousOwner: indexed(address)
    newOwner: indexed(address)

owner: public(address)

@external
def __init__():
    self._transferOwnership(msg.sender)


@external
@view
def _onlyOwner():
    assert self.owner == msg.sender, "caller is not the owner"


@external
def transferOwnership(_newOwner: address):
    assert _newOwner != empty(address), "new owner is zero address"
    self._onlyOwner()
    self._transferOwnership(_newOwner)


@external
def renounceOwnership():
    self._onlyOwner()
    self._transferOwnership(empty(address))


@internal
def _transferOwnership(_newOwner: address):
    previousOwner: address = self.owner
    self.owner = _newOwner
    log OwnershipTransferred(previousOwner, _newOwner)
