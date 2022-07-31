import Buffer "mo:base/Buffer";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

import Types "types";

actor {

  private stable var userStore: [(Nat, Types.UserInfoWithId)] = [];
  private stable var idCounter: Nat = 0;

  private var userIdToInfo: HashMap.HashMap<Nat, Types.UserInfoWithId> = HashMap.fromIter<Nat, Types.UserInfoWithId>(userStore.vals(), 0, Nat.equal, Hash.hash);

  public shared func createAccount(data: Types.UserInfo): async () {
    idCounter += 1;
    var id = idCounter;
    var result: Types.UserInfoWithId = {
      first_name = data.first_name;
      last_name = data.last_name;
      full_name = data.first_name # data.last_name;
      id = id;
      date = data.date;
      phone = data.phone;
      sex = data.sex;
      address = data.address;
    };
    userIdToInfo.put(id, result);
  };

  public shared query func readAccount(): async [Types.UserInfoWithId] {
    var result = Buffer.Buffer<Types.UserInfoWithId>(0);
    for (v in userIdToInfo.vals()){
      result.add(v)
    };

    return result.toArray();
  };

  public shared func updateAccount(data: Types.UserInfoWithId): async () {
    assert Option.isSome(userIdToInfo.get(data.id));
     var newData: Types.UserInfoWithId = {
      first_name = data.first_name;
      last_name = data.last_name;
      full_name = data.first_name # data.last_name;
      id = data.id;
      date = data.date;
      phone = data.phone;
      sex = data.sex;
      address = data.address;
    };
    userIdToInfo.put(data.id, newData);
  };

  public shared func deleteAccount(id: Nat) : async () {
    assert Option.isSome(userIdToInfo.get(id));
    var result = userIdToInfo.remove(id);
  };

  system func preupgrade() {
		userStore := Iter.toArray(userIdToInfo.entries());
	};
	
	system func postupgrade() {
		userStore := [];
	};
}
