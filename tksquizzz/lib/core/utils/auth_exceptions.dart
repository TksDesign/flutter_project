class AuthExceptions {
  AuthExceptions(this.message, {this.code = 'unknwon'});
  final String message;
  final String code;

  @override
  String toString() => 'AuthException: $message';
}

// Exceptions spécifiques
class EmailAlreadyExistsException extends AuthExceptions {
  EmailAlreadyExistsException() : super('Cet email est déjà utilisé');
}

class InvalidCredentialsException extends AuthExceptions {
  InvalidCredentialsException() : super('Email ou mot de passe incorrect');
}

class WeakPasswordException extends AuthExceptions {
  WeakPasswordException() : super('Le mot de passe est trop faible');
}
class InvalidLoginCredentialsException extends AuthExceptions {
  InvalidLoginCredentialsException() 
    : super('Email ou mot de passe incorrect', code: 'invalid_credentials');
}