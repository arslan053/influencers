class SignupWithEmailAndPasswordFailure {
  final String message;
  SignupWithEmailAndPasswordFailure(
      [this.message = "An Unknown Error Occured"]);
  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignupWithEmailAndPasswordFailure(
            'Please enter a strong password');
      case 'invalid-email':
        return SignupWithEmailAndPasswordFailure(
            'Email is not valid or badly formated');
      case 'email-already-in-use':
        return SignupWithEmailAndPasswordFailure(
            'An account already exists for this email');
      case 'operation-not-allowed':
        return SignupWithEmailAndPasswordFailure(
            'Operation not allowed. please contact support');
      case 'user-disabled':
        return SignupWithEmailAndPasswordFailure(
            'The user has been disabled. please contact support');
      default:
        return SignupWithEmailAndPasswordFailure();
    }
  }
}
