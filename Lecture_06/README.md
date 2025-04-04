### Steps to Deploy & Run

1. Deploy MyToken contract using user's address as the owner.
2. Deploy Staking contract using contract address of MyToken.
3. Call transfer function of MyToken contract to transfer tokens to the Staking contract address.
4. Call approve function of MyToken contract to approve the Staking contract to spend tokens on behalf of the user.
5. Call stake function of Staking contract to stake tokens.