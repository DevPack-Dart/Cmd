import "package:c/src/md.char.dart";

///Quote Char, a Bracket
abstract class Quote{
  final bool pair;
  Quote(this.pair);
  String cover(String str) => "${this.starts}$str${this.ends}";
  String uncover(String str);
  bool hasCoveringIn(String str) => str.startsWith(this.starts) && str.endsWith(this.ends);
  String get starts;
  String get ends;
  String show() {
    final n = AngleQuote().cover("Quote");
    return "$n${MarkChars.lf}starts: ${this.starts}${MarkChars.lf}ends:${this.ends}${MarkChars.lf}";}
}

///Symmetrical quote char, that start and end char are same, such as "'"
abstract class SymmetricalQuote extends Quote{
  final String char;
  SymmetricalQuote(this.char): super(false);
  @override
  String uncover(String str){
    if(this.hasCoveringIn(str)){
      return str.substring(this.char.length, str.length - (this.char.length * 2) + 1);
    }else{
      return str;
    }
  }
  @override
  @override
  String get starts => this.char;
  @override
  String get ends => this.char;
}
///natural double quotation mark "\""
class DoubleQuote extends SymmetricalQuote{
  DoubleQuote(): super(MarkChars.dqu);
}

///Asymmetrical quote char, pair of bra and ket such as "＜" and "＞" pair
abstract class AsymmetricalQuote extends Quote{
  final String begin;
  final String end;
  AsymmetricalQuote(this.begin, this.end): super(true);
  @override
  String uncover(String str){
    if(this.hasCoveringIn(str)){
      return str.substring(this.begin.length, str.length - (this.begin.length + this.end.length) + 1);
    }else{
      return str;
    }
  }
  @override
  String get starts => this.begin;
  @override
  String get ends => this.end;
}

class AngleQuote extends AsymmetricalQuote{
  AngleQuote(): super(MarkChars.aBra, MarkChars.aKet);
}