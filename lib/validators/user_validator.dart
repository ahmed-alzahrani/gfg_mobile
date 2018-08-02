class UserValidator {
  UserValidator();

  // validates that a proper e-mail address has been entered
  bool isEmailAddressValid(String email) {
    RegExp exp = new RegExp (
      r"^[\w-.]+@([\w-]+.)+[\w-]{2,4}$",
      caseSensitive: false,
      multiLine: false,
    );
    return exp.hasMatch(email);
  }

  // TODO: Fix password valdiation regex, works in dartPad but not here
  /*
  bool isPasswordValid(String password) {
    print("checking this password for validity: $password");
    RegExp exp = new RegExp(
      r"^(?=.[A-Z])(?=.[\W])(?=.[0-9])(?=.[a-z]).{8,128}$",
    );
    print(exp.hasMatch(password).toString());
    return exp.hasMatch(password);
  }
  */

  bool isPasswordValid(String password) {
    print("password is: $password");
    return true;
  }
}