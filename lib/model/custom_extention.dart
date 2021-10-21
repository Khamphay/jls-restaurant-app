import "dart:convert";

class CustomExtention {
  final _prefix;
  final _message;

  CustomExtention([this._message, this._prefix]);

  String toString() {
    MessageExtention ex = MessageExtention.formatJson(jsonDecode(_message));
    return _prefix+ ex.message;
  }
}

class MessageExtention {
  final  message;
  MessageExtention(this.message);
  factory MessageExtention.formatJson(dynamic json) {
    return MessageExtention(json['message'] as String);
  }
}

class FetchDataExtention extends CustomExtention {
  FetchDataExtention([message]) : super(message, "Net Work Error: ");
}

class BadRequestExtention extends CustomExtention {
  BadRequestExtention([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedExtention extends CustomExtention {
  UnauthorizedExtention([message]) : super(message, "Authorized: ");
}

class InvalidRequestExtention extends CustomExtention {
  InvalidRequestExtention([message]) : super(message, "Invalid Input: ");
}
