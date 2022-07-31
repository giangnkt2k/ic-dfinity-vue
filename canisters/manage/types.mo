module {
  public type UserInfo = {
    first_name: Text;
    last_name: Text;
    date: Text;
    phone: Text;
    sex: Bool;
    address: Text;
  };

  public type UserInfoWithId = {
    id: Nat;
    first_name: Text;
    last_name: Text;
    full_name: Text;
    date: Text;
    phone: Text;
    sex: Bool;
    address: Text;
  }
}
