import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// creating a Canister basically
actor dbank_backend {

  // using the Time module from the motoko base libarry,
  // to use the current time in our program
  stable var startTime = Time.now();
  Debug.print("Number of nanoseconds since 1st January 1970 - ");
  Debug.print(debug_show (startTime));

  // declaring and defining a variable
  // var currentValue = 300;

  // orthogonally persisitence variable
  // kind of like the static keyword in C language
  stable var currentValue = 300 : Float;

  // modifying a variable
  // currentValue := 100;

  // let is same as 'const' in javaScript
  // cannot be modified
  // let id = 873245623;

  // to print "hello" in console
  // had to import a library "Debug"
  Debug.print("hello");

  // print in general prints a text formatted output in console.
  // in order to print a 'nat' (natural number), we have change the syntax as we did below -
  Debug.print(debug_show (currentValue));
  // Debug.print(debug_show(id));

  // private functions cannot be accessed from outside the canister

  public func TopUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  // public function can be called from the command line
  // 'dfx canister call app_backend ToDown'
  public func TopDown(amount : Float) {

    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Insufficient Balance.");
    };
  };

  // calling function inside the cannister
  // TopUp();

  // Above, we were actually updating the data in the block/Canister, using update calls.
  // so that is why it runs very slowly .
  // if we just wanna read a value from the Canister/block , we can use the query calls.

  // we must provide the return type asynchronously.
  // asynchronously -> which is not effected by any other calls.
  // it is independent and fast.
  // "query" keyword.
  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 10 ** 9;
    let rate = 0.0001;
    currentValue := (currentValue) * ((1 + rate) ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };

  public func reset() {
    currentValue := 100;
    startTime := Time.now();
  }

};
