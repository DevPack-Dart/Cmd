import "package:c/src/md.char.dart";
import "package:c/src/md.quote.dart";

export "package:c/src/md.quote.dart";
export "package:c/src/md.char.dart";

abstract class CLIProfile{
  ///Can cli used quote in arguments, value of parameters, value of variable
  ///if false, `List<Quote> quoteChars` may be empty `<Quote>[]`
  final bool canQuote;
  final bool canUseShortAccumulated;
  final bool canUseParameters;
  final bool canUseValuables;
  final List<CLIEntryFormat> entries;
  final List<Quote> quoteChars;
  ///such as "\\" on "\\n" or "\\\"" or "\\t"; also can "$" instead of "\\"
  final String spaceChar;
  final String escapeChar;
  CLIProfile({
    required this.canQuote,
    required this.canUseShortAccumulated,
    required this.canUseParameters,
    required this.canUseValuables,
    required this.entries,
    required this.quoteChars,
    required this.escapeChar,
    required this.spaceChar
  });
  bool isEscapedLoc(int escLoc, int targetLoc) => (targetLoc - escLoc) == this.escapeChar.length;
  String show() => [
      this.canQuote ? "Yes, Can Quote" : "No, Can Not Quote",
      this.canUseShortAccumulated ? "Yes, Can Use Short Accumulated" : "No, Can Not Use Short Accumulated",
      this.canUseParameters ? "Yes, Can Use Parameters" : "No, Can Not Use Parameters",
      this.canUseValuables ? "Yes, Can Use Valuables" : "No, Can Not Use Valuables",
      this.entries.map((CLIEntryFormat ef) => ef.show()).join(MarkChars.lf),
      this.quoteChars.map((Quote q) => q.show()).join(MarkChars.lf),
      "Escape Char: " + this.escapeChar,
      "Space Char: " + this.spaceChar
    ].join(MarkChars.lf);
  static CLIProfile get defaults => ChetroStyle(
      quoteChars: [DoubleQuote()],
      escapeChar: MarkChars.bsl
    );
}
class CLIEntryFormat{
  final String name;
  final String starts;
  final bool valueAvailable;
  final bool valueRequired;
  final bool valueOnly;
  final String delime;
  const CLIEntryFormat(
      this.name,
      this.starts,
      this.valueAvailable,
      this.valueRequired,
      this.valueOnly,
      this.delime
    );
  String show(){
    final d = (this.valueAvailable & !this.valueOnly) ? "${MarkChars.lf}delime: ${this.delime}" : "";
    final n = AngleQuote().cover(this.name);
    final rq = this.valueRequired ? "Required" : "Optional";
    final vo = this.valueOnly ? "; Only" : "";
    final va = this.valueAvailable ? "Available; $rq$vo" : "";
    return """$n
    starts: $starts
    value: $va$d""";
  }
}
class ChetroStyle extends CLIProfile{
  ChetroStyle({required List<Quote> quoteChars, required String escapeChar}): super(
      canQuote: true,
      canUseShortAccumulated: false,
      canUseParameters: true,
      canUseValuables: true,
      entries: [
        CLIEntryFormat(
          "option",
          MarkChars.dot,
          true,
          true,
          false,
          MarkChars.eq
        ),
        CLIEntryFormat(
          "flag",
          MarkChars.exc,
          false,
          false,
          false,
          ""
        ),
        CLIEntryFormat(
          "variable",
          MarkChars.amp,
          true,
          false,
          false,
          MarkChars.eq
        ),
        CLIEntryFormat(
          "argument",
          "",
          true,
          true,
          true,
          ""
        ),
      ],
      quoteChars: quoteChars,
      escapeChar: escapeChar,
      spaceChar: MarkChars.sp
    );
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

