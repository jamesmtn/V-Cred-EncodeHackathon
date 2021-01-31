# V-Cred-EncodeHackathon
### Disclaimer: Flashloans are an advanced concept, and I have not added all safeguards since this is an MVP. Please do not use it in production.

![Logo](/assets/logo.png)

V-Cred project aims to bring flashloans to Binance Smart Chain. BSC currently has low gas fees, and provides an opportunity for exploiting triangular arbitrage usecases.
This repository provides the smart contracts used to develop the MVP. It follows the safe flash loan design pattern of a deposit pool and lending pool contract acting as a guardrail to prevent re-entrancy attacks. 
The problem we are trying to solve is illustrated here. Flashloans provide risk free liquidity for one transaction and connects LPs, hackers enabling triangular arbitrage usecases.

![Logo](/assets/problem.png)
