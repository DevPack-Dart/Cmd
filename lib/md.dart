import "package:c/src/md.quote.dart";
export "package:c/src/md.quote.dart";

abstract class CLIProfile{
  ///Can cli used quote in arguments, value of parameters, value of variable
  ///if false, `List<Quote> quoteChars` may be empty `<Quote>[]`
  late final bool canQuote;
  late final bool canUseShortAccumulated;
  late final bool canUseParameters;
  late final bool canUseValuables;
  final List<Quote> quoteChars;
  ///such as "\\" on "\\n" or "\\\"" or "\\t"; also can "$" instead of "\\"
  final String escapeChar;
  CLIProfile({required this.quoteChars, required this.escapeChar});
  static CLIProfile get defaults => ChetroStyle(
      quoteChars: [DoubleQuote()],
      escapeChar: "\""
    );
}
class ChetroStyle extends CLIProfile{
  @override
  final bool canQuote = true;
  @override
  final bool canUseShortAccumulated = false;
  @override
  final bool canUseParameters = true;
  @override
  final bool canUseValuables = true;
  ChetroStyle({required List<Quote> quoteChars, required String escapeChar}): super(quoteChars: quoteChars, escapeChar: escapeChar);
}
class PosixStyle extends CLIProfile{
  @override
  final bool canQuote = true;
  @override
  final bool canUseShortAccumulated = true;
  @override
  final bool canUseParameters = false;
  @override
  final bool canUseValuables = false;
}
class GNUStyle extends CLIProfile{
  @override
  final bool canQuote = true;
  @override
  final bool canUseShortAccumulated = true;
  @override
  final bool canUseParameters = true;
  @override
  final bool canUseValuables = false;
}

