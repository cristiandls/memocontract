import Web3 from "web3";

const getWeb3 = () =>
  new Promise((resolve, reject) => {
    // Wait for loading completion to avoid race conditions with web3 injection timing.
    window.addEventListener("load", () => {
      let web3 = window.web3;

      // Checking if Web3 has been injected by the browser (Mist/MetaMask).
      const alreadyInjected = typeof web3 !== "undefined";

      if (alreadyInjected) {
        // Use Mist/MetaMask's provider.
        web3 = new Web3(web3.currentProvider);
        console.log("Injected web3 detected.");
        resolve(web3);
      } else {
        // Fallback to localhost if no web3 injection. We've configured this to
        // use the development console's port by default.
        // const provider = new Web3.providers.HttpProvider(
        //   "http://127.0.0.1:8545"
        // );


        // const provider = new Web3.providers.WebsocketProvider(
        //   //"ws://127.0.0.1:8545"
        //   "wss://ropsten.infura.io/ws"
        // );
 
        // api dels bdaca37a988e4283864a60e0bb1fa2eb
        //const provider = new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/efa7ae9d17734a61b63957d0773eede8")
        const provider = new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/bdaca37a988e4283864a60e0bb1fa2eb")

        //var provider = new Web3.providers.WebsocketProvider('ws://127.0.0.1:8545') 

        web3 = new Web3(provider);
        console.log("No web3 instance injected, using Local web3.");
        resolve(web3);
      }
    });
  });

export default getWeb3;
