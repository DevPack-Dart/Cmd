///Quote Char, a Bracket
abstract class Quote{
  final bool pair;
  Quote(this.pair);
  String cover(String str);
  String uncover(String str);
  bool hasCoveringIn(String str);
  String get starts;
  String get ends;
}

///Symmetrical quote char, that start and end char are same, such as "'"
abstract class SymmetricalQuote extends Quote{
  final String char;
  SymmetricalQuote(this.char): super(false);
  @override
  String cover(String str) => "${this.char}$str${this.char}";
  @override
  String uncover(String str){
    if(this.hasCoveringIn(str)){
      return str.substring(this.char.length, str.length - (this.char.length * 2) + 1);
    }else{
      return str;
    }
  }
  @override
  bool hasCoveringIn(String str) => str.startsWith(this.char) && str.endsWith(this.char);
  @override
  String get starts => this.char;
  @override
  String get ends => this.char;
}
///natural double quotation mark "\""
class DoubleQuote extends SymmetricalQuote{
  DoubleQuote(): super("\"");
}

///Asymmetrical quote char, pair of bra and ket such as "＜" and "＞" pair
abstract class AsymmetricalQuote extends Quote{
  final String begin;
  final String end;
  AsymmetricalQuote(this.begin, this.end): super(true);
  @override
  String cover(String str) => "${this.begin}$str${this.end}";
  @override
  String uncover(String str){
    if(this.hasCoveringIn(str)){
      return str.substring(this.begin.length, str.length - (this.begin.length + this.end.length) + 1);
    }else{
      return str;
    }
  }
  @override
  bool hasCoveringIn(String str) => str.startsWith(this.begin) && str.endsWith(this.end);
  @override
  String get starts => this.begin;
  @override
  String get ends => this.end;
}