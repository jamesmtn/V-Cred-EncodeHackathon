//let depositPool = artifacts.require('depositPool')
let flashModule = artifacts.require('flashModule')
//let priceOracle = artifacts.require('priceOracle')

module.exports = async function (deployer) {
  //await deployer.deploy(depositPool)
  await deployer.deploy(flashModule)
  //await deployer.deploy(priceOracle, '0xDA7a001b254CD22e46d3eAB04d937489c93174C3')
}
