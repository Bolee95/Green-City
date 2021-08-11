

/** Demo initialisation of assets and participants
* @param {org.GreenCity.DemoSetup} DemoSetup
* @transaction
*/

async function DemoSetup(DemoSetup)
{
  const factory = getFactory();
  const NS = 'org.GreenCity';
  
  //creating user
  const user1 = factory.newResource(NS, 'User', 'user1@gmail.com');
  const user1Address = factory.newConcept(NS,'Address');
  user1Address.country = 'Serbia';
  user1Address.city = 'Nis';
  user1.address = user1Address;
  
  const action = factory.newResource(NS, 'Action', 'Akcija1!');
  
  action.organiserEmail = 'goran@test.com';
  action.longitude = 2;
  action.latitude = 2;
  action.address = user1Address;
  action.description = 'hello!';
  action.moneyNeeded = 23;
  action.status = "Started";
  action.date = "2018-08-01T20:08:14.906Z";
  action.completed = false;
  
  
 
  
  const wallet1 = factory.newResource(NS, 'Wallet', 'user1@gmail.com');
  wallet1.balance = 10;
  wallet1.lastUpdated = '01-01-2015';//date.timestamp;
  user1.wallet = factory.newRelationship(NS, 'Wallet', 'user1@gmail.com');
  
  const wallet2 = factory.newResource(NS, 'Wallet', 'akcija@gmail.com');
  wallet2.balance = 10;
  wallet2.lastUpdated = '01-01-2015';//date.timestamp;
  action.wallet = factory.newRelationship(NS, 'Wallet', 'akcija@gmail.com');
  
  
  user1.firstName = 'Bogdan';
  user1.lastName = 'Ilic';
  user1.totalDonated = 231;
  user1.type = "Greenie";
  console.log(user1);
  console.log(wallet1);
  
  const userRegisty = await getParticipantRegistry(NS + '.User');
  await userRegisty.addAll([user1]);
  
  const walletRegisty = await getAssetRegistry(NS + '.Wallet');
  await walletRegisty.add(wallet1);
  await walletRegisty.add(wallet2);
  
  const actionRegisty = await getAssetRegistry(NS + '.Action');
  await actionRegisty.add(action);
}

/** Demo initialisation of assets and participants
* @param {org.GreenCity.Donation} Donation
* @transaction
*/
async function Donation(Donation)
{
  const factory = getFactory();
  
  var user = Donation.user;
  var action = Donation.action;
  const NS = 'org.GreenCity';
  const ammountDonated = Donation.ammount;
  console.log(user.wallet.balance + 'Pre izracunavanja user');
  console.log(action.wallet.balance + 'Pre izracunavanja action');
  if ((user.wallet.balance - ammountDonated) > 0)
  {
    user.wallet.balance -= ammountDonated;
    action.wallet.balance += ammountDonated;
    console.log(user.wallet.balance + 'Posle izracunavanja userWallet');
    console.log(action.wallet.balance + 'Posle izracunavanja actionWallet');   
    
    user.totalDonated += ammountDonated;
    
    const cheque = factory.newConcept(NS,'Cheque');
  	cheque.contributorEmail = user.email;
  	cheque.ammount = Donation.ammount;
    
    if (user.donations) {
        user.donations.push(Donation);
    } else {
        user.donations = [Donation];
    }
    if ((action.moneyNeeded - action.wallet.balance) < 0)
    {
     	 action.completed = true;
    }
    console.log(action.completed);
    
    if (action.contributors)
    {
      	action.contributors.push(cheque);
    }
    else
    {
      action.contributors = [cheque];
    }

    const userRegisty = await getParticipantRegistry(NS + '.User');
    await userRegisty.updateAll([user]);

    const assetRegisty = await getAssetRegistry(NS + '.Action');
    await assetRegisty.updateAll([action]);

    const walletRegisty = await getAssetRegistry(NS + '.Wallet');
    await walletRegisty.updateAll([user.wallet,action.wallet]);
  }
  
}